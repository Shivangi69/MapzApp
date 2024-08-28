//
//  CameraService.swift
//  SwiftCamera
//
//  Created by Rolando Rodriguez on 10/15/20.
//

import Foundation
import Combine
import AVFoundation
import Photos
import UIKit
import Alamofire
//  MARK: Class Camera Service, handles setup of AVFoundation needed for a basic camera app.
public struct Photo: Identifiable, Equatable {
//    The ID of the captured photo
    public var id: String
//    Data representation of the captured photo
    public var originalData: Data
    
    public init(id: String = UUID().uuidString, originalData: Data) {
        self.id = id
        self.originalData = originalData
    }
}

public struct AlertError {
    public var title: String = ""
    public var message: String = ""
    public var primaryButtonTitle = "Accept"
    public var secondaryButtonTitle: String?
    public var primaryAction: (() -> ())?
    public var secondaryAction: (() -> ())?
    
    public init(title: String = "", message: String = "", primaryButtonTitle: String = "Accept", secondaryButtonTitle: String? = nil, primaryAction: (() -> ())? = nil, secondaryAction: (() -> ())? = nil) {
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryAction = secondaryAction
    }
}

extension Photo {
    public var compressedData: Data? {
        ImageResizer(targetWidth: 800).resize(data: originalData)?.jpegData(compressionQuality: 0.5)
    }
    public var thumbnailData: Data? {
        ImageResizer(targetWidth: 100).resize(data: originalData)?.jpegData(compressionQuality: 0.5)
    }
    public var thumbnailImage: UIImage? {
        guard let data = thumbnailData else { return nil }
        return UIImage(data: data)
    }
    public var image: UIImage? {
        guard let data = compressedData else { return nil }
        return UIImage(data: data)
    }
}

public class CameraService {
    typealias PhotoCaptureSessionID = String
    
//    MARK: Observed Properties UI must react to
    
//    1.
    @Published public var flashMode: AVCaptureDevice.FlashMode = .off
//    2.
    @Published public var shouldShowAlertView = false
//    3.
    @Published public var shouldShowSpinner = false
//    4.
    @Published public var willCapturePhoto = false
//    5.
   // @Published public var isCameraButtonDisabled = true
//    6.
    @Published public var isCameraUnavailable = true
//    8.
    @Published public var photo: Photo?
    @Published public var shouldShowtoastView = false


//    MARK: Alert properties
    public var alertError: AlertError = AlertError()
    
// MARK: Session Management Properties
    
//    9
    public let session = AVCaptureSession()
//    10
    var isSessionRunning = false
//    12
    var isConfigured = false
//    13
    var setupResult: SessionSetupResult = .success
//    14
    // Communicate with the session and other session objects on this queue.
    private let sessionQueue = DispatchQueue(label: "session queue")
    
    @objc dynamic var videoDeviceInput: AVCaptureDeviceInput!
    
