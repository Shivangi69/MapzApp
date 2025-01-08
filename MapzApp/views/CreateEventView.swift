//
//  CreateEventView.swift
//  MapzApp
//
//  Created by Misha Infotech on 16/09/2021.
//

import SwiftUI
import Combine
import AVFoundation
import Alamofire
import Photos
import SimpleToast


struct CreateEventView: View {
   //
    @State var events = UserEvents()
    @Environment(\.presentationMode) var presentationMode
    @State var showupdateview = false
    @State private var timer = 5
    @State private var onComplete = false
    @State private var recording = false
    var recordingView = PreviewView()
    @State  var showingAlert = false
    @State  var message = String()
    @ObservedObject var vm = VoiceViewModel()
    @State var  eventNOE =  UserDefaults.standard.string(forKey: "eventNOE")
    @State var  fromwhere =  UserDefaults.standard.string(forKey: "fromwhere")
    @State private var showingList = false
   // @State private var showingAlert = false
    @State private var yoff = 0
    @State private var effect1 = false
    @State private var effect2 = false
    @State private var showCameraPopUp = false
    @State private var showVideoPopUp = false
    @State private var showrecdPopUp = false
    @State private var showdocPopUp = false
    @State private var showMaimPopUp = false
    @State var showToast: Bool = false
   // @State var message: String = ""
    @State  var shakeCountDown: Timer?

    @State var recorded = 0
    @State  var secondsToReachGoal = 15
   
