//
//  GroupEventHome.swift
//  MapzApp
//
//  Created by Admin on 06/02/23.
//

import SwiftUI


import SwiftUI
import GoogleMaps
import GooglePlaces
import FloatingButton
import IQMediaPickerController
import Lightbox
import AVFoundation
import AVKit
import SVProgressHUD
import Alamofire

struct GroupEventHome: View {
    @State  var showCameraPopUp = false
    @State private var showVideoPopUp = false
    @State private var showrecdPopUp = false
    @State private var showdocPopUp = false
    @State private var Note = String()
    @Environment(\.presentationMode) var presentationMode
   // @ObservedObject var obs = profileinfoObserver()

    @State var selectedTab =  String()
    @State var Addressstr  = String()
    @State var imgstr = "img_b"
    @State    var liftstr = "list_w"
   @State var showNextView = false
    @State var colr: String = ""
    @State  var latitt = 0.0
    @State  var longitt = 0.0
    @State var isClicked: Bool = false
    @State  var productitem: profileeventmodalclasssss? = nil
    @State var showupdateview = false    
    @State var showfriendlist: Bool = false
    @State var showFilterList: Bool = false

    @State  var showsetting = false

    @State  var showlist = false
    @State  var showFriendlist = false

      @State  var showbotton = false

      @State  var showcollc = true
    @State var evntID = String()

    @State var sharedUrl = String()
    @State var heightview : CGFloat = 370
    @State var heightplus : CGFloat = 35
    
    @State  var Groupname = String()
    @State  var Groupmnger = String()
    @State  var Groupimage = String()

    
    