    // MARK: Device Configuration Properties
    private let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInDualCamera, .builtInTrueDepthCamera], mediaType: .video, position: .unspecified)
    
    // MARK: Capturing Photos
    
    private let photoOutput = AVCapturePhotoOutput()
    
    private var inProgressPhotoCaptureDelegates = [Int64: PhotoCaptureProcessor]()
    
    // MARK: KVO and Notifications Properties
    
    private var keyValueObservations = [NSKeyValueObservation]()
    
    
    public func configure() {
 
        sessionQueue.async {
            self.configureSession()
        }
    }
    
    //        MARK: Checks for user's permisions
    public func checkForPermissions() {
      
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // The user has previously granted access to the camera.
            break
        case .notDetermined:
          
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if !granted {
                    self.setupResult = .notAuthorized
                }
                self.sessionQueue.resume()
            })
            
        default:
            // The user has previously denied access.
            setupResult = .notAuthorized
            
            DispatchQueue.main.async {
                self.alertError = AlertError(title: "Camera Access", message: "SwiftCamera doesn't have access to use your camera, please update your privacy settings.", primaryButtonTitle: "Settings", secondaryButtonTitle: nil, primaryAction: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                                  options: [:], completionHandler: nil)
                    
                }, secondaryAction: nil)
                self.shouldShowAlertView = true
                self.isCameraUnavailable = true
                //self.isCameraButtonDisabled = true
            }
        }
    }
    
    //  MARK: Session Management
    
    // Call this on the session queue.
    /// - Tag: ConfigureSession
    private func configureSession() {
        if setupResult != .success {
            return
        }
        
        session.beginConfiguration()
        
        session.sessionPreset = .photo
        
        // Add video input.
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
                // If a rear dual camera is not available, default to the rear wide angle camera.
                defaultVideoDevice = backCameraDevice
            } else if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                // If the rear wide angle camera isn't available, default to the front wide angle camera.
                defaultVideoDevice = frontCameraDevice
            }
            
            guard let videoDevice = defaultVideoDevice else {
                print("Default video device is unavailable.")
                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
            
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
                
            } else {
                print("Couldn't add video device input to the session.")
                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
        } catch {
            print("Couldn't create video device input: \(error)")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        // Add the photo output.
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
            
            photoOutput.isHighResolutionCaptureEnabled = true
            photoOutput.maxPhotoQualityPrioritization = .quality
            
        } else {
            print("Could not add photo output to the session")
            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        session.commitConfiguration()
        
        self.isConfigured = true
        
        self.start()
    }
 
    //  MARK: Device Configuration
    
    /// - Tag: ChangeCamera
    public func changeCamera() {
        //   MARK: Here disable all camera operation related buttons due to configuration is due upon and must not be interrupted
        
        
        DispatchQueue.main.async {
            //self.isCameraButtonDisabled = true
        }
        //
        
        sessionQueue.async {
            let currentVideoDevice = self.videoDeviceInput.device
            let currentPosition = currentVideoDevice.position
            
            let preferredPosition: AVCaptureDevice.Position
            let preferredDeviceType: AVCaptureDevice.DeviceType
            
            switch currentPosition {
            case .unspecified, .front:
                preferredPosition = .back
                preferredDeviceType = .builtInWideAngleCamera
                
            case .back:
                preferredPosition = .front
                preferredDeviceType = .builtInWideAngleCamera
                
            @unknown default:
                print("Unknown capture position. Defaulting to back, dual-camera.")
                preferredPosition = .back
                preferredDeviceType = .builtInWideAngleCamera
            }
            let devices = self.videoDeviceDiscoverySession.devices
            var newVideoDevice: AVCaptureDevice? = nil
            
            // First, seek a device with both the preferred position and device type. Otherwise, seek a device with only the preferred position.
            if let device = devices.first(where: { $0.position == preferredPosition && $0.deviceType == preferredDeviceType }) {
                newVideoDevice = device
            } else if let device = devices.first(where: { $0.position == preferredPosition }) {
                newVideoDevice = device
            }
            
            if let videoDevice = newVideoDevice {
                do {
                    let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                    
                    self.session.beginConfiguration()
                    
                    // Remove the existing device input first, because AVCaptureSession doesn't support
                    // simultaneous use of the rear and front cameras.
                    self.session.removeInput(self.videoDeviceInput)
                    
                    if self.session.canAddInput(videoDeviceInput) {
                        self.session.addInput(videoDeviceInput)
                        self.videoDeviceInput = videoDeviceInput
                    } else {
                        self.session.addInput(self.videoDeviceInput)
                    }
                    
                    if let connection = self.photoOutput.connection(with: .video) {
                        if connection.isVideoStabilizationSupported {
                            connection.preferredVideoStabilizationMode = .auto
                        }
                    }
                    
                    self.photoOutput.maxPhotoQualityPrioritization = .quality
                    
                    self.session.commitConfiguration()
                } catch {
                    print("Error occurred while creating video device input: \(error)")
                }
            }
            
            DispatchQueue.main.async {
//                MARK: Here enable capture button due to successfull setup
                //self.isCameraButtonDisabled = false
            }
        }
    }
    
    public func focus(at focusPoint: CGPoint){
//        let focusPoint = self.videoPreviewLayer.captureDevicePointConverted(fromLayerPoint: point)

        let device = self.videoDeviceInput.device
        do {
            try device.lockForConfiguration()
            if device.isFocusPointOfInterestSupported {
                device.focusPointOfInterest = focusPoint
                device.exposurePointOfInterest = focusPoint
                device.exposureMode = .continuousAutoExposure
                device.focusMode = .continuousAutoFocus
                device.unlockForConfiguration()
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    /// - Tag: Stop capture session
    
    public func stop(completion: (() -> ())? = nil) {
        sessionQueue.async {
            if self.isSessionRunning {
                if self.setupResult == .success {
                    self.session.stopRunning()
                    self.isSessionRunning = self.session.isRunning
                    
                    if !self.session.isRunning {
                        DispatchQueue.main.async {
                            //self.isCameraButtonDisabled = true
                            self.isCameraUnavailable = true
                            completion?()
                        }
                    }
                }
            }
        }
    }
    
    /// - Tag: Start capture session
    
    public func start() {
//        We use our capture session queue to ensure our UI runs smoothly on the main thread.
        sessionQueue.async {
            if !self.isSessionRunning && self.isConfigured {
                switch self.setupResult {
                case .success:
                    self.session.startRunning()
                    self.isSessionRunning = self.session.isRunning
                    
                    if self.session.isRunning {
                        DispatchQueue.main.async {
                            //self.isCameraButtonDisabled = false
                            self.isCameraUnavailable = false
                        }
                    }
                    
                case .configurationFailed, .notAuthorized:
                    print("Application not authorized to use camera")

                    DispatchQueue.main.async {
                        self.alertError = AlertError(title: "Camera Error", message: "Camera configuration failed. Either your device camera is not available or its missing permissions", primaryButtonTitle: "Accept", secondaryButtonTitle: nil, primaryAction: nil, secondaryAction: nil)
                        self.shouldShowAlertView = true
                        //self.isCameraButtonDisabled = true
                        self.isCameraUnavailable = true
                    }
                }
            }
        }
    }
    
    public func set(zoom: CGFloat){
        let factor = zoom < 1 ? 1 : zoom
        let device = self.videoDeviceInput.device
        
        do {
            try device.lockForConfiguration()
            device.videoZoomFactor = factor
            device.unlockForConfiguration()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //    MARK: Capture Photo
    
    /// - Tag: CapturePhoto
//    public func capturePhoto() {
//        if self.setupResult != .configurationFailed {
//            //self.isCameraButtonDisabled = true
//            
//            sessionQueue.async {
//                if let photoOutputConnection = self.photoOutput.connection(with: .video) {
//                    photoOutputConnection.videoOrientation = .portrait
//                }
//                var photoSettings = AVCapturePhotoSettings()
//                
//                // Capture HEIF photos when supported. Enable according to user settings and high-resolution photos.
//                if  self.photoOutput.availablePhotoCodecTypes.contains(.hevc) {
//                    photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
//                }
//                
//                // Sets the flash option for this capture.
//                if self.videoDeviceInput?.device.isFlashAvailable {
//                    photoSettings.flashMode = self.flashMode
//                }
//                
//                photoSettings.isHighResolutionPhotoEnabled = true
//                
//                // Sets the preview thumbnail pixel format
//                if !photoSettings.__availablePreviewPhotoPixelFormatTypes.isEmpty {
//                    photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoSettings.__availablePreviewPhotoPixelFormatTypes.first!]
//                }
//                
//                photoSettings.photoQualityPrioritization = .quality
//                
//                let photoCaptureProcessor = PhotoCaptureProcessor(with: photoSettings, willCapturePhotoAnimation: { [weak self] in
//                    // Tells the UI to flash the screen to signal that SwiftCamera took a photo.
//                    DispatchQueue.main.async {
//                        self?.willCapturePhoto = true
//                    }
//                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//                        self?.willCapturePhoto = false
//                    }
//                    
//                }, completionHandler: { [weak self] (photoCaptureProcessor) in
//                    // When the capture is complete, remove a reference to the photo capture delegate so it can be deallocated.
//                    if let data = photoCaptureProcessor.photoData {
//                        let img: UIImage = UIImage(data: data)!
//                        let imgdata = img.jpegData(compressionQuality: 0.5)
//
//                        self?.photo = Photo(originalData: data)
//                        
//                        print("passing photo")
//                       // let filename = self.p
//
//                        self!.uploadInBackground(fileInData: photoCaptureProcessor.photoUrl!)
//                    } else {
//                        print("No photo data")
//                    }
//                    
//                   // self?.isCameraButtonDisabled = false
//                    
//                    self?.sessionQueue.async {
//                        self?.inProgressPhotoCaptureDelegates[photoCaptureProcessor.requestedPhotoSettings.uniqueID] = nil
//                    }
//                }, photoProcessingHandler: { [weak self] animate in
//                    // Animates a spinner while photo is processing
//                    if animate {
//                        self?.shouldShowSpinner = true
//                    } else {
//                        self?.shouldShowSpinner = false
//                    }
//                })
//                
//                // The photo output holds a weak reference to the photo capture delegate and stores it in an array to maintain a strong reference.
//                self.inProgressPhotoCaptureDelegates[photoCaptureProcessor.requestedPhotoSettings.uniqueID] = photoCaptureProcessor
//                self.photoOutput.capturePhoto(with: photoSettings, delegate: photoCaptureProcessor)
//            }
//        }
//    }
    
    
    
//    import AVFoundation

    public func capturePhoto() {
        // Check camera authorization status
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        guard status == .authorized else {
            print("Camera access denied")
            return
        }
        
        if self.setupResult != .configurationFailed {
            sessionQueue.async {
                if let photoOutputConnection = self.photoOutput.connection(with: .video) {
                    photoOutputConnection.videoOrientation = .portrait
                }
                var photoSettings = AVCapturePhotoSettings()
                
                // Capture HEIF photos when supported. Enable according to user settings and high-resolution photos.
                if self.photoOutput.availablePhotoCodecTypes.contains(.hevc) {
                    photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
                }
                
                // Check if flash is available before setting the flash mode
                if let device = self.videoDeviceInput?.device, device.isFlashAvailable {
                    photoSettings.flashMode = self.flashMode
                }
                
                photoSettings.isHighResolutionPhotoEnabled = true
                
                // Sets the preview thumbnail pixel format
                if !photoSettings.__availablePreviewPhotoPixelFormatTypes.isEmpty {
                    photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoSettings.__availablePreviewPhotoPixelFormatTypes.first!]
                }
                
                photoSettings.photoQualityPrioritization = .quality
                
                let photoCaptureProcessor = PhotoCaptureProcessor(with: photoSettings, willCapturePhotoAnimation: { [weak self] in
                    // Tells the UI to flash the screen to signal that SwiftCamera took a photo.
                    DispatchQueue.main.async {
                        self?.willCapturePhoto = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self?.willCapturePhoto = false
                    }
                    
                }, completionHandler: { [weak self] (photoCaptureProcessor) in
                    // When the capture is complete, remove a reference to the photo capture delegate so it can be deallocated.
                    if let data = photoCaptureProcessor.photoData {
                        let img: UIImage = UIImage(data: data)!
                        let imgdata = img.jpegData(compressionQuality: 0.5)

                        self?.photo = Photo(originalData: data)
                        
                        print("passing photo")
                        self?.uploadInBackground(fileInData: photoCaptureProcessor.photoUrl!)
                    } else {
                        print("No photo data")
                    }
                    
                    self?.sessionQueue.async {
                        self?.inProgressPhotoCaptureDelegates[photoCaptureProcessor.requestedPhotoSettings.uniqueID] = nil
                    }
                }, photoProcessingHandler: { [weak self] animate in
                    // Animates a spinner while photo is processing
                    if animate {
                        self?.shouldShowSpinner = true
                    } else {
                        self?.shouldShowSpinner = false
                    }
                })
                
                // The photo output holds a weak reference to the photo capture delegate and stores it in an array to maintain a strong reference.
                self.inProgressPhotoCaptureDelegates[photoCaptureProcessor.requestedPhotoSettings.uniqueID] = photoCaptureProcessor
                self.photoOutput.capturePhoto(with: photoSettings, delegate: photoCaptureProcessor)
            }
        }
    }

    
//    func Uploadphoto(){
//        Alamofire.upload(multipartFormData: { multipart in
//            multipart.append(fileData, withName: "payload", fileName: "someFile.jpg", mimeType: "image/jpeg")
//            multipart.append("comment".data(using: .utf8)!, withName :"comment")
//        }, to: "http://167.86.105.98:7723/api/Upload/upload", method: .post, headers: nil) { encodingResult in
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.response { answer in
//                    print("statusCode: \(answer.response?.statusCode)")
//                }
//                upload.uploadProgress { progress in
//                    //call progress callback here if you need it
//                }
//            case .failure(let encodingError):
//                print("multipart upload encodingError: \(encodingError)")
//            }
//        }
//
//
//
//
//
//    }
    
    
//    func upload(image: UIImage, guid: String, completionHandler: @escaping (String) -> Void) {
//            let userDefaults = UserDefaults.standard
//            let accessToken = userDefaults.string(forKey: "access_token") ?? ""
//
//            let parameters = ["name": "bild", "Content-Type": "image/png"]
//
//            let url = URL(string: "http://<<<upload-url>>>")!
//
//            let imgData = image.pngData()!
//            Alamofire.upload(multipartFormData: { multiPart in
//                multiPart.append(Data("one".utf8), withName: "one")
//                multiPart.append(imgData, withName: "file", fileName: "file.png", mimeType: "image/png")
//                for (key, value) in parameters {
//                    multiPart.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                }
//            }, to: url, method: .post, interceptor: AFRequestInterceptor(accessToken: accessToken))
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//            .response(completionHandler: { response in
//                debugPrint(response)
//            })
//
//            completionHandler("return")
//        }
    
    
    func uploadInBackground(fileInData: URL) {
        
        
//        let evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""
//
//        let parameters = [
//              "EventId": evntId,
//            "UserId": UserDefaults.standard.string(forKey: "id") ?? ""
//              ,
//                "Groupid1" : "12",
//                "IsGroup1" : "true"
//            ]
        var groupid = String()
        var isgroupid = String()
//
        var ISfromGroup =            UserDefaults.standard.string(forKey: "isGroup")
//        UserDefaults.standard.set("yes", forKey: "isGroup")

        if ISfromGroup == "yes"{
            groupid = UserDefaults.standard.string(forKey: "groupId") ?? ""
            isgroupid = "true"
        }else{
            groupid = "0"
            isgroupid = "false"
        }
        let evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""
        let parameters = [
              "EventId": evntId,
            "UserId": UserDefaults.standard.string(forKey: "id") ?? "",
              "Groupid1" : groupid,
              "IsGroup1" : isgroupid
              
            ]
    print(parameters)
        let headers: HTTPHeaders
            headers = ["Content-type": "multipart/form-data",
                       "Content-Disposition" : "form-data"]
            
//            let headers: [String : String] = [ "Authorization": "key"]
        let baseURL = URL(string: "http://mapzapp.com/api/Upload/uploadeventdiary")
        print(baseURL!)

            Networking.sharedInstance.backgroundSessionManager.upload(multipartFormData: { (multipartFormData) in
               
               // multipartFormData.append(fileInData, withName: "files", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")

                multipartFormData.append(fileInData, withName: "files", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")

                for (key, value) in parameters {
                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
                       }
            }, usingThreshold: UInt64.init(), to: baseURL!, method: .post, headers: headers)
            
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    ///api/Upload/upload
                    upload.uploadProgress(closure: { (progress) in
                        //Print progress
                        let value =  Int(progress.fractionCompleted * 100)
                        print("\(value) %")
                    })
                    
                    upload.responseJSON { response in
                        //print response.result
                        print(response.description)
                        let res = response.response?.statusCode
                        print(res!)
                        self.shouldShowtoastView.toggle()
                        Toast(text: "Upload Successfully").show()
                    }
                    
                case .failure(let encodingError):
                    //print encodingError.description
                    print(encodingError.localizedDescription)
                }
            }
        }

    
    
}
class Networking {
    static let sharedInstance = Networking()
    public var sessionManager: Alamofire.SessionManager // most of your web service clients will call through sessionManager
    public var backgroundSessionManager: Alamofire.SessionManager // your web services you intend to keep running when the system backgrounds your app will use this
    private init() {
        let defaultConfig = URLSessionConfiguration.default
        defaultConfig.timeoutIntervalForRequest = 500
        
        
        let backgroundConfig = URLSessionConfiguration.background(withIdentifier: "com.lava.app.backgroundtransfer")
        backgroundConfig.timeoutIntervalForRequest = 500
        
//        self.sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        self.sessionManager = Alamofire.SessionManager(configuration: defaultConfig)
        self.backgroundSessionManager = Alamofire.SessionManager(configuration: backgroundConfig)
        
    }
}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