    @State private var service = CameraService()
    private let toastOptions = SimpleToastOptions(
        alignment: .bottom, hideAfter: 5, showBackdrop: false
        
    )
 var body: some View {
        ZStack{
            VStack(spacing: 0.0) {

                HStack(spacing: 20.0) {
                    Button(action: {
                        if (eventNOE == "New"){
                            message = "If you go back to home screen current event will be discard. You Want to Processed?"
                            showingAlert = true
                            // self.deleteevent()
                        }else{
                            showMaimPopUp = true
                        }
                    })
                    
                    {
                        Image("icons8-back-24")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 40.0, height: 40.0)
                    .fullScreenCover(isPresented: $showMaimPopUp, content: MainView.init)
                    
                    VStack(alignment: .leading){
                       
                        Text((UserDefaults.standard.string(forKey: "Address") ?? ""))
                            .foregroundColor(Color.white)
                            .font(.custom("Inter-Regular", size: 15))
                        
                        Text(UserDefaults.standard.string(forKey: "datestr") ?? "")
                            .foregroundColor(Color.white)
                            .font(.custom("Inter-Regular", size: 15))
                    }
                    Spacer()
                    
                    Button(action: {
                        showupdateview.toggle()
                    }) {
                        Text("Save")
                            .foregroundColor(Color.white)
                            .font(.custom("Inter-Regular", size: 15))
                        
                        Image("icons8-plus-+-24 (1)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(height: 30)
                    .fullScreenCover(isPresented: $showupdateview, content: UpdatepartyDetails.init)
                
                }
                
                .frame(height: 60.0)
                .background(Color("themecolor"))
                
                if $showCameraPopUp.wrappedValue {
                    CameraViewa()
                        .frame(width: UIScreen.main.bounds.width)
                    
                }
                
                if $showVideoPopUp.wrappedValue {
                    
//                    ZStack{
//                        Spacer().frame(height: -75) // Push down the content
// tried offset view change yellow color to clear color
                        CameraView(events: events, applicationName: "SwiftUICam")
                        .background(Color.black)
//                            .offset(y:-75)
//                            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 3.2)
//                    }
                }
                if $showrecdPopUp.wrappedValue {
                    VStack{
                        Spacer()
                        VStack(alignment : .leading , spacing : -5){
                            HStack (spacing : 3) {
                                Image(systemName: vm.isRecording && vm.toggleColor ? "circle.fill" : "circle")
                                    .font(.system(size:10))
                                    .foregroundColor(.red)
                                Text("Rec")
                                    .font(.system(size:20))
                                    .foregroundColor(.red)
                            }
                            
                            Text(vm.timer)
                                .font(.system(size:60))
                                .foregroundColor(.white)
                        }.frame(width: UIScreen.main.bounds.width)
                        Spacer()
                    }
                    .padding(.all)
                    .background(Color.black)
                    .frame(width: UIScreen.main.bounds.width)
                    
                    
                }
                HStack{
                   
                    Button(action: {
                        showVideoPopUp = false
                        showrecdPopUp = false
                        showdocPopUp = false
                        showCameraPopUp = true
                        yoff = -70
                    }, label: {
                        HStack {
                            Text("Camera")
                                .foregroundColor(.white)
                        }
                        
                    })
                    Spacer()
                    Button(action: {
                        showVideoPopUp = true
                        showrecdPopUp = false
                        showdocPopUp = false
                        showCameraPopUp = false
                        yoff = 0
                    }, label: {
                        HStack {
                            Text("Video")
                                .foregroundColor(.white)
                        }
                    })
                    Spacer()
                    
                    Button(action: {
                        showVideoPopUp = false
                        showrecdPopUp = true
                        showdocPopUp = false
                        showCameraPopUp = false
                        yoff = 0
                    }, label: {
                        HStack {
                            Text("Mic")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        }
                    })
                    Spacer()
                    
                    Button(action: {
                        
                        showdocPopUp = true
                        yoff = 0
                    }, label: {
                        HStack {
                            Text("Notes")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        }
                        
                    })
               
                }
                .padding(.horizontal)
                .background(Color("themecolor"))
                .frame(height: 20)
                .offset(y : CGFloat(yoff))
                .fullScreenCover(isPresented: $showdocPopUp, content: {
                    createNotes()
                })
              
                if $showVideoPopUp.wrappedValue {
                    HStack {
                        Spacer()
                        
                        CameraInterfaceView(events: events)
                            .onAppear {
                                           // Initialize the video view or camera session
                                       }
                                       .onDisappear {
                                           // Release resources to avoid memory leaks
                                       }
//
                        Spacer()
                    } .frame(width: UIScreen.main.bounds.width, height: 70, alignment: .center)
                    
                        .background(Color("themecolor"))
                    
                }
                if $showrecdPopUp.wrappedValue {
                    HStack {
                      
                        Image(systemName: vm.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 45))
                            .onTapGesture {
                                if vm.isRecording == true {
                                    vm.stopRecording()
                                } else {
                                    vm.startRecording()
                                    
                                }
                            }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 70, alignment: .center)
                    .background(Color("themecolor"))
                    
                }
            }
            .simpleToast(isPresented: $service.shouldShowtoastView, options: toastOptions) {
                HStack {
                    Text("Upload Successfully")
                }
                .padding()
                .background(Color.red.opacity(0.8))
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }
            
            .simpleToast(isPresented: $service.shouldShowtoastView, options: toastOptions) {
                HStack {
                    
                    Text("Upload Successfully")
                }
                .padding()
                .background(Color.red.opacity(0.8))
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .alert(isPresented:$showingAlert) {
            Alert(
                title: Text("Do you want to Exit?"),
                message: Text(message),
                primaryButton: .destructive(Text("Ok")) {
                    print("Deleting...")
                    deleteevent()
                },
                secondaryButton: .cancel()
            )
        }
        
     
        .onAppear(){
            if (fromwhere == "camera"){
                yoff = -70
                showCameraPopUp = true
            }
            else if (fromwhere == "video"){
                yoff = 0
                showVideoPopUp = true
            }
            else if (fromwhere == "audio"){
                yoff = 0
                showrecdPopUp = true
            }
            else
            if (fromwhere == "notes"){
                yoff = 0
                showdocPopUp = true
            }
            else{
                yoff = -70
                showCameraPopUp = true
            }
        }
    }
    
    func deleteevent(){
        let str = UserDefaults.standard.string(forKey: "eventID") ?? ""
        
        var checData: Parameters {
            [
                "id": str,
                
            ]
        }
        print(checData)
        AccountAPI.signin(servciename: "EventDiary/DeleteEventDiary", checData) { res in
            switch res {
            case .success:
                print("resulllll",res)
                if let json = res.value{
                    
                }
                presentationMode.wrappedValue.dismiss()
            case let .failure(error):
                print(error)
            }
        }
    }
}

struct CameraInterfaceView: View, CameraActions {
    @ObservedObject var events: UserEvents
    
    var captureButton: some View {
            Button(action: {
                self.toggleVideoRecording(events: events)
               // self.takePhoto(events: events)
            }, label: {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60, alignment: .center)
                    .overlay(
                        Circle()
                            .stroke(Color.black.opacity(0.8), lineWidth: 2)
                            .frame(width: 45, height: 45, alignment: .center)
                    )
            })
        }
    
    
    var body: some View {
        VStack {
            captureButton
            }
        }
    }


struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}

final class CameraModel: ObservableObject {
    private let service = CameraService()
    