    static let iconImageNames = [
        "camera.fill",
        "video.fill",
        "mic.fill",
        "doc.fill"
    ]
    var body: some View {
        ZStack {
           // GoogleMApView()
            VStack{
                
                Spacer()
                      .frame(height :heightplus)
                    VStack(spacing: 0.0){
                        
                        
                          HStack{
                   //  Spacer(minLength: 12)
                              Button(action: {
                                  presentationMode.wrappedValue.dismiss()
                           
                              }) {
                                  Image("back")
                                      .resizable()
                                      .frame(width: 32.0, height: 32.0)
                                  //    .padding(.top,12.0)
                                  //.cornerRadius(24)
                              }
                            Spacer()
                              
                              
                          }
                       //   .padding(.horizontal, 10.0)
                        
                        
//                        HStack{
//
//                            Image("back")
//                                .resizable()
//                                .frame(width : 32 ,height: 32)
//                            Spacer()
//                        }
//                        .onTapGesture {
//                            showsetting.toggle()
//                        }
//                        
//                        .fullScreenCover(isPresented: $showsetting, content: {
//                            SettingVIew()
//                        })
                     
                        
                      //  .frame(height: 32)

//                    HStack(alignment: .center, spacing: 10.0){
//
//                        VStack{
//                    AsyncImage(
//                        url: NSURL(string: Groupimage)! as URL ,
//                                       placeholder: { Image("icons8-male-user-72")
//
//                                        .resizable()
//                                        .foregroundColor(colorGrey1)
//                                        .aspectRatio(contentMode: .fill)
//                                       },
//                                                   image: { Image(uiImage: $0).resizable()
//
//                                    }
//                                   )
//                   // Image("icons8-male-user-72")
//
//                    .frame(width: 60, height: 60)
//                     .cornerRadius(30)
//                     .aspectRatio(contentMode: .fit)
//
//                        }
//                        VStack(alignment: .leading, spacing: 5.0){
//                            Text(Groupname )
//                    .font(.custom("Inter-Bold", size: 19))
//
//                            Text(Groupmnger)
//                                .font(.custom("Inter-Regular", size: 14))
//
////                            Text(UserDefaults.standard.string(forKey: "tagLine") ?? "")
////                                .font(.custom("Inter-Regular", size: 14))
//
//                        }
//                        Spacer()
//
//                    }
//                        Spacer()
//                            .frame(height: 7.0)
//                        HStack(spacing: 20.0) {
//
//                        }
//
//                        .frame(width :UIScreen.main.bounds.width-20 , height: 1.0)
//                        .background(Color.black)
//                        Spacer()
                         //   .frame(height: 10.0)
//                        HStack(spacing: 0.0){
//                       // Spacer()
//                       HStack(alignment: .center){
//                           Text("Diary")
//                               .font(.custom("Inter-Bold", size: 16))
//                            Text(String(UserDefaults.standard.integer(forKey: "totalEvent")))
//                                .font(.custom("Inter-Bold", size: 18))
//                               // .foregroundColor(Color("yellowColor"))
//                               // .foregroundColor(Color.white)
//                        }
//                       //.padding(.horizontal, 15.0)
//
//                       .frame(width : UIScreen.main.bounds.width/3-10,height: 30)
//                       .onTapGesture{
//                           showlist = true
//                          // showcollc = false
//                       }
//                            HStack(alignment: .center){
//
//                            }
//                            //.padding(.horizontal, 15.0)
//
//                            .frame(width : 2,height: 20)
//                            .background(Color.black)
//
//                            HStack(alignment: .center){
//                                Text("Friends")
//                                    .font(.custom("Inter-Bold", size: 16))
//
//                                 Text(String(UserDefaults.standard.integer(forKey: "totalFriend")))
//                                     .font(.custom("Inter-Bold", size: 18))
//                                    // .foregroundColor(Color("yellowColor"))
//
//
//
//                                    // .foregroundColor(Color.white)
//                             }
//                            .onTapGesture {
//                                showfriendlist.toggle()
//                            }
//                            .fullScreenCover(isPresented: $showfriendlist, content: {
//                                FriendsListSearching()
//                            })
//
//
//                            //.padding(.horizontal, 15.0)
//
//                            .frame(width : UIScreen.main.bounds.width/3 - 10,height: 30)
//
//                            HStack(alignment: .center){
//
//                            }
//                            //.padding(.horizontal, 15.0)
//                            .frame(width : 2,height: 20)
//                            .background(Color.black)
//
//                            HStack(alignment: .center){
//
//
//                                 Text("Filter")
//                                     .font(.custom("Inter-Bold", size: 16))
//                                    // .foregroundColor(Color.white)
//                             }
//                            //.padding(.horizontal, 15.0)
//
//                            .frame(width : UIScreen.main.bounds.width/3-10,height: 30)
//                            .onTapGesture {
//                                showFilterList.toggle()
//                            }
//                            .fullScreenCover(isPresented: $showFilterList, content: {
//                                FilterView()
//                            })
//
//
//                        }
                    }
//                    .padding(.horizontal, 10.0)
//                    .frame(width: UIScreen.main.bounds.width , height: 110)
                
                ZStack{
                    VStack{
                        GroupGoogleMapAdapterView()
                            .frame(width: UIScreen.main.bounds.width)
                            
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    
                    
                         VStack{
                             VStack(spacing : 15){
                                 HStack(spacing : 20){
                                     Button(action: {
                                         UserDefaults.standard.set("camera", forKey: "fromwhere")
                                      //   showCameraPopUp = false
                                         showVideoPopUp = false
                                         showrecdPopUp = false
                                         showdocPopUp = false
                                        
                                         self.createEvent()
                                     }, label: {
                                         Image(systemName: "camera")
                                             .resizable()
                                             .frame(width:24, height: 24)
                                     })//buttoncolor
                                     .frame(width:60, height: 60)
                                     .background((Color("themecolor 1")))
                                     .foregroundColor(.white)
                                     .cornerRadius(10)
                                     
                                     Button(action: {
                                         
                                         showCameraPopUp = false
                                            showVideoPopUp = false
                                      //      showrecdPopUp = false
                                            showdocPopUp = false
                                    // showrecdPopUp = true
                                         UserDefaults.standard.set("audio", forKey: "fromwhere")
                                         self.createEvent()
                                     }, label: {
                                         Image(systemName: "mic.fill")
                                             .resizable()
                                             .frame(width:24, height: 24)
                                     })
                                     .frame(width:60, height: 60)
                                     .background((Color("themecolor 1")))
                                     .foregroundColor(.white)
                                     .cornerRadius(10)
                                 }
                                 
                                 HStack(spacing : 20){
                                     Button(action: {
                                         UserDefaults.standard.set("video", forKey: "fromwhere")
                                         showCameraPopUp = false
                                     //       showVideoPopUp = false
                                            showrecdPopUp = false
                                            showdocPopUp = false
                                        // self.showVideoPopUp = true
                                         self.createEvent()
                                     }, label: {
                                         Image(systemName: "video.fill")
                                             .resizable()
                                             .frame(width:24, height: 24)
                                     })
                                     .frame(width:60, height: 60)
                                     .background((Color("themecolor 1")))
                                     .foregroundColor(.white)
                                     .cornerRadius(10)
                                     
                                     Button(action: {
                                         
                                         showCameraPopUp = false
                                            showVideoPopUp = false
                                            showrecdPopUp = false
                                    // showdocPopUp = true
                                         UserDefaults.standard.set("notes", forKey: "fromwhere")

                                         self.createEvent()
                                     }, label: {
                                         Image(systemName: "doc.fill")
                                             .resizable()
                                             .frame(width:24, height: 24)
                                     })
                                     .frame(width:60, height: 60)
                                     .background((Color("themecolor 1")))
                                     .foregroundColor(.white)
                                     .cornerRadius(10)
                                 }
                                
                             }.fullScreenCover(isPresented: $showCameraPopUp, content:{
                                 if((UserDefaults.standard.string(forKey: "fromwhere")) == "notes"){
                                     createNotes(fromgroup : "yes")
                                 }
                                 else{
                                     CreateEventView()
                                 }
                             })
                            // }
                             
                             
                         let mainButton2 = AnyView(MainButton(imageName: "icons8-plus-24", colorHex: "2ABBFE"))
                            // .frame(width: 70, height: 70)

                       
                         }
                         .offset(y : UIScreen.main.bounds.height/2 - 230 )
                         
                         
                   
                }
                
                
            }.onAppear(){//"duration"
                if UIDevice.current.hasNotch {
                    heightplus = 35
                } else {
                    //... don't have to consider notch
                    heightplus = 20
                }
                showupdateview = false
                UserDefaults.standard.set(0, forKey: "index")
                UserDefaults.standard.set("", forKey: "duration")
//                obs.eventlist = []
//                obs.iq = 1
//                obs.page = 0
//                obs.fetchEvent()
            
            }
         

            Spacer()
               
//            if $showVideoPopUp.wrappedValue {
//                ZStack {
//                   //
//                    Color.white
//                    VStack(alignment: .center, spacing: 20.0) {
//                        Spacer()
//                        Text("Add New Videos")
//                            .font(.custom("Inter-Bold", size: 24))
//                            .foregroundColor(Color("themecolor"))
//                        Spacer()
//                        Button(action: {
//                            //
//                            self.showVideoPopUp = false
//                        }, label: {
//                            Text("Click Using Camera")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//
//                        Button(action: {
//                             self.showVideoPopUp = false
//                        }, label: {
//                            Text("Choose from gallery")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        Spacer()
//                    }.padding()
//
//
//                }
//                .frame(width: UIScreen.main.bounds.width-60, height: 260)
//                .cornerRadius(20)
//                .shadow(color: .gray, radius: 3, x: 1, y: 1)
//            }
            
            
//            if $showrecdPopUp.wrappedValue {
//                ZStack {
//                   //
//                    Color.white
//                    VStack(alignment: .center, spacing: 20.0) {
//                        Spacer()
//                        Text("Add New Voices")
//                            .font(.custom("Inter-Bold", size: 24))
//                            .foregroundColor(Color("themecolor"))
//                        Spacer()
//                        Button(action: {
//                            //
//                            self.showrecdPopUp = false
//                        }, label: {
//                            Text("Record  Using Mobile")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//
//                        Button(action: {
//                             self.showrecdPopUp = false
//                        }, label: {
//                            Text("Choose from device")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        Spacer()
//                    }.padding()
//
//
//                }
//                .frame(width: UIScreen.main.bounds.width-60, height: 400)
//                .cornerRadius(20)
//                .shadow(color: .gray, radius: 3, x: 1, y: 1)
//            }
            
//            if $showdocPopUp.wrappedValue {
//                ZStack {
//                   //
//                    Color.white
//                    VStack(alignment: .center, spacing: 20.0) {
//                        Spacer()
//                        Text("Add New Note")
//                            .font(.custom("Inter-Bold", size: 24))
//                            .foregroundColor(Color("themecolor"))
//
//
//
//
//                        TextField("Note", text: $Note)
//                            .font(.custom("Inter-Regular", size: 17))
//                            .frame(width: UIScreen.main.bounds.width-100, height: 200)
//                            .border(Color.gray, width: 0.5)
//                            //.cornerRadius(10)
//
////                        Button(action: {
////                            //
////                            self.showCameraPopUp = false
////                        }, label: {
////                            Text("Record  Using Mobile")
////                                .font(.custom("Inter-Bold", size: 18))
////                        })
////                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
////                        .background((Color("themecolor 1")))
////                        .foregroundColor(.white)
////                        .cornerRadius(10)
//
//                        Button(action: {
//                             self.showdocPopUp = false
//                        }, label: {
//                            Text("Add")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//
//                    }.padding()
//
//
//                }
//                .frame(width: UIScreen.main.bounds.width-60, height: 400)
//                .cornerRadius(20)
//                .shadow(color: .gray, radius: 3, x: 1, y: 1)
//            }
        }
    }
    func createEvent() {
        
        var logInFormData: Parameters {
            [
                "latitude": UserDefaults.standard.double(forKey: "lat"), //Double(UserDefaults.standard.string(forKey: "lat")!)!,
                "longitude":  UserDefaults.standard.double(forKey: "long"),
                "createdAt": "2021-09-23T14:07:41",
                  "dbUserId":UserDefaults.standard.string(forKey: "id") ?? "" ,
                "Address": UserDefaults.standard.string(forKey: "Address") ?? "",
                "Groupid1" : UserDefaults.standard.double(forKey: "groupId"),
                "IsGroup1" : "true"
                  ]
        
        }
       
            print(logInFormData)

            ///api/EventDiary/CreateEventDiary
                    AccountAPI.signin(servciename: "EventDiary/CreateEventDiary", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                           
                           
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                                     let userdic = json["data"]

                                let dateFormatter : DateFormatter = DateFormatter()
                                //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                let date = Date()
                                let dateString = dateFormatter.string(from: date)
                                
                              
                                
                                UserDefaults.standard.set(userdic["id"].int, forKey: "eventID")
                                UserDefaults.standard.set(dateString, forKey: "datestr")
                                UserDefaults.standard.set("New", forKey: "eventNOE")
                                UserDefaults.standard.set("yes", forKey: "isGroup")

                                showCameraPopUp.toggle()

//                                if (UserDefaults.standard.string(forKey: "fromwhere") == "notes"){
//                                    showdocPopUp = true
//                                }
//                                else{
//
//
//
//                                }
                       
                            }
                            else{
                            //
                            
                     //        AlertToast(displayMode: .alert, type: .regular, title: json["ResponseMsg"].stringValue )
                     //        AlertToast(displayMode: .alert, type: .regular, title:json["ResponseMsg"].stringValue )

                            }
                            
                        }
                    case let .failure(error):
                      print(error)
                    }
                  }
        }
}

