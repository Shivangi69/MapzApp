//
//  HomeView.swift
//  MapzApp
//
//  Created by Misha Infotech on 16/08/2021.
//

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

struct HomeView: View {
    @State  var showCameraPopUp = false
    @State private var showVideoPopUp = false
    @State private var showrecdPopUp = false
    @State private var showdocPopUp = false
    @State private var Note = String()
   //
   // @ObservedObject var mycamera = camerastuff()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var obs = profileinfoObserver()

    
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
                            Spacer()
                            Image("icons8-setting-100")
                                .resizable()
                                .frame(width : 32 ,height: 32)

                        }
                        .onTapGesture {
                            showsetting.toggle()
                        }
                        
                        .fullScreenCover(isPresented: $showsetting, content: {
                            SettingVIew()
                        })
                        
                        .frame(height: 32)

                    HStack(alignment: .center, spacing: 10.0){
                    
                        VStack{
                    AsyncImage(
                        url: NSURL(string: UserDefaults.standard.string(forKey: "profilePictureURL") ?? "")! as URL ,
                                       placeholder: { Image("icons8-male-user-72")
                                      
                                        .resizable()
                                        .foregroundColor(colorGrey1)
                                        .aspectRatio(contentMode: .fill)
                                       },
                                                   image: { Image(uiImage: $0).resizable()
                                                    
                                    }
                                   )
                   // Image("icons8-male-user-72")
                     
                    .frame(width: 60, height: 60)
                     .cornerRadius(30)
                     .aspectRatio(contentMode: .fit)
                     .overlay(
                         Circle()
                             .stroke(Color.black, lineWidth: 2) // You can customize the color and lineWidth
                     )
                     .clipShape(Circle())
                  
                    
                        }
                        VStack(alignment: .leading, spacing: 5.0){
                Text(UserDefaults.standard.string(forKey: "name") ?? "")
                    .font(.custom("Inter-Bold", size: 19))
                    
                            Text(UserDefaults.standard.string(forKey: "dateOfBirth") ?? "")
                                .font(.custom("Inter-Regular", size: 14))
                            
                            Text(UserDefaults.standard.string(forKey: "tagLine") ?? "")
                                .font(.custom("Inter-Regular", size: 14))
                            
                        }
                        Spacer()
                    
                    }
                        Spacer()
                            .frame(height: 7.0)
                        HStack(spacing: 50.0) {
                          
                             
                        }
                        
                        .frame(width :UIScreen.main.bounds.width-10 , height: 1.0)
                        .background(Color.black)
                        Spacer()
                            .frame(height: 10.0)
                        HStack(spacing: 0.0){
                       // Spacer()
                       HStack(alignment: .center){
                           Text("Diary")
                               .font(.custom("Inter-Regular", size: 14))
                            Text(String(UserDefaults.standard.integer(forKey: "totalEvent")))
                                .font(.custom("Inter-Bold", size: 14))
                                .fontWeight(.bold)

                               // .foregroundColor(Color("yellowColor"))
                               // .foregroundColor(Color.white)
                        }
                       //.padding(.horizontal, 15.0)

                       .frame(width : UIScreen.main.bounds.width/3-10,height: 30)
                       .onTapGesture{
                           showlist = true
                          // showcollc = false
                       }
                            HStack(alignment: .center){
                                
                            }
                            //.padding(.horizontal, 15.0)
                            
                            .frame(width : 2,height: 20)
                            .background(Color.black)
                            
                            HStack(alignment: .center){
                                Text("Friends")
                                    .font(.custom("Inter-Regular", size: 14))

                                 Text(String(UserDefaults.standard.integer(forKey: "totalFriend")))
                                     .font(.custom("Inter-Bold", size: 14))
                                    // .foregroundColor(Color("yellowColor"))
                                 
                                     .fontWeight(.bold)

                               
                                    // .foregroundColor(Color.white)
                             }
                            .onTapGesture {
                                showfriendlist.toggle()
                            }
                            .fullScreenCover(isPresented: $showfriendlist, content: {
                                FriendsListSearching()
                            })
                            
                            
                            //.padding(.horizontal, 15.0)

                            .frame(width : UIScreen.main.bounds.width/3 - 10,height: 30)
                            
                            HStack(alignment: .center){
                                
                            }
                            //.padding(.horizontal, 15.0)
                            .frame(width : 2,height: 20)
                            .background(Color.black)
                            
                            HStack(alignment: .center){
                                 
                                 Text("Filter")
                                    .font(.custom("Inter-Regular", size: 14))
                                    // .foregroundColor(Color.white)
                             }
                            //.padding(.horizontal, 15.0)

                            .frame(width : UIScreen.main.bounds.width/3-10,height: 30)
                            .onTapGesture {
                                showFilterList.toggle()
                            }
                            .fullScreenCover(isPresented: $showFilterList, content: {
                                FilterView()
                            })
                            
                      
                        }
                    }
                    .padding(.horizontal, 20.0)
                    .frame(width: UIScreen.main.bounds.width-10 , height: 170)
                
                ZStack{
                    VStack{
                        GoogleMapAdapterView()
                            .frame(width: UIScreen.main.bounds.width)
                            
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    
                     if (showlist ){
                         VStack(alignment: .center, spacing: 0.0){
                             ScrollView{
                                 ForEach(Array(obs.eventlist.enumerated()), id: \.offset) { index, pokemon in
                                     VStack(alignment: .center, spacing: 0.0){
                                         //  ForEach(obs.eventlist, id: \.self) { pokemon in
                                         HStack{
                                             Image("loccc-2")
                                                 .resizable()
                                                 .frame(width: 20.0, height: 40.0)
                                                 .padding()
                                             
                                             VStack(alignment: .leading){
                                                 Text(pokemon.diaryName  + pokemon.date)
                                                     .font(.custom("Inter-Bold", size: 16))
                                                 
                                                 Text(pokemon.Addrs)
                                                     .font(.custom("Inter-Regular", size: 15))
                                                     .lineLimit(2)
                                                 
                                             }
                                             Spacer()
                                             
                                         }
                                         // .padding(.horizontal)
                                         .frame(width: UIScreen.main.bounds.width)
                                         .background(Color.white)
                                         .onTapGesture() {
                                             print("Double Tap!")
                                             
                                             selectedTab = pokemon.eventId
                                             Addressstr = pokemon.Addrs
                                             colr = "lightBlue"
                                             print(Addressstr)
         //                                    obs.selector = index
         //                                    obs.Latit = Double(pokemon.latitude) ?? 0.0
         //                                    obs.Longit = Double(pokemon.longitude) ?? 0.0
                                             UserDefaults.standard.set(index, forKey: "index")
                                             productitem = pokemon
                                             UserDefaults.standard.set("Edit", forKey: "eventNOE")
                                             UserDefaults.standard.set(productitem?.eventId, forKey: "eventID")
                                             showupdateview = true
                                             
                                         }
                                         
                                     }
                                 }
                                 
                                 //                            listvieww()
                                 
                             }
                         }   .frame(width :UIScreen.main.bounds.width )
                             .background(Color.white)
                     }else{
                         VStack{
                             
                             
                             
                             
                             VStack(spacing : 15){
                                 HStack(spacing : 20){
                                     Button(action: {
                                         UserDefaults.standard.set("camera", forKey: "fromwhere")
                                      //   showCameraPopUp = false
                                         showVideoPopUp = false
                                         showrecdPopUp = false
                                         showdocPopUp = false
                                         //
                                        // showCameraPopUp = true
                                        //
                                         //
                                         self.createEvent()
                                     }, label: {
                                         Image(systemName: "camera")
                                             .resizable()
                                             .frame(width:40, height: 30)
                                     })//buttoncolor
                                     .frame(width:60, height: 60)
                                     .background((Color("themecolor")))
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
                                         Image(systemName: "mic")
                                             .resizable()
                                             .frame(width:30, height: 30)
                                     })
                                     .frame(width:60, height: 60)
                                     .background((Color("themecolor")))
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
                                         Image("videonew")
                                             .resizable()
                                             .frame(width:35, height: 35)
                                     })
                                     .frame(width:60, height: 60)
                                     .background((Color("themecolor")))
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
                                         Image("Vectortoo")
                                             .resizable()
                                             .frame(width:24, height: 24)
                                     })
                                     .frame(width:60, height: 60)
                                     .background((Color("themecolor")))
                                     .foregroundColor(.white)
                                     .cornerRadius(10)
                                 }
                                
                             }
                             .fullScreenCover(isPresented: $showCameraPopUp, content:{
                                 if((UserDefaults.standard.string(forKey: "fromwhere")) == "notes"){
                                     createNotes()
                                 }
                                 else{
                                     CreateEventView()
                                 }
                             })
                            // }
                             
                             
                         let mainButton2 = AnyView(MainButton(imageName: "icons8-plus-24", colorHex: "2ABBFE"))
                            // .frame(width: 70, height: 70)

