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
    @ObservedObject var events = UserEvents()
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
//    func startTimers(){
//        if shakeCountDown == nil {
//
//            shakeCountDown = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak let] (timer) in
//                self.onTimerFires()
//            }
//        }
//    }
//    func onTimerFires(){
//        secondsToReachGoal -= 1
//        recorded += 1
//        print(recorded)
//
//    }
//    var captureButton: some View {
//        Button(action: {
//            if(recordingView.videoFileOutput.isRecording){
//                print("Stop::::::;")
////                self.onComplete = false
////
////                self.recording = true
//                recordingView.stopReco()
//
//            }else{
//                print("Start::::::;")
////                self.recording = false
////                self.onComplete = true
//                recordingView.startRecording()
//
//            }
//          //  recordingView.stopReco()
//
//        }, label: {
//
//            Circle()
//                .foregroundColor(.white)
//                .frame(width: 60, height: 60, alignment: .center)
//                .overlay(
//                    Circle()
//                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
//                        .frame(width: 45, height: 45, alignment: .center)
//                )
//        })
//    }
    
    
    var body: some View {
        ZStack{
            VStack(spacing: 0.0) {
                
                HStack(spacing: 20.0) {
                    Button(action: {
                        if (eventNOE == "New"){
                            message = "If you go back to home screen current event will will be discard. You Want to Processed?"
                            showingAlert = true
                            // self.deleteevent()
                        }else{
                            showMaimPopUp = true
                            
                        }
                        
                        //
                    }) {
                        Image("icons8-back-24")
                            .resizable()
                        
                            .aspectRatio(contentMode: .fit)
                        
                        
                    }
                    .frame(width: 40.0, height: 40.0)
                    .fullScreenCover(isPresented: $showMaimPopUp, content: MainView.init)
                    
                    VStack(alignment: .leading){
                        // "latitude": Double(UserDefaults.standard.string(forKey: "lat")!)!,
                        //   "longitude":  Double(UserDefaults.standard.string(forKey: "long")!)!
                        Text((UserDefaults.standard.string(forKey: "Address") ?? ""))
                            .foregroundColor(Color.white)
                            .font(.custom("Inter-Regular", size: 15))
                        
                        
                        Text(UserDefaults.standard.string(forKey: "datestr") ?? "")
                            .foregroundColor(Color.white)
                            .font(.custom("Inter-Regular", size: 15))
                        
                    }
                    Spacer()
                    // HStack(spacing: 20.0) {
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
                    
                    // }
                }
                
                .frame(height: 60.0)
                .background(Color("themecolor"))
                
                
                
                
                if $showCameraPopUp.wrappedValue {
                    CameraViewa()
                        .frame(width: UIScreen.main.bounds.width)
                    
                }
                
                if $showVideoPopUp.wrappedValue {
                    ZStack{
                        CameraView(events: events, applicationName: "SwiftUICam")
                    }
                    
                }
                if $showrecdPopUp.wrappedValue {
                    
                    VStack{
                        
                        Spacer()
                        
                        // if vm.isRecording {
                        
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
                    // Spacer()
                    
                    Button(action: {
                        showVideoPopUp = false
                        showrecdPopUp = false
                        showdocPopUp = false
                        showCameraPopUp = true
                        yoff = -70
                    }, label: {
                        HStack {
                            Text("Camera")
                            //.fontWeight(.bold)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
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
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
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
                        //                        showVideoPopUp = false
                        //                        showrecdPopUp = false
                        showdocPopUp = true
                        //  showCameraPopUp = false
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
                //                .fullScreenCover(isPresented: $showdocPopUp, content: createNotes.init())
                .fullScreenCover(isPresented: $showdocPopUp, content: {
                    createNotes()
                })
                //                if $showCameraPopUp.wrappedValue {
                //
                //
                //                }
                
                if $showVideoPopUp.wrappedValue {
                    HStack {
                        Spacer()
                        
                        CameraInterfaceView(events: events)
                        
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
            } else
            if (fromwhere == "notes"){
                yoff = 0
                showdocPopUp = true
            }else{
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
//                    Button(action: {
//                        model.switchFlash()
//                    }, label: {
//                        Image(systemName: model.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
//                            .font(.system(size: 20, weight: .medium, design: .default))
//                    })
//                    .accentColor(model.isFlashOn ? .yellow : .white)
//
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

//struct VideoRecordingView: UIViewRepresentable {
//
//    @Binding var timeLeft: Int
//    @Binding var onComplete: Bool
//    @Binding var recording: Bool
//    func makeUIView(context: UIViewRepresentableContext<VideoRecordingView>) -> PreviewView {
//        let recordingView = PreviewView()
//        recordingView.onComplete = {
//            self.onComplete = true
//        }
//
//        recordingView.onRecord = { timeLeft, totalShakes in
//            self.timeLeft = timeLeft
//            self.recording = true
//        }
//
//        recordingView.onReset = {
//            self.recording = false
//            self.timeLeft = 15
//        }
//        return recordingView
//    }
//
//    func updateUIView(_ uiViewController: PreviewView, context: UIViewRepresentableContext<VideoRecordingView>) {
//
//    }
//}

//extension PreviewView: AVCaptureFileOutputRecordingDelegate{
//    public func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
//        print(outputFileURL.absoluteString)
//    }
//}


//class PreviewView: UIView {
//
//       var captureSession: AVCaptureSession?
//       var videoFileOutput = AVCaptureMovieFileOutput()
//       var recordingDelegate:AVCaptureFileOutputRecordingDelegate!
//       var shakeCountDown: Timer?
//       var recorded = 0
//       var secondsToReachGoal = 15
//       var onRecord: ((Int, Int)->())?
//       var onReset: (() -> ())?
//       var onComplete: (() -> ())?
//    var session = AVCaptureSession()
//
//    init() {
//        super.init(frame: .zero)
//
//        var allowedAccess = false
//        let blocker = DispatchGroup()
//        blocker.enter()
//        AVCaptureDevice.requestAccess(for: .video) { flag in
//            allowedAccess = flag
//            blocker.leave()
//        }
//        blocker.wait()
//
//        if !allowedAccess {
//            print("!!! NO ACCESS TO CAMERA")
//            return
//        }
//
//        // setup session
//        session.beginConfiguration()
//
//        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
//                                                  for: .video, position: .back)
//        guard videoDevice != nil, let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), session.canAddInput(videoDeviceInput) else {
//            print("!!! NO CAMERA DETECTED")
//            return
//        }
//        session.addInput(videoDeviceInput)
//        session.commitConfiguration()
//        self.captureSession = session
//    }
//
//    open override class var layerClass: AnyClass {
//        AVCaptureVideoPreviewLayer.self
//    }
//
//    required public init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
//        return layer as! AVCaptureVideoPreviewLayer
//    }
//
//    open override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        recordingDelegate = self
//     //   startTimers()
//        if nil != self.superview {
//            self.videoPreviewLayer.session = self.captureSession
//            self.videoPreviewLayer.videoGravity = .resizeAspectFill
//            self.captureSession?.startRunning()
//           // self.startRecording()
//        } else {
//            self.captureSession?.stopRunning()
//        }
//    }
//
//
//    func onTimerFires(){
//        print("🟢 RECORDING \(videoFileOutput.isRecording)")
//        secondsToReachGoal -= 1
//        recorded += 1
//        onRecord?(secondsToReachGoal, recorded)
//        print(recorded)
//        if(secondsToReachGoal == 0){
//            stopRecording()
//            shakeCountDown?.invalidate()
//            shakeCountDown = nil
//            onComplete?()
//            videoFileOutput.stopRecording()
//        }
//    }
//
//    func startTimers(){
//        if shakeCountDown == nil {
//            shakeCountDown = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
//                self?.onTimerFires()
//            }
//        }
//    }
//
//    func startRecording(){
//        recorded = 0
//        secondsToReachGoal = 15
//        startTimers()
//        recordingDelegate = self
//        self.captureSession?.removeOutput(videoFileOutput)
//
//     print(self.captureSession?.isRunning as Any)
//        print(self.captureSession?.isRunning as Any)
//
//
////        if ((self.captureSession?.isRunning) != nil) {
////               DispatchQueue.global().async {
////                self.captureSession?.stopRunning()
////               }
////           }
////
//
//
////        self.captureSession!.stopRunning()
////
////        self.videoPreviewLayer.removeFromSuperlayer()
////        //self.videoPreviewLayer = nil
////        self.videoPreviewLayer.session?.removeOutput(videoFileOutput)
////
////        self.videoPreviewLayer.session = self.captureSession
////        self.videoPreviewLayer.videoGravity = .resizeAspectFill
//
////        self.captureSession = nil
////        self.captureSession = session
//        self.captureSession?.startRunning()
//        print(captureSession as Any)
//        captureSession?.addOutput(videoFileOutput)
//        print(videoFileOutput as Any)
//
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let filePath = documentsURL.appendingPathComponent("tempPZDC")
//
//        videoFileOutput.startRecording(to: filePath, recordingDelegate: recordingDelegate)
//    }
//
//    func stopReco(){
//        stopRecording()
//        shakeCountDown?.invalidate()
//        shakeCountDown = nil
//
//        onComplete?()
//        videoFileOutput.stopRecording()
//
//    }
//    func stopRecording(){
//        videoFileOutput.stopRecording()
//        print("🔴 RECORDING \(videoFileOutput.isRecording)")
//        print(videoFileOutput.outputFileURL!)
//        recorded = 0
//        secondsToReachGoal = 15
//        self.saveVideoToAlbum(videoFileOutput.outputFileURL!) { (error) in
//
//        }
//        self.uploadInBackground(fileInData: videoFileOutput.outputFileURL!)
//    }
    func requestAuthorization(completion: @escaping ()->Void) {
            if PHPhotoLibrary.authorizationStatus() == .notDetermined {
                PHPhotoLibrary.requestAuthorization { (status) in
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            } else if PHPhotoLibrary.authorizationStatus() == .authorized{
                completion()
            }
        }
//
    func saveVideoToAlbum(_ outputURL: URL, _ completion: ((Error?) -> Void)?) {
            requestAuthorization {
                PHPhotoLibrary.shared().performChanges({
                    let request = PHAssetCreationRequest.forAsset()
                    request.addResource(with: .video, fileURL: outputURL, options: nil)
                }) { (result, error) in
                    DispatchQueue.main.async {
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("Saved successfully")
                        }
                        completion?(error)
                    }
                }
            }
        }

//
//    func uploadInBackground(fileInData: URL) {
//
//
//        let evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""
//        let parameters = [
//              "EventId": evntId,
//            "UserId": UserDefaults.standard.string(forKey: "id") ?? ""
//
//            ]
//    print(parameters)
//        let headers: HTTPHeaders
//            headers = ["Content-type": "multipart/form-data",
//                       "Content-Disposition" : "form-data"]
//
////            let headers: [String : String] = [ "Authorization": "key"]
//        let baseURL = URL(string: "http://167.86.105.98:7723/api/Upload/uploadeventdiary")
//        print(baseURL!)
//
//            Networking.sharedInstance.backgroundSessionManager.upload(multipartFormData: { (multipartFormData) in
//
////
//
//
//                let myId = UserDefaults.standard.string(forKey: "pov") ?? ""
//
//                    multipartFormData.append(fileInData, withName: "file", fileName: "mp4", mimeType: "video/mp4")
//
//                for (key, value) in parameters {
//                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
//                       }
//            }, usingThreshold: UInt64.init(), to: baseURL!, method: .post, headers: headers)
//
//            { (result) in
//                switch result {
//                case .success(let upload, _, _):
//                    ///api/Upload/upload
//                    upload.uploadProgress(closure: { (progress) in
//                        //Print progress
//                        let value =  Int(progress.fractionCompleted * 100)
//                        print("\(value) %")
//                    })
//
//                    upload.responseJSON { response in
//                        //print response.result
//                        print(response.description)
//                        let res = response.response?.statusCode
//                        print(res!)
//                     //
//                        Toast(text: "Upload Successfully").show()
//
//                       // self.obs.fetch()
//                    }
//
//                case .failure(let encodingError):
//                    //print encodingError.description
//                    print(encodingError.localizedDescription)
//                }
//            }
//        }
//
//}

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
//            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