struct GroupEventHome_Previews: PreviewProvider {
    static var previews: some View {
        GroupEventHome()
    }
}


import GoogleMaps
import CoreLocation

struct GroupGoogleMapAdapterView: UIViewRepresentable {
     
    typealias UIViewType = GMSMapView
    let marker : GMSMarker = GMSMarker()

    private static var defaultCamera = GMSCameraPosition.camera(withLatitude: 77.8136, longitude: 28.767677, zoom: 10.0)
  
    @State var camera = GMSCameraPosition()
    @State var mapView = GMSMapView()
    @State  var mapDelegateWrapper = GroupGMSMapViewDelegateWrapper()

    @State var mapDelegate = GroupGMSMapViewDelegateWrapper()
    
    init() {
        
       
   }
    func reverseGeocoding(marker: GMSMarker) {
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(Double(marker.position.latitude),Double(marker.position.longitude))
        
        var currentAddress = String()
//        UserDefaults.standard.set(String(marker.position.latitude), forKey: "lat")
//        UserDefaults.standard.set(String(marker.position.longitude), forKey: "long")

        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                let lines1 = address.lines! as [String]
                
                print("Response is = \(address)")
                print("Response line is = \(lines1)")
                
                currentAddress = lines1.joined(separator: "\n")
                
              
            marker.title = currentAddress
            marker.map = self.mapView
                UserDefaults.standard.set(currentAddress, forKey: "Address")
                

       
            }
    
        }
    }
   
    
    
    /// Creates a `UIView` instance to be presented.
    
     func makeUIView(context: Self.Context) -> UIViewType {
        print("IPPROTO_HELLO:::%@","IPPROTO_HELLO")
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        var currentLocation: CLLocation!
        var lat = 28.630863
        var lon = 77.375475
        
        if CLLocationManager.locationServicesEnabled() {
            switch locManager.authorizationStatus {
            case .restricted, .denied:
                    print("Location services are not enabled")
               
            default:
                    currentLocation = locManager.location
                if (currentLocation != nil){
                    lat   = Double(currentLocation.coordinate.latitude)
           
                    lon   = Double(currentLocation.coordinate.longitude)
                }
               
                }
            } else {
                print("Location services are not enabled")
            }
      
     
//
//        let lat = Double(userLatitude)!
//        let lon = Double(userLongitude)!
//        var lat = Double()
//
        
      
//
        print(lat)

        print(lon)
        
      
      
        GroupGoogleMapAdapterView.defaultCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: lat,longitude: lon), zoom: 8.0)
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GroupGoogleMapAdapterView.defaultCamera)
        
        mapView.isMyLocationEnabled = true
       
       //
        //self.mapView = mapView
