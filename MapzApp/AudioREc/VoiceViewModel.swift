//
//  VoiceViewModel.swift
//  CO-Voice
//
//  Created by Mohammad Yasir on 13/02/21.
//

import Foundation
import AVFoundation
import Alamofire
class VoiceViewModel : NSObject, ObservableObject , AVAudioPlayerDelegate{
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    var indexOfPlayer = 0
    
    @Published var isRecording : Bool = false
    
    @Published var recordingsList = [Recording]()
    
    @Published var countSec = 0
    @Published var timerCount : Timer?
    @Published var blinkingCount : Timer?
    @Published var timer : String = "0:00"
    @Published var toggleColor : Bool = false
    var audioURL : URL?

    
    var playingURL : URL?
    
    override init(){
        super.init()
        
        fetchAllRecording()
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
       
        for i in 0..<recordingsList.count {
            if recordingsList[i].fileURL == playingURL {
                recordingsList[i].isPlaying = false
            }
        }
    }
    
  
    
    func startRecording() {
        
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Cannot setup the Recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("CO-Voice : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        
        
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            isRecording = true
            audioURL = fileName
            timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (value) in
                self.countSec += 1
                self.timer = self.covertSecToMinAndHour(seconds: self.countSec)
            })
            blinkColor()
            
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    
    func stopRecording(){
        
        audioRecorder.stop()
        
        isRecording = false
        
        self.countSec = 0
        
        timerCount!.invalidate()
        blinkingCount!.invalidate()
        uploadInBackground(fileInData: audioURL!)
    }
    func uploadInBackground(fileInData: URL) {
        
        
     //   let evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""
//        let parameters = [
//              "EventId": evntId,
//            "UserId": UserDefaults.standard.string(forKey: "id") ?? ""
//              ,
//                "Groupid1" : "1",
//                "IsGroup1" : "true"
//            ]
//    print(parameters)
        
        
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
        let baseURL = URL(string: "http://167.86.105.98:7723/api/Upload/uploadeventdiary")
        print(baseURL!)

            Networking.sharedInstance.backgroundSessionManager.upload(multipartFormData: { (multipartFormData) in
               
//
                
                
                let myId = UserDefaults.standard.string(forKey: "pov") ?? ""
//                if (myId == "pic"){
//                    multipartFormData.append(fileInData, withName: "file", fileName: "jpg", mimeType: "image/jpg")
//
//                }else if(myId == "vid") {
//                    multipartFormData.append(fileInData, withName: "file", fileName: "mp4", mimeType: "video/mp4")
//
//
//                }
//
                multipartFormData.append(fileInData, withName: "file", fileName: "mp3", mimeType: "audio/mp3")
               
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
                     //
                        Toast(text: "Upload Successfully").show()
                       // self.obs.fetch()
                    }
                    
                case .failure(let encodingError):
                    //print encodingError.description
                    print(encodingError.localizedDescription)
                }
            }
        }

    
    
    

    
    func fetchAllRecording(){
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)

        for i in directoryContents {
            recordingsList.append(Recording(fileURL : i, createdAt:getFileDate(for: i), isPlaying: false))
        }
        
        recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
        
    }
    
    
    func startPlaying(url : URL) {
        
        playingURL = url
        
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in Device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
            for i in 0..<recordingsList.count {
                if recordingsList[i].fileURL == url {
                    recordingsList[i].isPlaying = true
                }
            }
            
        } catch {
            print("Playing Failed")
        }
        
        
    }
    
    func stopPlaying(url : URL) {
        
        audioPlayer.stop()
        
        for i in 0..<recordingsList.count {
            if recordingsList[i].fileURL == url {
                recordingsList[i].isPlaying = false
            }
        }
    }
    
 
    func deleteRecording(url : URL) {
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Can't delete")
        }
        
        for i in 0..<recordingsList.count {
            
            if recordingsList[i].fileURL == url {
                if recordingsList[i].isPlaying == true{
                    stopPlaying(url: recordingsList[i].fileURL)
                }
                recordingsList.remove(at: i)
                
                break
            }
        }
    }
    
    func blinkColor() {
        
        blinkingCount = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (value) in
            self.toggleColor.toggle()
        })
        
    }
    
    
    func getFileDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
    
    
    
}




