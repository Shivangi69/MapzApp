//
//  activityList.swift
//  MapzApp
//
//  Created by Misha Infotech on 03/09/2021.
//

import SwiftUI
import CoreLocation
import GoogleMaps
import GooglePlaces
import Alamofire

struct activityList: View {
    @ObservedObject var obs = DairyObserver()
    @Environment(\.presentationMode) var presentationMode
    @State var showupdateview = false
    @State var evntID = String()

    @State var sharedUrl = String()

    var body: some View {
        ZStack{
            VStack(spacing: 20.0) {
             
             HStack(spacing: 20.0) {
                 Button(action: {
                    presentationMode.wrappedValue.dismiss()
                 }) {
                    Image("menu")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                    
                 }
                 
                Spacer()
                 
                Text("Your Diary")
                    .foregroundColor(Color.white)
                    .font(.custom("Inter-Bold", size: 22))
                Spacer()
                Image("")
                     .resizable()
                     
                     .aspectRatio(contentMode: .fit)
                
             }
             .padding()
             .padding(.top,10)
             .frame(height: 50.0)
             .background(Color("themecolor"))
           
            //    if (obs.showview)
                
//           {
//                ScrollView{
//
//                  ///  ForEach(0..<Databoarding.count){_ in
//                    ForEach(obs.eventlist, id: \.self) { person in
//
//
//            VStack{
//                HStack{
//                    Image("icons8-male-user-72")
//                        .resizable()
//                        .frame(width: 70, height: 70)
//                        .cornerRadius(35)
//                        .aspectRatio(contentMode: .fit)
//                    VStack(alignment: .leading, spacing: 5.0){
//
//                        Text(UserDefaults.standard.string(forKey: "name") ?? "")
//                            .font(.custom("Inter-Bold", size: 20))
//                        HStack{
//                        Image("loccc")
//                            .resizable()
//
//                            .padding(.trailing, 10.0)
//                            .frame(width: 32, height: 32)
//
//                            .aspectRatio(contentMode: .fit)
//                            Text(person.Addrs)
//                                .font(.custom("Inter-Regular", size: 16))
//                                 .frame( height:32)
//                            Spacer()
//
//                        }
//                    }
//                    Spacer()
//                    Image("share")
//                        .resizable()
//
//                        .padding(.trailing, 10.0)
//                        .frame(width: 32, height: 32)
//
//                        .aspectRatio(contentMode: .fit)
//                        .onTapGesture {
//                            self.evntID = person.eventId
//                            self.share()
//                        }
//
//                }
//                .frame(width : 320 , height: 90)
//
//                ZStack{
//
//
//                    HStack{
//
//                    VStack(alignment: .leading, spacing: 5.0){
//                        Text(person.date)
//                            .font(.custom("Inter-Bold", size: 16))
//                            .foregroundColor(Color.white)
////                            Text("Add New Video in")
////                                .font(.custom("Inter-Regular", size: 16))
////                                .foregroundColor(Color("darkyellow"))
//                        Text(person.diaryName)
//                                .font(.custom("Inter-Bold", size: 25))
//                            .foregroundColor(Color.white)
//
//                    HStack(spacing: 10.0){
//                        HStack{
//                        //Spacer()
//                        Image("img_y")
//                             .resizable()
//                            .frame(width: 32, height: 32)
//                             .aspectRatio(contentMode: .fit)
//
//                            Text(person.picCount)
//                            .font(.custom("Inter-Regular", size: 16))
//                            .foregroundColor(Color.white)
//
//                        Spacer()
//                        Image("vid_y")
//                             .resizable()
//                            .frame(width: 32, height: 32)
//                             .aspectRatio(contentMode: .fit)
//
//                        Text(person.vedioCount)
//                            .font(.custom("Inter-Regular", size: 16))
//                            .foregroundColor(Color.white)
//                       //
//                            Spacer()
//
//                        }
//                        HStack{
//                        Image("rec_y")
//                             .resizable()
//                            .frame(width: 32, height: 32)
//                             .aspectRatio(contentMode: .fit)
//
//                        Text(person.audioCount)
//                            .font(.custom("Inter-Regular", size: 16))
//                            .foregroundColor(Color.white)
//                       //
//                        //
//                            Spacer()
//                        Image("note_y")
//                             .resizable()
//                            .frame(width: 32, height: 32)
//                             .aspectRatio(contentMode: .fit)
//
//                        Text("0")
//                            .font(.custom("Inter-Regular", size: 16))
//                            .foregroundColor(Color.white)
//
//                            Spacer()
//                        }
//                    }
//
//
//                }
//                        .padding(.leading, 20.0)
//
//                      //
//                        Spacer()
//                  //
//
//                    }
//                    .onTapGesture {
//
//                        UserDefaults.standard.set(person.eventId, forKey: "eventID")
//                        showupdateview.toggle()
//                    }
//                    .fullScreenCover(isPresented: $showupdateview, content: UpdatepartyDetails.init)
//
//
//                    .padding(.leading, 15.0)
//                    //
//                    .frame(width : UIScreen.main.bounds.width - 25 , height: 100)
//                    .background(Color.black)
//                    .offset(x : -15,y : 50)
//
//                } .frame(width : UIScreen.main.bounds.width - 40 , height: 310)
//
//                .background(
//                    ZStack{
//
//
//                        AsyncImage(
//                            url: URL(string: person.imageArray[3])! ,
//                                           placeholder: { Image("").foregroundColor(colorGrey1)
//                                            .aspectRatio(contentMode: .fit)
//                                           },
//                                                       image: { Image(uiImage: $0).resizable()
//
//
//                                                            }
//                                       )
//                       // Image("icons8-male-user-72")
//                        //.frame(width : 360 , height: 310)
//                        //.aspectRatio(contentMode: .fill)
//                        .cornerRadius(20)
//                       // .clipShape(Rectangle())
//
//
//                       // .cornerRadius(20)
//                        AsyncImage(
//                            url: URL(string: person.imageArray[2])! ,
//                                           placeholder: { Image("").foregroundColor(colorGrey1)
//                                            .aspectRatio(contentMode: .fit)
//                                           },
//                                                       image: { Image(uiImage: $0).resizable()
//
//                                                            }
//                                       )
//                       // Image("icons8-male-user-72")
//
//                        //.frame(width : 360 , height: 310)
//
//                        //.aspectRatio(contentMode: .fill)
//                        .cornerRadius(20)
//                        .offset(x : -5,y : -5)
//                        AsyncImage(
//                            url: URL(string: person.imageArray[1])! ,
//                                           placeholder: { Image("").foregroundColor(colorGrey1)
//                                            .aspectRatio(contentMode: .fit)
//                                           },
//                                                       image:
//                                                        { Image(uiImage: $0).resizable()
//
//
//                                                       }
//                                       )
//
//                        .cornerRadius(20)
//                        .offset(x : -10,y : -10)
//
//                        AsyncImage(
//                            url: URL(string: person.imageArray[0])! ,
//                                           placeholder: { Image("").foregroundColor(colorGrey1)
//                                            .aspectRatio(contentMode: .fit)
//                                           },
//                                                       image: { Image(uiImage: $0).resizable()
//
//                                                            }
//                                       )
//
//
//                        //.aspectRatio(contentMode: .fill)
//                        .cornerRadius(20)
//                        .offset(x : -15,y : -15)
//
//    //                    Image("1")
//    //                        .resizable().cornerRadius(20)
//    //                    Image("2")
//    //                        .resizable().cornerRadius(20)
//    //                        .offset(x : -5,y : -5)
//    //                    Image("3")
//    //                        .resizable().cornerRadius(20)
//    //                        .offset(x : -10,y : -10)
//    //                    Image("4")
//    //                        .resizable().cornerRadius(20)
//    //                        .offset(x : -15,y : -15)
//                    }//.background(Color("bluecolor"))
//                   // .frame(width : UIScreen.main.bounds.width - 40)
//
//    )
//
//
//            }
//            .frame(width : UIScreen.main.bounds.width - 20 , height: 410.0)
//            .background(RoundedCorners(color: Color("lightBlue"), tl: 30, tr: 30, bl: 30, br: 30))
//
//
//
//                    }
//
//                }
//                .padding(.horizontal)
//
//           }else{
            
            
            blankView(imageNAme: "no_found_diary",ErrorMsg : "Diary not Found")
                .offset(y : UIScreen.main.bounds.height/2-120)

    
//}
                Spacer()
            }
        }
           
    }
    