//
        self.mapDelegate = mapDelegateWrapper
//
        self.mapView.delegate = mapDelegateWrapper
        mapView.setMinZoom(14, maxZoom: 20)
            
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
       
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = false
        mapView.settings.rotateGestures = false
        mapView.settings.tiltGestures = false
        mapView.isIndoorEnabled = false
        
        
        
        marker.title = ""
           marker.snippet = "India"
           marker.map = mapView
           marker.icon = UIImage(named: "location-1")
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.mapView.animate(to: GroupGoogleMapAdapterView.defaultCamera)

        marker.isDraggable  = true
        mapView.selectedMarker = marker
        marker.tracksInfoWindowChanges = true
        reverseGeocoding(marker: marker)
        //self.mapView.delegate = self
        UserDefaults.standard.set(lat, forKey: "lat")
        UserDefaults.standard.set(lon, forKey: "long")
        marker.map = mapView
        return mapView
    }

    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ mapView: UIViewType , context: Self.Context) {
        print("mapView:::%@",mapView)

    }
    
   
    func update(cameraPosition: GMSCameraPosition) -> some View {
        mapView.animate(to: cameraPosition)
        print("cameraPosition:::%@",cameraPosition)
        return self
    }
    
    func update(zoom level: Float) -> some View {
        mapView.animate(toZoom: level)
        return self
    }

}
import GoogleMaps

