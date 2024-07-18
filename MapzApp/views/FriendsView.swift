//
//  FriendsView.swift
//  MapzApp
//
//  Created by Misha Infotech on 17/08/2021.
//

import SwiftUI
import Alamofire
import CoreLocation
import GoogleMaps
import GooglePlaces
struct FriendsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var memberData = friendsinfoObserver()
   
  @State  var showlist = false
    @State var imgstr = "img_b"
    @State    var liftstr = "list_w"
    @State var evntID = String()
    @State var Addressstr  = String()

    @State var sharedUrl = String()
    var body: some View {
        ZStack{
            if (memberData.showcollc){
            ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing: 0.0){
            VStack{
               
                MapView(coordinate: CLLocationCoordinate2D(latitude: 28.23213, longitude: 76.43423), locitem:memberData.eventlist)
             }
            .frame(height: 300.0)
                HStack{
                    Image("mappin")
                        .padding(.leading, 20.0)
                        .frame(width: 32.0, height: 32.0)
                    Text(Addressstr)
                    .font(.custom("Inter-Bold", size: 17))
                .foregroundColor(Color("darkyellow"))
                    Spacer()
                    
                }.frame(width: UIScreen.main.bounds.width,height: 40.0)
                //.background(Color("themecolor"))
                .background(RoundedCorners(color: Color("themecolor"), tl: 0, tr: 0, bl: 15, br: 15))

//                VStack{
//                HStack{
//                    Image(imgstr)
//                        .resizable()
//                        .frame(width: 40, height: 40)
//                        .aspectRatio(contentMode: .fit)
//                        .onTapGesture {
//                            showlist = false
//                            showcollc = true
//                            imgstr = "img_b"
//                            liftstr = "list_w"
//
//                        }
//
//                    Divider()
//                    Image(liftstr)
//                        .resizable()
//                        .frame(width: 40, height: 40)
//                        .aspectRatio(contentMode: .fit)
//                        .onTapGesture {
//                            showlist = true
//                            showcollc = false
//                            imgstr = "img_w"
//                            liftstr = "list_b"
//                        }
//                }
//
//                }.frame(width: 140, height: 50)
//                .background(Color("bluecolor"))
//                .cornerRadius(25)
//                .offset(x: UIScreen.main.bounds.width/2-100 , y: -10)
                Spacer(minLength: 15)
//                if (showlist){
//                VStack{
//                    HStack{
//                        Text("Date")
//                            .font(.custom("Inter-Bold", size: 24))
//                            .foregroundColor(Color.white)
//                        Spacer()
//                        Text("Name")
//                            .font(.custom("Inter-Bold", size: 24))
//                            .foregroundColor(Color.white)
//                        Spacer()
//
//                        Text("Location")
//                            .font(.custom("Inter-Bold", size: 24))
//                            .foregroundColor(Color.white)
//
//
//                    }
//                    .padding(.horizontal, 15.0)
//                    .frame(height: 70)
//                    .background(Color("bluecolor"))
//
//
//                    List{
//                        HStack{
//                            Text("22 july 2021")
//                                .font(.custom("Inter-Regular", size: 16))
//
//                            Spacer()
//                            Text("chirag wadhwa")
//                                .font(.custom("Inter-Regular", size: 16))
//
//                            Spacer()
//
//                            Text("Noida")
//                                .font(.custom("Inter-Regular", size: 16))
//
//                        } .padding(.horizontal, 15.0)
//
//                    }
//                    .frame(height: 300.0)
//                }
//                }
                  
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 30.0){
                      //      ForEach(memberData.eventlist) { member in
                          
                            ForEach(memberData.eventlist, id: \.self) { i in

                       // ForEach(0..<Databoarding.count){_ in
                            FreshCellView1(productitem: i)
                                
                                .onAppear(){
                                    Addressstr = i.Addrs
                                    //MapView.u
                                }
                                
                
                        }
                        }
                        .padding(.all, 10.0)
                    }.frame(height: 460)
                    
                   
                    
                }
            }
            
           
            
            }
           // Spacer()
            
            
        }
        
    }
   

}
struct FreshCellView1 : View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: CartDetails.entity(), sortDescriptors: [])
////    var cartdata: FetchedResults<CartDetails>
//    @State  var productitem: relatedProductlist? = nil
//    @State var imgname : String = "Add"
//    @State  var productpriceitem: relatedprice? = nil
    @State var showNextView = false
    @State var showNextView1 = false
    @State  var productitem: friendseventmodalclassss? = nil
    @State  var product: imagesModal?  = nil//= self.productitem?.imageArray
    @State var showupdateview = false
    @State var evntID = String()
    @State var sharedUrl = String()
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
    var body : some View{
        
        ZStack{
            VStack{
                HStack{
                    
                    AsyncImage(
                        url: NSURL(string: productitem!.profilePictureURL)! as URL ,
                                       placeholder: { Image("icons8-male-user-72")
                                      
                                        .resizable()
                                        .foregroundColor(colorGrey1)
                                        .aspectRatio(contentMode: .fill)
                                       },
                                                   image: { Image(uiImage: $0).resizable()
                                                    
                                                        }
                                   )
                   // Image("icons8-male-user-72")
                     
                    .frame(width: 70, height: 70)
                    .cornerRadius(35)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        
                        UserDefaults.standard.set(productitem?.userId, forKey: "fid")
                        showNextView = true
                    }
                    .fullScreenCover(isPresented: $showNextView, content: {
                      //  friendsProfile(selectedTab: "")
                        friendsProfileView( selectedTab: "" ,grpD: "")
                            })
                   
                    VStack(alignment: .leading, spacing: 5.0){
                       
                        Text(productitem!.username)                    .font(.custom("Inter-Bold", size: 20))
                            .onTapGesture {
                                
                                UserDefaults.standard.set(productitem?.userId, forKey: "fid")
                                showNextView1 = true

                            }
                            .fullScreenCover(isPresented: $showNextView1, content: {
                              //  friendsProfile(selectedTab: "")
                                friendsProfileView( selectedTab: "" ,grpD: "")
                                    })
                           
                        HStack{
                        Image("loccc")
                            .resizable()
                            .padding(.trailing, 10.0)
                            .frame(width: 32, height: 32)
                            
                            .aspectRatio(contentMode: .fit)
                            Text(productitem!.Addrs)
                                .font(.custom("Inter-Regular", size: 16))
                                .frame( height:32)

                            Spacer()
                        }
                    }
                    Spacer()
                    Image("share")
                        .resizable()

                        .padding(.trailing, 10.0)
                        .frame(width: 32, height: 32)
                        .cornerRadius(16)

                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            
                            self.evntID = productitem!.eventId
                            self.share()
                        }
                }
                .frame(width : 320 , height: 90)

                ZStack{
                   
                   //
                    HStack{
                      
                    VStack(alignment: .leading, spacing: 5.0){
                        Text(productitem?.date ?? "")
                                .font(.custom("Inter-Bold", size: 16))
                                .foregroundColor(Color.white)
                        Text(productitem?.diaryDescription ?? "")
                                .font(.custom("Inter-Regular", size: 16))
                                .foregroundColor(Color("darkyellow"))
                        Text(productitem!.diaryName)
                                    .font(.custom("Inter-Bold", size: 25))
                                .foregroundColor(Color("lightBlue"))
                        
                        
                        
                        HStack(spacing: 10.0){
                            HStack{
                            //Spacer()
                            Image("img_y")
                                 .resizable()
                                .frame(width: 32, height: 32)
                                 .aspectRatio(contentMode: .fit)
                            
                               Text(productitem!.picCount)
                                .font(.custom("Inter-Regular", size: 16))
                                .foregroundColor(Color.white)
                          
                            Spacer()
                            Image("vid_y")
                                 .resizable()
                                .frame(width: 32, height: 32)
                                 .aspectRatio(contentMode: .fit)
                            
                               Text(productitem!.vedioCount)
                                .font(.custom("Inter-Regular", size: 16))
                                .foregroundColor(Color.white)
                           //
                                Spacer()
                                
                            }
                            HStack{
                            Image("rec_y")
                                 .resizable()
                                .frame(width: 32, height: 32)
                                 .aspectRatio(contentMode: .fit)
                            
                            Text(productitem!.audioCount)
                                .font(.custom("Inter-Regular", size: 16))
                                .foregroundColor(Color.white)
                           //
                            //
                                Spacer()
                            Image("note_y")
                                 .resizable()
                                .frame(width: 32, height: 32)
                                 .aspectRatio(contentMode: .fit)
                            
                            Text(String((productitem?.Notes.count)!))
                                .font(.custom("Inter-Regular", size: 16))
                                .foregroundColor(Color.white)
                            //
                                Spacer()
                            }
                        }

                        
                        
                        }
                        .padding(.leading, 20.0)
                       
                        Spacer()
                  //
                        
                    }
                    //
                    .frame(width : 360 , height: 120)
                    .background(Color.black.opacity(0.8))
                    .offset(x : -15,y : 50)

                } .frame(width : 360 , height: 290)
                .onTapGesture {
                    UserDefaults.standard.set("Edit", forKey: "eventNOE")
                    UserDefaults.standard.set(productitem?.eventId, forKey: "eventID")
                    showupdateview.toggle()
                }
                .fullScreenCover(isPresented: $showupdateview, content: UpdatepartyDetails.init)

                .background(
                    ZStack{
                        

                        AsyncImage(
                            url: NSURL(string: self.productitem!.imageArray[3])! as URL ,
                                           placeholder: { Image("").foregroundColor(colorGrey1)
                                            .aspectRatio(contentMode: .fit)
                                           },
                                                       image: { Image(uiImage: $0).resizable()
                                                        
                                                        
                                                            }
                                       )
                       // Image("icons8-male-user-72")
                        //.frame(width : 360 , height: 310)
                        //.aspectRatio(contentMode: .fill)
                        .cornerRadius(20)
                       // .clipShape(Rectangle())

                        
                       // .cornerRadius(20)
                        AsyncImage(
                            url: NSURL(string: self.productitem!.imageArray[2])! as URL ,
                                           placeholder: { Image("").foregroundColor(colorGrey1)
                                            .aspectRatio(contentMode: .fit)
                                           },
                                                       image: { Image(uiImage: $0).resizable()
                                                        
                                                            }
                                       )
                       // Image("icons8-male-user-72")
                         
                        //.frame(width : 360 , height: 310)
                        
                        //.aspectRatio(contentMode: .fill)
                        .cornerRadius(20)
                        .offset(x : -5,y : -5)
                        AsyncImage(
                            url: NSURL(string: self.productitem!.imageArray[1])! as URL ,
                                           placeholder: { Image("").foregroundColor(colorGrey1)
                                            .aspectRatio(contentMode: .fit)
                                           },
                                                       image:
                                                        { Image(uiImage: $0).resizable()
                                                        
                                                            
                                                       }
                                       )
                      
                        .cornerRadius(20)
                        .offset(x : -10,y : -10)

                        AsyncImage(
                            url: NSURL(string: self.productitem!.imageArray[0])! as URL ,
                                           placeholder: { Image("").foregroundColor(colorGrey1)
                                            .aspectRatio(contentMode: .fit)
                                           },
                                                       image: { Image(uiImage: $0).resizable()
                                                        
                                                            }
                                       )
                         
                       
                        //.aspectRatio(contentMode: .fill)
                        .cornerRadius(20)
                        .offset(x : -15,y : -15)

    //                    Image("1")
    //                        .resizable().cornerRadius(20)
    //                    Image("2")
    //                        .resizable().cornerRadius(20)
    //                        .offset(x : -5,y : -5)
    //                    Image("3")
    //                        .resizable().cornerRadius(20)
    //                        .offset(x : -10,y : -10)
    //                    Image("4")
    //                        .resizable().cornerRadius(20)
    //                        .offset(x : -15,y : -15)
                    }//.background(Color("bluecolor"))
                   
                    
                    
                      

    )
            }
            .frame(width : 350 , height: 440.0)
            .background(RoundedCorners(color: Color("lightBlue"), tl: 30, tr: 30, bl: 30, br: 30))
                    
        }
        .onTapGesture {
            UserDefaults.standard.set("Edit", forKey: "eventNOE")
            UserDefaults.standard.set(productitem?.eventId, forKey: "eventID")
            showupdateview.toggle()
        }
        .fullScreenCover(isPresented: $showupdateview, content: UpdatepartyDetails.init)

        .padding(.leading, 30.0)
       
    }
    
}
struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    
    var body: some View {
        GeometryReader { geometry in
            Path { path in

                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)

                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}

import Foundation
import Combine


class friendsinfoObserver: ObservableObject {
   
    @Published   var eventlist = [friendseventmodalclassss]()
    @Published   var filelist = [FilesModal]()
    @Published   var mp3list = [FilesModal]()
    @Published   var piclist = [FilesModal]()
    @Published   var vidlist = [FilesModal]()
    @Published   var imglist = [String]()
    @Published  var showcollc = false

    @Published   var notlist = [NotesModal]()

    @Published   var showlist = false
    @Published   var showpiclist = false
    @Published   var showaudiolist = false
    @Published   var showvidlist = false
    var membersListFull = false
    // Tracks last page loaded. Used to load next page (current + 1)
    var currentPage = 0
    // Limit of records per page. (Only if backend supports, it usually does)
    let perPage = 9
    init () {
    var logInFormData: Parameters {
        [
            "userId":    UserDefaults.standard.string(forKey: "id") ?? "" ,
            "page": 1

              ]
    
    }
   
        print(logInFormData)

        
                AccountAPI.signin(servciename: "FriendInvite/GetAllFriendsEventDiary", logInFormData) { res in
        switch res {
        case .success:
            print("resulllll",res)
            if let json = res.value{

                print("Josn",json)
        let userdic = json["data"]
                self.eventlist.removeAll()
                for j in userdic {
                    self.filelist = []
               
                    self.notlist.removeAll()
                    self.imglist.removeAll()

                    self.mp3list.removeAll()
                    self.vidlist.removeAll()
                    self.piclist.removeAll()
                    let filestinfor = j.1["files"]
                    let notestinfor = j.1["notes"]

                
                
                   

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
                    self.imglist.append("")
                }
               else if( self.piclist.count >= 2 && self.piclist.count < 3 ){
                    //var  acc  = imagesModal(self.piclist[0].file)
                    self.imglist.append(self.piclist[0].file)
                   // acc  = imagesModal(self.piclist[1].file)
                    self.imglist.append(self.piclist[1].file)
                   // acc  = imagesModal("")
                    self.imglist.append("")
                   // acc  = imagesModal("")
                    self.imglist.append("")
                }
               else if( self.piclist.count >= 1 && self.piclist.count < 2 ){
                   /// var  acc  = imagesModal(self.piclist[3].file)
                    self.imglist.append(self.piclist[0].file)
                   // acc  = imagesModal("")
                    self.imglist.append("")
                   // acc  = imagesModal("")
                    self.imglist.append("")
                  //  acc  = imagesModal("")
                    self.imglist.append("")
                }
               else if( self.piclist.count == 0 ){
                self.imglist.append("")
               // acc  = imagesModal("")
                self.imglist.append("")
               // acc  = imagesModal("")
                self.imglist.append("")
              //  acc  = imagesModal("")
                self.imglist.append("")
                }
            
                    let scc = friendseventmodalclassss(j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, j.1["date"].stringValue, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.piclist.count),self.imglist as [String],j.1["address"].stringValue,j.1["userName"].stringValue,j.1["profilePictureURL"].stringValue)
                self.eventlist.append(scc)
                    print("scc%@",scc)
//                    let lat: Double = Double("\(j.1["latitude"].stringValue)")!
//                //21.228124
//                    let lon: Double = Double("\(j.1["longitude"].stringValue)")!
//
//
////
//                let geocoder = GMSGeocoder()
//                let coordinate = CLLocationCoordinate2DMake(lat,lon)
//
//                var currentAddress = String()

//                geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
//                    if let address = response?.firstResult() {
//                        let lines1 = address.lines! as [String]
//
//                        print("Response is = \(address)")
//                        print("Response line is = \(lines1)")
//
//                        currentAddress = lines1.joined(separator: "\n")
//
//                        let scc = friendseventmodalclassss(j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, j.1["date"].stringValue, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.vidlist.count),self.imglist as [String],currentAddress,j.1["userName"].stringValue, j.1["profilePictureURL"].stringValue)
//                    self.eventlist.append(scc)
//                }
//                    else{
//                        let scc = friendseventmodalclassss(j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, j.1["date"].stringValue, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.vidlist.count),self.imglist as [String],"",j.1["userName"].stringValue,j.1["profilePictureURL"].stringValue)
//                    self.eventlist.append(scc)
//                    }
//
//                }
                
                   
                   
                    
                
            }
                self.showcollc = true
//                self.currentPage += 1
//                if self.eventlist.count < self.perPage {
//                    self.membersListFull = true
//                }
               
            }

        case let .failure(error):
          print(error)
        }
      }
    }
}
struct MapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D
    var locitem = [friendseventmodalclassss]()
    var locationManager = CLLocationManager()

    @State var camera = GMSCameraPosition()
    @State var mapView = GMSMapView()
    let marker1 : GMSMarker = GMSMarker()

    let marker : GMSMarker = GMSMarker()
    private static var defaultCamera = GMSCameraPosition.camera(withLatitude: -37.8136, longitude: 144.9631, zoom: 10.0)
    func makeUIView(context: Self.Context) -> GMSMapView {
         
        var currentLoc: CLLocation!
        currentLoc = locationManager.location
        
          let lat = 28.656526
          let lon = 77.563582
//  switch locationManager.authorizationStatus {
//  case .restricted, .denied:
//      camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 10.0)
//       mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//  default:
//      currentLoc = locationManager.location
//
//      camera = GMSCameraPosition.camera(withLatitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude, zoom: 10.0)
//       mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//    marker.position = CLLocationCoordinate2D(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
//  }
       
        MapView.defaultCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: lat,longitude: lon), zoom: 8.0)
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: MapView.defaultCamera)
        