    func share() {
        
        
        let str1  = "EventDiary/ExportToPDFByEventtId/?id="+evntID
        AccountAPI.getsignin(servciename: str1, nil) { res in
        switch res {
        case .success:
            print("resulllll",res)
            
            if let json = res.value{
               // self.friendlist = []
                print("Josn",json)
       
                if(json["status"].string == "true"){
                sharedUrl = json["data"].string!
                    self.actionSheet()
                    
                }else{
                    Toast(text:json["message"].string).show()

                }
            }
          

        case let .failure(error):
          print(error)
        }
      }
    }
    func actionSheet() {
        guard let data = URL(string: sharedUrl) else { return }
            let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        }

}

struct activityList_Previews: PreviewProvider {
    static var previews: some View {
        activityList()
    }
}

class DairyObserver: ObservableObject {
   
    @Published   var eventlist = [eventmodalclassss]()
    @Published   var filelist = [FilesModal]()
    @Published   var mp3list = [FilesModal]()
    @Published   var piclist = [FilesModal]()
    @Published   var vidlist = [FilesModal]()

    @Published   var notlist = [NotesModal]()
    @Published   var showview = false

    @Published   var showlist = false
    @Published   var showpiclist = false
    @Published   var showaudiolist = false
    @Published   var showvidlist = false
    @Published   var imglist = [String]()