@objc
class GroupGMSMapViewDelegateWrapper: NSObject, GMSMapViewDelegate {
  //  var gmap = GroupGoogleMapAdapterView()
    var shouldHandleTap: Bool = true
    
    deinit {
        
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return shouldHandleTap
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker)
    {
       // gmap.reverseGeocoding(marker: marker)
      //  GroupGoogleMapAdapterView.reverseGeocoding(marker: marker)
      
        //self.mapView.delegate = self
        UserDefaults.standard.set(mapView.myLocation?.coordinate.latitude, forKey: "lat")
        UserDefaults.standard.set(mapView.myLocation?.coordinate.longitude, forKey: "long")
      //  gmap.marker.map = mapView
        print(mapView.myLocation?.coordinate.latitude as Any)
        print(mapView.myLocation?.coordinate.longitude as Any)

        self.reverseGeocoding(marker: marker)
//        if marker.userData as! String == "changedestination"
//        {
//            self.destinationLocation = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
//            self.destinationCoordinate = self.destinationLocation.coordinate
//            //getAddressFromLatLong(destinationCoordinate)
//        }
    }
    func reverseGeocoding(marker: GMSMarker) {
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(Double(marker.position.latitude),Double(marker.position.longitude))
        
        var currentAddress = String()
        UserDefaults.standard.set(String(marker.position.latitude), forKey: "lat")
        UserDefaults.standard.set(String(marker.position.longitude), forKey: "long")

        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                let lines1 = address.lines! as [String]
                
                print("Response is = \(address)")
                print("Response line is = \(lines1)")
                
                currentAddress = lines1.joined(separator: "\n")
                
              
            marker.title = currentAddress
            //marker.map = self.mapView
                UserDefaults.standard.set(currentAddress, forKey: "Address")
                

       
            }
    
        }
    }
   
    
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        print("hello")

        
        print(CLLocationCoordinate2D())
    }
    
    
    
}

//struct GoogleMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupGoogleMapAdapterView()
//    }
//}