//                         let buttonsImage = (0..<HomeView.iconImageNames.count).map { i in
//                             AnyView(IconButton(imageName: HomeView.iconImageNames[i], color: Color("themecolor"))
//                                         .onTapGesture {
//                                            let str  = HomeView.iconImageNames[i]
//                                             if str == "camera.fill"{
//                                                 UserDefaults.standard.set("camera", forKey: "fromwhere")
//                                              //   showCameraPopUp = false
//                                                 showVideoPopUp = false
//                                                 showrecdPopUp = false
//                                                 showdocPopUp = false
//                                                 //
//                                                // showCameraPopUp = true
//                                                //
//                                                 //
//                                                 self.createEvent()
//                                             }
//                                             if str == "video.fill"{
//                                                 UserDefaults.standard.set("video", forKey: "fromwhere")
//                                                 showCameraPopUp = false
//                                             //       showVideoPopUp = false
//                                                    showrecdPopUp = false
//                                                    showdocPopUp = false
//                                                // self.showVideoPopUp = true
//                                                 self.createEvent()
//                                             }
//                                             if str == "mic.fill"{
//
//                                                 showCameraPopUp = false
//                                                    showVideoPopUp = false
//                                              //      showrecdPopUp = false
//                                                    showdocPopUp = false
//                                            // showrecdPopUp = true
//                                                 UserDefaults.standard.set("audio", forKey: "fromwhere")
//                                                 self.createEvent()
//                                             }
//                                             if str == "doc.fill"{
//
//                                                 showCameraPopUp = false
//                                                    showVideoPopUp = false
//                                                    showrecdPopUp = false
//                                            // showdocPopUp = true
//                                                 UserDefaults.standard.set("notes", forKey: "fromwhere")
//
//                                                 self.createEvent()
//                                             }
//                                         }
//                                         .fullScreenCover(isPresented: $showCameraPopUp, content:{
//                                             if((UserDefaults.standard.string(forKey: "fromwhere")) == "notes"){
//                                                 createNotes()
//                                             }
//                                             else{
//                                                 CreateEventView()
//                                             }
//                                         })
//             //                             .fullScreenCover(isPresented: $showdocPopUp, content: createNotes.init)
//                             )
//
//                         }
//                         let menu2 = FloatingButton(mainButtonView: mainButton2, buttons: buttonsImage)
//                             .circle()
//                             .delays(delayDelta: 0.1)
//                             .frame(width: 70, height: 70)
//                         menu2
//             //                    Color("yellowColor")
//             //                        .ignoresSafeArea()

                         }
                         .offset(y : UIScreen.main.bounds.height/2 - 230 )
                         
                         
                     }
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
                obs.eventlist = []
                obs.iq = 1
            obs.page = 0
                obs.fetchEvent()
            
            }
         

            Spacer()
           // Text("Hello, World!")
  
            