    init() {
        
        let str =  UserDefaults.standard.string(forKey: "id") ?? ""
        let str1  = "EventDiary/GetMyDiaries/?id="+str
        AccountAPI.getsignin(servciename: str1, nil) { res in
        switch res {
        case .success:
            print("resulllll",res)
            
            if let json = res.value{
                self.eventlist = []
                print("Josn",json)
       
                
                let events = json["data"]
                var i = Int()
                                i = 0
                for j in events {

                    let filestinfor = j.1["files"]
                let notestinfor = j.1["notes"]

                
               //
                self.filelist = []
                self.notlist = []
                self.imglist = []

                for i in filestinfor {

                    let  acc  = FilesModal(i.1["fileId"].intValue,i.1["fileId"].stringValue, i.1["fileType"].stringValue, i.1["file"].stringValue,i.1["thumbnail"].stringValue)
                    self.filelist.append(acc)
                    
                }
                    self.mp3list =   self.filelist.filter { $0.fileType == "mp3" }
                    self.vidlist =   self.filelist.filter { $0.fileType == "mp4" || $0.fileType == "3gp"}
                        self.piclist =   self.filelist.filter { $0.fileType == "jpg" || $0.fileType == "jpeg" }
                if self.piclist.count > 0 {
                    self.showpiclist.toggle()
                }
                if self.vidlist.count > 0 {
                    self.showvidlist.toggle()
                }
                if self.mp3list.count > 0 {
                    self.showaudiolist.toggle()
                }
               
                for i in notestinfor {

                    let  acc  = NotesModal(i.1["noteId"].stringValue, i.1["noteText"].stringValue)
                    self.notlist.append(acc)
                }
                if self.notlist.count > 0 {
                    self.showlist.toggle()
                }
               
                    if( self.piclist.count >= 4){
                       // var  acc  = imagesModal(self.piclist[0].file)
                        self.imglist.append(self.piclist[0].file)
                        //acc  = imagesModal(self.piclist[1].file)
                        self.imglist.append(self.piclist[1].file)
                      //  acc  = imagesModal(self.piclist[2].file)
                        self.imglist.append(self.piclist[2].file)
                       // acc  = imagesModal(self.piclist[3].file)
                        self.imglist.append(self.piclist[3].file)
                    }
                   else if( self.piclist.count >= 3 && self.piclist.count < 4 ){
                        //var  acc  = imagesModal(self.piclist[0].file)
                        self.imglist.append(self.piclist[0].file)
                      //  acc  = imagesModal(self.piclist[1].file)
                        self.imglist.append(self.piclist[1].file)
                      //  acc  = imagesModal(self.piclist[2].file)
                        self.imglist.append(self.piclist[2].file)
                       // acc  = imagesModal("")
                        self.imglist.append("aaaaa")
                    }
                   else if( self.piclist.count >= 2 && self.piclist.count < 3 ){
                        //var  acc  = imagesModal(self.piclist[0].file)
                        self.imglist.append(self.piclist[0].file)
                       // acc  = imagesModal(self.piclist[1].file)
                        self.imglist.append(self.piclist[1].file)
                       // acc  = imagesModal("")
                        self.imglist.append("aaaaa")
                       // acc  = imagesModal("")
                        self.imglist.append("aaaaa")
                    }
                   else if( self.piclist.count >= 1 && self.piclist.count < 2 ){
                       /// var  acc  = imagesModal(self.piclist[3].file)
                        self.imglist.append(self.piclist[0].file)
                       // acc  = imagesModal("")
                        self.imglist.append("aaaaa")
                       // acc  = imagesModal("")
                        self.imglist.append("aaaaa")
                      //  acc  = imagesModal("")
                        self.imglist.append("aaaaa")
                    }
                   else if( self.piclist.count == 0 ){
                    self.imglist.append("aaaaa")
                    self.imglist.append("aaaaa")
                   // acc  = imagesModal("")
                    self.imglist.append("aaaaa")
                  //  acc  = imagesModal("")
                    self.imglist.append("aaaaa")
                    }
                   else{
                    self.imglist.append("aaaaa")
                    self.imglist.append("aaaaa")
                   // acc  = imagesModal("")
                    self.imglist.append("aaaaa")
                  //  acc  = imagesModal("")
                    self.imglist.append("aaaaa")
                   }
//                let scc = eventmodalclassss(userdic["eventId"].stringValue, userdic["userId"].stringValue, userdic["longitude"].stringValue, userdic["latitude"].stringValue, userdic["diaryName"].stringValue, userdic["diaryDescription"].stringValue, userdic["date"].stringValue, self.filelist as NSArray, self.notlist as NSArray)

                   
//                self.eventlist.append(scc)
                
                    let scc = eventmodalclassss(i,j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, j.1["date"].stringValue, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.piclist.count),self.imglist as [String],j.1["address"].stringValue, "",j.1["diary_Count"].intValue,j.1["friend_Count"].intValue)
                    self.eventlist.append(scc)
                    let lat: Double = Double("\(j.1["latitude"].stringValue)")!
                    //21.228124
                    let lon: Double = Double("\(j.1["longitude"].stringValue)")!
                   
                  

                    let geocoder = GMSGeocoder()
                    let coordinate = CLLocationCoordinate2DMake(lat,lon)
                    
                    var currentAddress = String()
                    
//                    geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
//                        if let address = response?.firstResult() {
//                            let lines1 = address.lines! as [String]
//
//                            print("Response is = \(address)")
//                            print("Response line is = \(lines1)")
//
//                            currentAddress = lines1.joined(separator: "\n")
//
//                            let scc = eventmodalclassss(j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, j.1["date"].stringValue, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.piclist.count),self.imglist as [String],currentAddress)
//                            self.eventlist.append(scc)
//                    }
//                        else{
//                            let scc = eventmodalclassss(j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, j.1["date"].stringValue, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.piclist.count),self.imglist as [String],"")
//                            self.eventlist.append(scc)
//                        }
//
//                    }
                    
                    i = i + 1
                }
                print(self.eventlist)
                if  (self.eventlist.count > 0){
                    self.showview.toggle()
                    
                }
            }
          

        case let .failure(error):
          print(error)
        }
      }
    }
}