    @Published var photo: Photo!
    
    @Published var showAlertError = false
    @Published var showtoast = false

    @Published var isFlashOn = false
    
    @Published var willCapturePhoto = false
    
    var alertError: AlertError!
    
    var session: AVCaptureSession
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.session = service.session
        
        service.$photo.sink { [weak self] (photo) in
            guard let pic = photo else { return }
            self?.photo = pic
        }
        .store(in: &self.subscriptions)
        
        service.$shouldShowAlertView.sink { [weak self] (val) in
            self?.alertError = self?.service.alertError
            self?.showAlertError = val
        }
        .store(in: &self.subscriptions)
        
        service.$flashMode.sink { [weak self] (mode) in
            self?.isFlashOn = mode == .on
        }
        .store(in: &self.subscriptions)
        
        service.$willCapturePhoto.sink { [weak self] (val) in
            self?.willCapturePhoto = val
        }
        .store(in: &self.subscriptions)
    }
    
    func configure() {
        service.checkForPermissions()
        service.configure()
    }
    
    func capturePhoto() {
        service.capturePhoto()
    }
    
    func flipCamera() {
        service.changeCamera()
    }
    
    func zoom(with factor: CGFloat) {
        service.set(zoom: factor)
    }
    
    func switchFlash() {
        service.flashMode = service.flashMode == .on ? .off : .on
    }
}

struct CameraViewa: View {
    @StateObject var model = CameraModel()

    @State var currentZoomFactor: CGFloat = 1.0

    var captureButton: some View {
        Button(action: {
            model.capturePhoto()
        }, label: {
            Circle()
                .foregroundColor(.white)
                .frame(width: 60, height: 60, alignment: .center)
                .overlay(
                    Circle()
                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
                        .frame(width: 45, height: 45, alignment: .center)
                )
        })
    }

    var capturedPhotoThumbnail: some View {
        Group {
            if model.photo != nil {
                Image(uiImage: model.photo.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .animation(.spring())

            } else {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 60, height: 60, alignment: .center)
                    .foregroundColor(.black)
            }
        }
        .padding(.leading, 10.0)
    }

    var flipCameraButton: some View {
        Button(action: {
            model.flipCamera()
        }, label: {
            Circle()
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(width: 45, height: 45, alignment: .center)
                .overlay(
                    Image(systemName: "camera.rotate.fill")
                        .foregroundColor(.white))
        })
        .padding(.trailing, 10.0)
    }
    @State private var selection = 0
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("themecolor"))
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .white
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 13)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 13)!], for: .selected)
      }
    var body: some View {

        GeometryReader { reader in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack {
                  CameraPreview(session: model.session)
                        .padding(.all, 0.0)
                        .gesture(
                            DragGesture().onChanged({ (val) in
                                //  Only accept vertical drag
                                if abs(val.translation.height) > abs(val.translation.width) {
                                    //  Get the percentage of vertical screen space covered by drag
                                    let percentage: CGFloat = -(val.translation.height / reader.size.height)
                                    //  Calculate new zoom factor
                                    let calc = currentZoomFactor + percentage
                                    //  Limit zoom factor to a maximum of 5x and a minimum of 1x
                                    let zoomFactor: CGFloat = min(max(calc, 1), 5)
                                    //  Store the newly calculated zoom factor
                                    currentZoomFactor = zoomFactor
                                    //  Sets the zoom factor to the capture device session
                                    model.zoom(with: zoomFactor)
                                }
                            })
                        )
                        .onAppear {
                            model.configure()
                        }
                        .alert(isPresented: $model.showAlertError, content: {
                            Alert(title: Text(model.alertError.title), message: Text(model.alertError.message), dismissButton: .default(Text(model.alertError.primaryButtonTitle), action: {
                                model.alertError.primaryAction?()
                            }))
                        })
                        .overlay(
                            Group {
                                if model.willCapturePhoto {
                                    Color.black
                                }
                            }
                        )
                        .animation(.easeInOut)

                    HStack {
                        capturedPhotoThumbnail

                        Spacer()

                        captureButton

                        Spacer()

                        flipCameraButton

                    }
                    .frame(height: 70.0)
                    .background(Color("themecolor"))
                    .offset(y: 20)


                  // .padding([.leading, .bottom, .trailing], 10)
//                    .frame(height: 100.0)
//                    .background(Color("themecolor"))
                }
                .padding(.all, 0.0)
            }
        }
    }
}