//        camera = GMSCameraPosition.camera(withLatitude: locationManager.lastLocation?.coordinate.latitude ?? 0.0, longitude: locationManager.lastLocation?.coordinate.longitude ?? 0.0, zoom: 10.0)
//         mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        marker.title = ""
//           marker.snippet = "India"
//           marker.map = mapView
//          // marker.icon = UIImage(named: "location-1")
       // marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.mapView.animate(to:  MapView.defaultCamera)
        marker.isDraggable  = true
        mapView.selectedMarker = marker
        marker.tracksInfoWindowChanges = true
        //reverseGeocoding(marker: marker)
        //self.mapView.delegate = self
        UserDefaults.standard.set(lat, forKey: "lat")
        UserDefaults.standard.set(lon, forKey: "long")
        marker.map = mapView
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = false
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = true
        mapView.settings.tiltGestures = true
        mapView.isIndoorEnabled = false
        return mapView
    }
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {

        guard let lat = self.mapView.myLocation?.coordinate.latitude
            else{
                return false
        }
        guard   let lng = self.mapView.myLocation?.coordinate.longitude
            else{
                return false
   }
        camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng
            , zoom: 10.0)
        
        self.mapView.animate(to: camera)
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
       // reverseGeocoding(marker: marker)
        return true

    }
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        
        print("locitem ::::%@",locitem.count)
        
        for city in locitem {

            let marker1 : GMSMarker = GMSMarker()
            marker1.position = CLLocationCoordinate2D(latitude: Double(city.latitude)!, longitude: Double(city.longitude)!)
            marker1.title = city.Addrs
            marker1.snippet = city.diaryName
            marker1.map = mapView
            marker1.icon = UIImage(named: "loccc-2")

            }
        if(locitem.count > 0 )
        {
            let city1 = locitem[0]
//            camera = GMSCameraPosition.camera(withLatitude: Double(city1.latitude)!, longitude: Double(city1.longitude)!
//                , zoom: 10.0)
//            self.mapView.animate(to: camera)
            MapView.defaultCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: Double(city1.latitude)!,longitude: Double(city1.longitude)!), zoom: 12.0)

            marker1.position = CLLocationCoordinate2D(latitude: Double(city1.latitude)!, longitude: Double(city1.longitude)!)
            marker1.title = city1.Addrs
            marker1.snippet = city1.diaryName
            marker1.map = mapView
            marker1.icon = UIImage(named: "location-1")

        }
    }
}