//            if $showCameraPopUp.wrappedValue {
//                ZStack {
//                   //
//                    Color.white
//                    VStack(alignment: .center, spacing: 20.0) {
//                        Spacer()
//                        Text("Add New Photos")
//                            .font(.custom("Inter-Bold", size: 24))
//                            .foregroundColor(Color("themecolor"))
//                        Spacer()
//                        Button(action: {
//                            //
//                            self.showCameraPopUp = false
//                           //
//                         //   mycamera.showviewr()
////                          let  gallery = GalleryController()
////                            gallery.delegate = self
//
//                      //      present(gallery, animated: true, completion: nil)
//                            
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
//                             self.showCameraPopUp = false
//                            
////                           var  controller =  IQMediaPickerController()
////                            controller.delegate = self
//                        }, label: {
//                            Text("Choose from gallery")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        
//                        Spacer()
//                    }.padding()
//                   
//
//                }
//                .frame(width: UIScreen.main.bounds.width-60, height: 260)
//                .cornerRadius(20)
//                .shadow(color: .gray, radius: 3, x: 1, y: 1)
//            }
            
            
            
            if $showVideoPopUp.wrappedValue {
                ZStack {
                   //
                    Color.white
                    VStack(alignment: .center, spacing: 20.0) {
                        Spacer()
                        Text("Add New Videos")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("themecolor"))
                        Spacer()
                        Button(action: {
                            //
                            self.showVideoPopUp = false
                        }, label: {
                            Text("Click Using Camera")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(action: {
                             self.showVideoPopUp = false
                        }, label: {
                            Text("Choose from gallery")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Spacer()
                    }.padding()
                   

                }
                .frame(width: UIScreen.main.bounds.width-60, height: 260)
                .cornerRadius(20)
                
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
            
            
            if $showrecdPopUp.wrappedValue {
                ZStack {
                   //
                    Color.white
                    VStack(alignment: .center, spacing: 20.0) {
                        Spacer()
                        Text("Add New Voices")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("themecolor"))
                        Spacer()
                        Button(action: {
                            //
                            self.showrecdPopUp = false
                        }, label: {
                            Text("Record  Using Mobile")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(action: {
                             self.showrecdPopUp = false
                        }, label: {
                            Text("Choose from device")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Spacer()
                    }.padding()
                   

                }
                .frame(width: UIScreen.main.bounds.width-60, height: 400)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
            
            if $showdocPopUp.wrappedValue {
                ZStack {
                   //
                    Color.white
                    VStack(alignment: .center, spacing: 20.0) {
                        Spacer()
                        Text("Add New Note")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("themecolor"))
                          
                        
                        
                        
                        TextField("Note", text: $Note)
                            .font(.custom("Inter-Regular", size: 17))
                            .frame(width: UIScreen.main.bounds.width-100, height: 200)
                            .border(Color.gray, width: 0.5)
                            //.cornerRadius(10)

//                        Button(action: {
//                            //
//                            self.showCameraPopUp = false
//                        }, label: {
//                            Text("Record  Using Mobile")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)

                        Button(action: {
                             self.showdocPopUp = false
                        }, label: {
                            Text("Add")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                       
                    }.padding()
                   

                }
                .frame(width: UIScreen.main.bounds.width-60, height: 400)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
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
                "Groupid1" : "0",
                "IsGroup1" : "false"
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
                                UserDefaults.standard.set("no", forKey: "isGroup")

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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
//struct GoogleMApView: UIViewRepresentable {
//    let marker : GMSMarker = GMSMarker()
//    @State var camera = GMSCameraPosition()
//    @State var mapView = GMSMapView()
//    @StateObject var locationManager = LocationManager()
//
//        var userLatitude: String {
//            return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
//        }
//
//        var userLongitude: String {
//            return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
//        }
//
//    /// Creates a `UIView` instance to be presented.
//    func makeUIView(context: Self.Context) -> GMSMapView {
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
////        let camera = GMSCameraPosition.camera(withLatitude: (locationManager.lastLocation?.coordinate.latitude ?? 0), longitude: (locationManager.lastLocation?.coordinate.longitude ?? 0), zoom: 6.0)
////        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        var locManager = CLLocationManager()
//        locManager.requestWhenInUseAuthorization()
//
//        var currentLocation: CLLocation!
//
//        if
//           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
//           CLLocationManager.authorizationStatus() ==  .authorizedAlways
//        {
//            currentLocation = locManager.location
//        }
//
//
//        let lat = Double(userLatitude)!
//        let lon = Double(userLongitude)!
//
//       // (28.626526, 77.373582)
////        let lat = 28.526526
////        let lon = 77.473582
////        let lat = "\(currentLocation.coordinate.longitude)"
////        let lon = "\(currentLocation.coordinate.latitude)"
//        print("lat%@",lat)
//
//        print("lat%@",lon)
//
//       //
//        camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: lat,longitude: lon), zoom: 8.0)
//       // camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 8.0)
//
//        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//                mapView.setMinZoom(14, maxZoom: 20)
//               // mapView.settings.compassButton = true
//                mapView.isMyLocationEnabled = true
//
//                mapView.settings.myLocationButton = true
//               // mapView.settings.scrollGestures = true
//               // mapView.settings.zoomGestures = true
//              //  mapView.settings.rotateGestures = true
//              //  mapView.settings.tiltGestures = true
//              //  mapView.isIndoorEnabled = false
//
//
//
//        marker.title = ""
//           marker.snippet = "India"
//           marker.map = mapView
//           marker.icon = UIImage(named: "location-1")
//        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//        self.mapView.animate(to: camera)
//
//        marker.isDraggable  = true
//        mapView.selectedMarker = marker
//       // marker.tracksInfoWindowChanges = true
//        reverseGeocoding(marker: marker)
//        //self.mapView.delegate = self
//        UserDefaults.standard.set(lat, forKey: "lat")
//        UserDefaults.standard.set(lon, forKey: "long")
//print("userLatitude%@",userLatitude )
//        print("userLongitude%@",userLongitude )
//
//        marker.map = mapView
//                return mapView
//
//
//       // return mapView
//    }
//
//    /// Updates the presented `UIView` (and coordinator) to the latest
//    /// configuration.
//    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
////        if let myLocation = locationManager.lastLocation {
////                   mapView.animate(toLocation: myLocation.coordinate)
////                   print("User's location: \(myLocation)")
////            marker.position = CLLocationCoordinate2D(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude)
////            camera = GMSCameraPosition.camera(withLatitude:  mapView.camera.target.latitude, longitude: mapView.camera.target.longitude, zoom: 10.0)
////
////        }else{
////            marker.position = CLLocationCoordinate2D(latitude: 28.5355, longitude: 77.3910)
////
////        }
////        marker.position = CLLocationCoordinate2D(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude)
////
//
////        marker.position = camera.target
////        print(marker.position)
////        marker.position = CLLocationCoordinate2D(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude)
////        UserDefaults.standard.set(mapView.camera.target.latitude, forKey: "lat")
////        UserDefaults.standard.set(mapView.camera.target.longitude, forKey: "long")
//
//        //camera = GMSCameraPosition.camera(withLatitude:  mapView.camera.target.latitude, longitude: mapView.camera.target.longitude, zoom: 10.0)
////     marker.title = ""
////        marker.snippet = "India"
////        marker.map = mapView
////        marker.icon = UIImage(named: "location")
//
//
////        guard let lat = self.mapView.myLocation?.coordinate.latitude
////            else{
////                return
////        }
////        guard   let lng = self.mapView.myLocation?.coordinate.longitude
////            else{
////                return
////
////        }
////        camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng
////            , zoom: 6.0)
////        self.mapView.animate(to: camera)
////        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
////
//
//    }
//    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
//
//
//        guard let lat = self.mapView.myLocation?.coordinate.latitude
//            else{
//                return false
//        }
//        guard   let lng = self.mapView.myLocation?.coordinate.longitude
//            else{
//                return false
//
//
//        }
//
//        print("currunt Lat %@",lat);
//        print("Lat %@",lng);
//
//        camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng
//            , zoom: 6.0)
//        self.mapView.animate(to: camera)
//        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
////        UserDefaults.standard.set(lat, forKey: "lat")
////        UserDefaults.standard.set(lng, forKey: "long")
//
//        reverseGeocoding(marker: marker)
//
//        return true
//
//    }
//
//    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
//        print("Drag ended!")
//
//        let position =   GMSCameraPosition()
//        marker.position = camera.target
//        print(marker.position)
//        marker.position = CLLocationCoordinate2D(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude)
//        //        let c:String = String(format:"%.8f",mapView.camera.target.longitude)
//        //        let d:String = String(format:"%.8f",mapView.camera.target.latitude)
//        //        self .getAddressFromLatLon(pdblLatitude: c, withLongitude: d)
//        reverseGeocoding(marker: marker)
//
//    }
//
//    func reverseGeocoding(marker: GMSMarker) {
//        let geocoder = GMSGeocoder()
//        let coordinate = CLLocationCoordinate2DMake(Double(marker.position.latitude),Double(marker.position.longitude))
//
//        var currentAddress = String()
////        UserDefaults.standard.set(String(marker.position.latitude), forKey: "lat")
////        UserDefaults.standard.set(String(marker.position.longitude), forKey: "long")
//
//        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
//            if let address = response?.firstResult() {
//                let lines1 = address.lines! as [String]
//
//                print("Response is = \(address)")
//                print("Response line is = \(lines1)")
//
//                currentAddress = lines1.joined(separator: "\n")
//
//
//                // self.AddressdesTextField.text = String(format:"%@",lines1)
//
//                //                self.addresDic   = ["country":[address.country!] as [String],"state":[address.administrativeArea!] as [String],"city":[address.locality!] as [String],"Postalcode":[address.postalCode!] as [String]]
////                self.addressText.text = currentAddress
////                self.AddressdesTextField.text = currentAddress
////
////                if address.administrativeArea != nil {
////
////                    let lines1 = address.administrativeArea
////
////
////                    self.addresDic.setValue(lines1, forKey: "state")
////                }
////                if address.country != nil {
////
////                    self.addresDic.setValue(address.country, forKey: "country")
////                }
////                if address.locality != nil {
////
////                    self.addresDic.setValue(address.locality, forKey: "city")
////                }
////                if address.lines != nil {
////
////                    self.addresDic.setValue(self.addressText.text, forKey: "full")
////                }
////                if address.postalCode != nil {
////
////                    self.addresDic.setValue(address.postalCode, forKey: "Postalcode")
////                }
////                //  latitude":"","longitude":""
////                self.addresDic.setValue(Double(marker.position.latitude), forKey: "latitude")
////                self.addresDic.setValue(Double(marker.position.longitude), forKey: "longitude")
////                var lati = Double()
////
////                var longt = Double()
////                lati = marker.position.latitude
////                longt = marker.position.longitude
////                self.latstr  = String(format:"%.6f",lati) as NSString
////                 self.longstr  = String(format:"%.6f",longt) as NSString
////
////            }
////            print(self.addresDic)
////
//              //  userDefault.set(self.addresDic, forKey: "addrs")
//
//
//            marker.title = currentAddress
//            marker.map = self.mapView
//                UserDefaults.standard.set(currentAddress, forKey: "Address")
//
//
//        }
//    }
//
//    func mapViewDidStartTileRendering(_ mapView: GMSMapView) {
//        print("Drag start!")
//        marker.position = camera.target
//
//        print(marker.position)
//    }
//
//
//    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
//        print("Position of marker is = \(marker.position.latitude),\(marker.position.longitude)")
//        reverseGeocoding(marker: marker)
//        print("Position of marker is = \(marker.position.latitude),\(marker.position.longitude)")
//    }
//    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
//        print("didBeginDragging")
//    }
//    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
//        print("didDrag")
//    }
//
//    // Camera change Position this methods will call every time
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        marker.position = position.target
//        print(marker.position)
//        //        double latitude = mapView.camera.target.latitude;
//        //        double longitude = mapView.camera.target.longitude
//        //        //
//        // self .getAddressFromLatLon(pdblLatitude:latitude, withLongitude: longitude)
//
//    }
//
//}
//}
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        if CLLocationManager.locationServicesEnabled() {
                    locationManager.startUpdatingLocation()
                    //locationManager.startUpdatingHeading()
                }
    }

   
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
        if status == .authorizedWhenInUse {
            locationManager.delegate = self

            self.locationManager.startUpdatingLocation()
        }
        if status == .authorizedAlways {
            locationManager.delegate = self

            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
       // guard let location = locations.last else { return }
        lastLocation = locations.last
        print(#function, locations.last!)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}



import GoogleMaps
import CoreLocation

struct GoogleMapAdapterView: UIViewRepresentable {
     
    typealias UIViewType = GMSMapView
    let marker : GMSMarker = GMSMarker()

    private static var defaultCamera = GMSCameraPosition.camera(withLatitude: 77.8136, longitude: 28.767677, zoom: 10.0)
  
    @State var camera = GMSCameraPosition()
    @State var mapView = GMSMapView()
    @State  var mapDelegateWrapper = GMSMapViewDelegateWrapper()

    @State var mapDelegate = GMSMapViewDelegateWrapper()
    
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
        
      
      
        GoogleMapAdapterView.defaultCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: lat,longitude: lon), zoom: 8.0)
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GoogleMapAdapterView.defaultCamera)
        
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
        self.mapView.animate(to: GoogleMapAdapterView.defaultCamera)

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
class GMSMapViewDelegateWrapper: NSObject, GMSMapViewDelegate {
  //  var gmap = GoogleMapAdapterView()
    var shouldHandleTap: Bool = true
    
    deinit {
        
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return shouldHandleTap
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker)
    {
       // gmap.reverseGeocoding(marker: marker)
      //  GoogleMapAdapterView.reverseGeocoding(marker: marker)
      
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

struct GoogleMapView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapAdapterView()
    }
}


extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"

        return dateFormatter.string(from: Date())

    }
}