import SwiftUI
import AVFoundation

final class CustomCameraController: UIViewController {
    static let shared = CustomCameraController()
    
    private var captureSession = AVCaptureSession()
    private var backCamera: AVCaptureDevice?
    private var frontCamera: AVCaptureDevice?
    private var currentCamera: AVCaptureDevice?
    private var photoOutput: AVCapturePhotoOutput?
    private var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    weak var captureDelegate: AVCapturePhotoCaptureDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func configurePreviewLayer(with frame: CGRect) {
      
        let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer.frame = frame
        view.layer.insertSublayer(cameraPreviewLayer, at: 0)
    
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    func stopRunningCaptureSession() {
        captureSession.stopRunning()
    }
    
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        
        guard let delegate = captureDelegate else {
            print("delegate nil")
            return
        }
        photoOutput?.capturePhoto(with: settings, delegate: delegate)
    }
    
    // MARK: Private
    
    private func setup() {
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
    }
    
    private func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    private func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .unspecified
        )
        
        for device in deviceDiscoverySession.devices {
            switch device.position {
            case AVCaptureDevice.Position.front:
                frontCamera = device
            case AVCaptureDevice.Position.back:
                backCamera = device
            default:
                break
            }
        }
        
        self.currentCamera = self.backCamera
    }
    
    private func setupInputOutput() {
        do {
            guard let currentCamera = currentCamera else { return }
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera)
            
            captureSession.addInput(captureDeviceInput)
            
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray(
                [AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])],
                completionHandler: nil
            )
            
            guard let photoOutput = photoOutput else { return }
            captureSession.addOutput(photoOutput)
        } catch {
            print(error)
        }
    }
}

final class CustomCameraRepresentable: UIViewControllerRepresentable {
//    @Environment(\.presentationMode) var presentationMode
    
    init(cameraFrame: CGRect, imageCompletion: @escaping ((UIImage) -> Void)) {
        self.cameraFrame = cameraFrame
        self.imageCompletion = imageCompletion
    }
    
    var cameraFrame: CGRect
    var imageCompletion: ((UIImage) -> Void)
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> CustomCameraController {
        CustomCameraController.shared.configurePreviewLayer(with: cameraFrame)
        CustomCameraController.shared.captureDelegate = context.coordinator
        return CustomCameraController.shared
    }
    
    func updateUIViewController(_ cameraViewController: CustomCameraController, context: Context) {}
    
    func takePhoto() {
        CustomCameraController.shared.takePhoto()
    }
    
    func startRunningCaptureSession() {
        CustomCameraController.shared.startRunningCaptureSession()
    }
    
    func stopRunningCaptureSession() {
        CustomCameraController.shared.stopRunningCaptureSession()
    }
}

extension CustomCameraRepresentable {
    final class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
        private let parent: CustomCameraRepresentable
        
        init(_ parent: CustomCameraRepresentable) {
            self.parent = parent
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput,
                         didFinishProcessingPhoto photo: AVCapturePhoto,
                         error: Error?) {
            if let imageData = photo.fileDataRepresentation() {
                guard let newImage = UIImage(data: imageData) else { return }
                parent.imageCompletion(newImage)
            }
        }
    }
}