//class MemberData: ObservableObject {
//    @Published var members = [friendseventmodalclassss]()
//
//    // Tells if all records have been loaded. (Used to hide/show activity spinner)
//    var membersListFull = false
//    // Tracks last page loaded. Used to load next page (current + 1)
//    var currentPage = 0
//    // Limit of records per page. (Only if backend supports, it usually does)
//    let perPage = 20
//
//    let url = URL(string: "https://testURL.com?page=\(currentPage+1)&perPage=\(perPage)")!
//    private var cancellable: AnyCancellable?
//
//    func fetchMembers() {
//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .tryMap { $0.data }
//            .decode(type: [friendseventmodalclassss].self, decoder: JSONDecoder())
//            .receive(on: RunLoop.main)
//            .catch { _ in Just(self.members) }
//            .sink { [weak self] in
//                self?.currentPage += 1
//                self?.members.append(contentsOf: $0)
//                // If count of data received is less than perPage value then it is last page.
//                if $0.count < perPage {
//                    self?.membersListFull = true
//                }
//        }
//    }
//}
struct friendseventmodalclassss : Hashable{
    var  eventId : String
   
         var  userId : String
    var    longitude : String
    var    latitude : String
    var    diaryName : String
    var    diaryDescription  : String
    var    date : String
    var Files : NSArray
    var Notes : NSArray
    var    audioCount : String
    var    vedioCount : String
    var    picCount : String
    var imageArray : [String]
    var    Addrs : String
    var    username : String
    var    profilePictureURL : String

    init(_ eventId:String,_ userId:String,_ longitude:String,_ latitude:String,_ diaryName:String,_ diaryDescription:String,_ date:String,_ Files:NSArray,_ Notes:NSArray,_ audioCount:String,_ vedioCount:String,_ picCount:String,_ imageArray:[String],_ Addrs:String,_ username:String,_ profilePictureURL:String){
       self.eventId  = eventId
       self.userId = userId
        self.longitude = longitude
        self.latitude = latitude
        self.diaryName = diaryName
        self.diaryDescription = diaryDescription
        self.date = date
        self.audioCount = audioCount
        self.vedioCount = vedioCount
        self.picCount = picCount
        self.Files = Files
        self.Notes = Notes
        self.imageArray = imageArray
        self.Addrs = Addrs
        self.username = username
        self.profilePictureURL = profilePictureURL
    }
}
struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
