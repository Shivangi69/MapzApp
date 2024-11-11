//
//  GUpdatepartyDetails.swift
//  MapzApp
//
//  Created by Admin on 12/01/23.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import CoreLocation
import GoogleMaps
import GooglePlaces
import SimpleToast

struct GUpdatepartyDetails: View {
    @State private var showCameraPopUp = false
    @State private var showVideoPopUp = false
    @State private var showrecdPopUp = false
    @State private var showCamerascreenPopUp = false
    @State private var showVideoscreenPopUp = false
    @State private var showrecdscreenPopUp = false
    @State private var showdocPopUp = false
    @State private var Note : String?
    @State private var DairyName = String()
    @State private var Datestr = String()
    @State private var Addressstr = String()
    @State  var DairyDes  = String()
    @State private var textStyle = UIFont.TextStyle.body
    var arrImage = ["1", "2", "3", "4"]
    @ObservedObject var obs = GGpartyinfoObserver()
    @Environment(\.presentationMode) var presentationMode
    var myId = UserDefaults.standard.string(forKey: "id") ?? ""
    @State var columns: CGFloat = 3.0
    @State var vSpacing: CGFloat = 0.0
    @State var hSpacing: CGFloat = 0.0
    @State var vPadding: CGFloat = 0.0
    @State var hPadding: CGFloat = 0.0
    @State  var FileId = String()
    @State var showDairy: Bool = false
    @State var showupdateview = false
    @State var showshareview = false

    @State var showImagePicker: Bool = false
    @State var showvideoPicker: Bool = false
    @State var showmp3Picker: Bool = false
    @State var showfriendlist: Bool = false
    @State var heightplus : CGFloat = 35
    @State var shownextr: Bool = false
    @State  var isPermission  = String()
    @State  var isGroupcreator  = String()

  //  @State private var service = Coordinator()

    private let toastOptions = SimpleToastOptions(
        alignment: .bottom, hideAfter: 5, showBackdrop: false
        
    )
    @State var  eventNOE =  UserDefaults.standard.string(forKey: "eventNOE")
//       @State var image: Image? = nil
    let minHeight: CGFloat = 60
    @State private var height: CGFloat?
      
    var body: some View {
        ZStack{
            VStack(spacing: 0.0) {
                Spacer()
                      .frame(height :heightplus)
             HStack(spacing: 20.0) {
                
                 Button(action: {
                    
                    if (eventNOE == "New"){
                        
                        showupdateview = true
                    }else{
                        presentationMode.wrappedValue.dismiss()
                       
                    }
                 }) {
                   
                     Image("back")
                         .resizable()
                         .frame(width: 24.0, height: 24.0)

                 }
                 .fullScreenCover(isPresented: $showupdateview, content: MainView.init)
                 
               Spacer()
             }.frame(height: 32.0)
             .padding(.horizontal, 10.0)
                if (obs.showview){
             //   ScrollView{
                    
                    
//                VStack{
//                    GoogleMapAdapterView1()
//
//
//                }
//                .frame(height: 300.0)
                    
                    ForEach(obs.eventlist, id: \.self) { person in

                        VStack(spacing: 0.0){


                        HStack(alignment: .center, spacing: 10.0){

                            VStack{
                        AsyncImage(
                            url: NSURL(string: UserDefaults.standard.string(forKey: "GprofilePictureURL")!)! as URL ,
                                           placeholder: { Image("icons8-male-user-72")

                                            .resizable()
                                            .foregroundColor(colorGrey1)
                                            .aspectRatio(contentMode: .fill)
                                           },
                                                       image: { Image(uiImage: $0).resizable()

                                        }
                                       )

                        .frame(width: 60, height: 60)
                         .cornerRadius(30)
                         .aspectRatio(contentMode: .fit)


                            }
                            VStack(alignment: .leading, spacing: 5.0){
                                HStack(alignment: .center, spacing: 5.0){
                                    Text(UserDefaults.standard.string(forKey: "Gname") ?? "")
                                        .font(.custom("Inter-Bold", size: 15))
                                
                                    Spacer()
//                                    Image("share")
//                                        .resizable()
//                                        .frame(width: 20.0, height: 20.0)
//                                        .foregroundColor(.blue)
//                                        .onTapGesture(){
//                                            showshareview.toggle()
//                                        }
                                }
//                                .fullScreenCover(isPresented: $showshareview, content: {
//                                    ShareEvent()
//                                })
                                
                                HStack(alignment: .top, spacing: 5.0){//mappin
                                    Image("loctio")
                                        .resizable()
                                        .frame(width: 15, height: 32.0)
                                    VStack(alignment: .leading, spacing: 0.0){
                                       
                                        
                                        HStack{
                                           // Spacer()
                                            Text(person.date)
                                                    .font(.custom("Inter-Regular", size: 13))
                                                    .foregroundColor(Color.black)
                                            Text(" ")
                                                .font(.custom("Inter-Regular", size: 13))
                                            .foregroundColor(Color.black)
                                            
                                            Text(person.diaryName)
                                                    .font(.custom("Inter-Regular", size: 15))
                                                    .foregroundColor(Color.black)
                                        }
                                       
                                    Text(person.Addrs)
                                        .font(.custom("Inter-Regular", size: 14))
                                    .foregroundColor(Color.black)

                                }
                                    Spacer()
                                   // if person.userID == myId{
                                        Image("Artboard 37")
                                            .resizable()
                                            .frame(width: 20.0, height: 20.0)
                                            .foregroundColor(.blue)
                                            .onTapGesture(){
                                                showDairy.toggle()
                                            }
                                   // }
                                }

                            }
                            Spacer()

                        }
                            Spacer()
                                .frame(height: 7.0)
                            
                            HStack(spacing: 20.0) {


                            }

                            .frame(width :UIScreen.main.bounds.width-20 , height: 1.0)
                            .background(Color.black)

                            HStack(spacing: 0.0){
                           // Spacer()
                           HStack(alignment: .center){
                               Text("Diary")
                                   .font(.custom("Inter-Regular", size: 14))
                                Text(String(UserDefaults.standard.integer(forKey: "GtotalEvent")))
                                    .font(.custom("Inter-Bold", size: 14))
                                   // .foregroundColor(Color("yellowColor"))
                                   // .foregroundColor(Color.white)
                            }
                           //.padding(.horizontal, 15.0)

                           .frame(width : UIScreen.main.bounds.width/2-10,height: 30)
                           .onTapGesture{

                              // showcollc = false
                           }
                                
                                HStack(alignment: .center){

                                }

                                .frame(width : 2,height: 20)
                                .background(Color.black)

                                HStack(alignment: .center){
                                    Text("Friends")
                                        .font(.custom("Inter-Regular", size: 14))

                                    Text(String(UserDefaults.standard.integer(forKey: "GtotalFriend")))
                                         .font(.custom("Inter-Bold", size: 14))
                                        // .foregroundColor(Color("yellowColor"))


                                        // .foregroundColor(Color.white)
                                 }
                                .onTapGesture {
                                    showfriendlist.toggle()
                                } 
                                .fullScreenCover(isPresented: $showfriendlist, content: {
                                    FriendsListSearching()
                                })
                                .frame(width : UIScreen.main.bounds.width/2 - 10,height: 30)

                            }
                        }
                        .padding(.horizontal, 10.0)
                        .frame(width: UIScreen.main.bounds.width , height: 120)
                        .onAppear(){
                            DairyName = person.diaryName
                            DairyDes = person.diaryDescription
                            Datestr = person.date
                            Addressstr = person.Addrs
                            
                        }
                        GeometryReader { geometry in
                          ZStack {

                            VStack {

                                self.gridViewall(geometry)
                                    .onTapGesture {
                                        shownextr = true
                                    }
                                    .fullScreenCover(isPresented: $shownextr, content: {
                                        //ImageViewer(imgstr : person.file)
                                        GeventDetail(filelist : obs.filelistall , addrs : person.Addrs)
                                    })
                            }
//                                .padding(.horizontal, 10.0)


                          }

                        }
                        
                         VStack(spacing: 20.0){
                 
                             Spacer()
                             if(person.userId == myId)
   
                             {
                                 HStack(spacing : 10){
                                     Spacer()
                                     HStack{
                                        // SVGImage(name: "icons8-camera-96")
                                         
                                             Image("icons8-camera-96")
                                             .resizable()
                                             .frame(width: 36, height: 36)
                                           
                                             .aspectRatio(contentMode: .fit)
                                             .onTapGesture {
                                                 obs.showvideopopup1 = false
                                                 showVideoPopUp = false
                                                 showrecdPopUp = false
                                                 showdocPopUp = false
                                                 showCameraPopUp = true
                                             }
                                         
                                     } .frame(width: 60, height: 60)
                                     .overlay(
                                         RoundedRectangle(cornerRadius: 5)
                                             .strokeBorder(Color("gryColor"), lineWidth: 1, antialiased: true)
                                     )
                                     HStack{
                                                     Image("icons8-circled-play-100")
                                                         
                                                        .resizable()
                                                        .frame(width: 36, height: 36)
                                                        .aspectRatio(contentMode: .fit)
                                                         .onTapGesture {
                                                           
                                                             showCameraPopUp = false
                                                         //       showVideoPopUp = false
                                                                showrecdPopUp = false
                                                                showdocPopUp = false
                                                             self.showVideoPopUp = true
                                                           
                                                             obs.showvideopopup1 = true
                                                         
                                                         }
                                     }.frame(width: 60, height: 60)
                                     .overlay(
                                         RoundedRectangle(cornerRadius: 5)
                                             .strokeBorder(Color("gryColor"), lineWidth: 1, antialiased: true))
                                         HStack{
                                                     Image("icons8-microphone-100")
                                                        .resizable()
                                                        .frame(width: 36, height: 36)
                                                        .aspectRatio(contentMode: .fit)
                                                        .onTapGesture {
                                                            obs.showvideopopup1 = false

                                                            showCameraPopUp = false
                                                               showVideoPopUp = false
                                                         //      showrecdPopUp = false
                                                               showdocPopUp = false
                                                        showrecdPopUp = true
                                                            }
                                         } .frame(width: 60, height: 60)
                                         .overlay(
                                             RoundedRectangle(cornerRadius: 5)
                                                 .strokeBorder(Color("gryColor"), lineWidth: 1, antialiased: true)
                                         )
                                             HStack{
                                                 Image("icons8-menu-50")
                                                           .resizable()
                                                           .frame(width: 36, height: 36)
                                                           .aspectRatio(contentMode: .fit)
                                                            .onTapGesture {
                                                                obs.showvideopopup1 = false

                                                                showCameraPopUp = false
                                                                   showVideoPopUp = false
                                                                   showrecdPopUp = false
                                                            showdocPopUp = true
                                                                }
                                                          
                                             } .frame(width: 60, height: 60)
                                             .overlay(
                                                 RoundedRectangle(cornerRadius: 5)
                                                     .strokeBorder(Color("gryColor"), lineWidth: 1, antialiased: true)
                                                     
                                                    )
                                                  Spacer()
                                                     
                                                 }.frame(width: UIScreen.main.bounds.width , height: 80, alignment: .center)
                                              
                            }
                         }
                         .padding(.horizontal, 10.0)
                         .padding([.top], 20.0)

                    }
                  
            }
            }.edgesIgnoringSafeArea(.all)
      
            // Spacer(minLength: 30)
                
            
            if $showCameraPopUp.wrappedValue {
                ZStack {
                    Color.white
                    VStack(alignment: .center, spacing: 10.0) {
                        Spacer().frame(height : 10)
                    Button(action: {
                        self.showCameraPopUp = false
                       // self.obs.fetch()

                    }) {
                       Image("cross")
                            .resizable()
                            
                            .aspectRatio(contentMode: .fit)
                       
                        
                    }
                    .frame(width: 32.0, height: 32.0)
                    .offset(x: UIScreen.main.bounds.width/2 - 50)
                    
                  
                        HStack{
                            Text("Add New Photos")
                                .font(.custom("Inter-Bold", size: 27))
                            .foregroundColor(Color.black)
                             Spacer()
                        }.padding(.horizontal)
                      //  Spacer()
                        HStack(spacing: 20){
                            VStack{
                                Button(action: {
                                    UserDefaults.standard.set("Edit", forKey: "eventNOE")
                                    UserDefaults.standard.set("camera", forKey: "fromwhere")
                                    showCamerascreenPopUp = true
                                    
                                }){
                                    Image("camera_b")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .scaledToFill()
                                }
                                .frame(width: 70, height: 70)
                                //                            .background((Color("themecolor 1")))
                                //                            .foregroundColor(.white)
                                //                            .cornerRadius(10)
                                
                                Text("Camera")
                                    .font(.custom("Inter-SemiBold", size: 18))
                                    .foregroundColor(Color.black)
                                    .scaledToFill()
                            }
                            .fullScreenCover(isPresented: $showCamerascreenPopUp, content: CreateEventView.init)
                            
                            VStack{
                            Button(action: {
                                UserDefaults.standard.set("pic", forKey: "pov")
                                
                                self.showImagePicker = true
                                
                            }){
                                Image("Gallery_b")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                            }
                            .frame(width: 70, height: 70)
                            
                            
                            
//                            Button(action: {//
//
//
//                            }, label: {
//                                Text("Choose from gallery")
//                                    .font(.custom("Inter-Bold", size: 18))
//                            })
//                            .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                            .background((Color("themecolor 1")))
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
                                Text("Gallery")
                                    .font(.custom("Inter-SemiBold", size: 18))
                                    .foregroundColor(Color.black)
                            }
                            .sheet(isPresented: $showImagePicker) {
                                
                                ImagePicker(sourceType: .photoLibrary) { image in
                                    // self.image = Image(uiImage: image)
                                    self.showCameraPopUp = false
                                    
                                }
                            }
                            
                        }
                        Spacer()
                    }.padding()
                   

                }
                .frame(width: UIScreen.main.bounds.width-60, height: 200)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
            
            
            
            if $obs.showvideopopup1.wrappedValue {
                ZStack {
                    Color.white
                    VStack(alignment: .center, spacing: 10.0) {
                        Spacer().frame(height : 10)
                    Button(action: {
                        obs.showvideopopup1 = false
                       // self.obs.fetch()

                    }) {
                       Image("cross")
                            .resizable()
                            
                            .aspectRatio(contentMode: .fit)
                       
                        
                    }
                    .frame(width: 32.0, height: 32.0)
                    .offset(x: UIScreen.main.bounds.width/2 - 50)
                    
                  
                        HStack{
                            Text("Add New Videos")
                                .font(.custom("Inter-Bold", size: 27))
                            .foregroundColor(Color.black)
                             Spacer()
                        }.padding(.horizontal)
                      //  Spacer()
                        HStack(spacing: 20){
                            VStack{
                                Button(action: {
                                    UserDefaults.standard.set("Edit", forKey: "eventNOE")
                                    UserDefaults.standard.set("video", forKey: "fromwhere")

                                    self.showVideoscreenPopUp = true

                                   // self.showVideoPopUp = false
                                }){
                                    Image("camera_b")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .scaledToFill()
                                }
                                .frame(width: 70, height: 70)
                                //                            .background((Color("themecolor 1")))
                                //                            .foregroundColor(.white)
                                //                            .cornerRadius(10)
                                
                                Text("Camera")
                                    .font(.custom("Inter-SemiBold", size: 18))
                                    .foregroundColor(Color.black)
                                    .scaledToFill()
                            }
                            .fullScreenCover(isPresented: $showVideoscreenPopUp, content: CreateEventView.init)

                            VStack{
                            Button(action: {
                                UserDefaults.standard.set("vid", forKey: "pov")
                                 self.showvideoPicker = true
                                

                            }){
                                Image("Gallery_b")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                            }
                            .frame(width: 70, height: 70)
                            
                            
                            
//                            Button(action: {//
//
//
//                            }, label: {
//                                Text("Choose from gallery")
//                                    .font(.custom("Inter-Bold", size: 18))
//                            })
//                            .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                            .background((Color("themecolor 1")))
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
                                Text("Gallery")
                                    .font(.custom("Inter-SemiBold", size: 18))
                                    .foregroundColor(Color.black)
                            }
                            .sheet(isPresented: $showvideoPicker) {
                            ImagePicker(sourceType: .photoLibrary) { video in
                                    self.showvideoPicker = false
                                }
                                        
                            }
                            
                        }
                        Spacer()
                    }.padding()
                   

                }
                .frame(width: UIScreen.main.bounds.width-60, height: 200)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
            
            
            if $showrecdPopUp.wrappedValue {
                ZStack {
                    Color.white
                    VStack(alignment: .center, spacing: 10.0) {
                        Spacer().frame(height : 10)
                    Button(action: {
                        showrecdPopUp = false
                       /// self.obs.fetch()
                    }) {
                       Image("cross")
                            .resizable()
                            
                            .aspectRatio(contentMode: .fit)
                       
                        
                    }
                    .frame(width: 32.0, height: 32.0)
                    .offset(x: UIScreen.main.bounds.width/2 - 50)
                    
                  
                        HStack{
                            Text("Add New Audio")
                                .font(.custom("Inter-Bold", size: 27))
                            .foregroundColor(Color.black)
                             Spacer()
                        }.padding(.horizontal)
                      //  Spacer()
                        HStack(spacing: 20){
                            VStack{
                                Button(action: {
                                    UserDefaults.standard.set("Edit", forKey: "eventNOE")
                                    UserDefaults.standard.set("audio", forKey: "fromwhere")
                                    self.showrecdscreenPopUp = true
                                    //self.showrecdPopUp = false
                                }){
                                    Image("camera_b")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .scaledToFill()
                                }
                                .frame(width: 70, height: 70)
                                //                            .background((Color("themecolor 1")))
                                //                            .foregroundColor(.white)
                                //                            .cornerRadius(10)
                                
                                Text("Mobile")
                                    .font(.custom("Inter-SemiBold", size: 18))
                                    .foregroundColor(Color.black)
                                    .scaledToFill()
                            }
                            .fullScreenCover(isPresented: $showrecdscreenPopUp, content: CreateEventView.init)

                            VStack{
                            Button(action: {
                                showmp3Picker = true
                                 ///
                            }){
                                Image("Gallery_b")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                            }
                            .frame(width: 70, height: 70)
                            
                            
                            
//                            Button(action: {//
//
//
//                            }, label: {
//                                Text("Choose from gallery")
//                                    .font(.custom("Inter-Bold", size: 18))
//                            })
//                            .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                            .background((Color("themecolor 1")))
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
                                Text("Device")
                                    .font(.custom("Inter-SemiBold", size: 18))
                                    .foregroundColor(Color.black)
                            }
                            .sheet(isPresented: $showmp3Picker) {
                                MusicPicker()
                                        }
                        }
                        Spacer()
                    }.padding()
                   

                }
                .frame(width: UIScreen.main.bounds.width-60, height: 200)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
            
            if $showdocPopUp.wrappedValue {
                ZStack {
                   
                    Color.white
                    VStack(alignment: .center, spacing: 20.0) {
                         
                        HStack{

                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                               
                            }) {
                                Image("icons8-back-24")
                                    .resizable()
                                    .frame(width: 24.0, height: 24.0)
                                //    .padding(.top,12.0)
                                
                                //.cornerRadius(24)
                            }
                            
                            
                            Spacer()
                            Text("Add Note")
                                .font(.custom("Inter-Bold", size: 20))
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            Button(action: {
                               
                            }) {
                                Image("")
                                    .resizable()
                                    .frame(width: 24.0, height: 24.0)
                                //    .padding(.top,12.0)
                                
                                //.cornerRadius(24)
                            }
                            
                            
                        }
                        .padding(.horizontal, 10.0)
//                        .frame(height: 50)
                        .frame(width: UIScreen.main.bounds.width , height: 60) .background((Color("themecolor 1")))
                        
                        
                        
//                        HStack{
//                            Button(action: {
//                                showdocPopUp = false
//                            }) {
//                                Image("icons8-back-24")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//
//
//                            }
//                            .frame(width: 32.0, height: 32.0)
//
//                            Spacer()
//                            Text("Add Note")
//                                .font(.custom("Inter-Bold", size: 20))
//                                .foregroundColor(Color.white)
//
//
//                            Spacer()
//
//                            Image("c")
//                                .frame(width: 32.0, height: 32.0)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//
//                        }.frame(width: UIScreen.main.bounds.width , height: 60) .background((Color("themecolor 1")))

                        
                        
                        ZStack(alignment: .topLeading) {
                                        TextEditor(text: Binding($Note, replacingNilWith: ""))
                                            .frame(width: UIScreen.main.bounds.width-30, height: 180, alignment: .leading)

                                            .cornerRadius(6.0)
                                            .foregroundColor(Color(.black))
                                            .border(Color.gray, width: 0.5)
                                            .multilineTextAlignment(.leading)
                                        Text(Note ?? "Enter Note")
                                                                 // following line is a hack to create an inset similar to the TextEditor inset...
                                            .padding([.top, .leading], 10.0)
                                            .foregroundColor(Color(.lightGray))
                                            .opacity(Note == nil ? 1 : 0)
                                    }
                                    .font(.body)
                        
                        Button(action: {
                           
                            self.AddNote()
                        }, label: {
                            Text("Add")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-30, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                       
                        
                        Spacer()
                    }.padding()

                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                .cornerRadius(20)
//                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
           
            if ($showDairy.wrappedValue){
                ZStack {
                    Color.white
                    VStack(alignment: .center, spacing: 10.0) {
                       
//                        Spacer()
//                              .frame(height :heightplus)
                        HStack{
                            
                            Spacer()
                            
                            Button(action: {
                                showDairy = false
                            }) {
                                Image("close")
                                    .resizable()
                                    .frame(width: 24.0, height: 24.0)
                                    .aspectRatio(contentMode: .fit)
                                
                                
                            }
                            .frame(width: 24.0, height: 24.0)

                        }  .frame(height: 56.0)
                            .padding(.all , 8)
                      //  .background((Color("themecolor")))
                        HStack{
                            Text("Edit entry")
                                .font(.custom("Inter-Regular", size: 13))
                                .foregroundColor(Color.black)
                        
                            Spacer()
                        } .frame(width: UIScreen.main.bounds.width - 20 )
                        
                        TextField("Enter Dairy Name", text: $DairyName)
                            .padding(.all)
                            .font(.custom("Inter-Regular", size: 17))
                            .frame(width: UIScreen.main.bounds.width-30, height: 50)
                            .border(Color.gray, width: 0.5)
                        HStack{
                            Text(Datestr)
                                .font(.custom("Inter-Regular", size: 13))
                                .foregroundColor(Color.black)
                            
                        Spacer()
                        } .frame(width: UIScreen.main.bounds.width - 20 )
                        HStack{
                        Text(Addressstr)
                                .font(.custom("Inter-Regular", size: 13))
                                .foregroundColor(Color.black)
                            Spacer()
                            }  .frame(width: UIScreen.main.bounds.width - 20 )
                        
//                        ZStack(alignment: .topLeading) {
//                                        TextEditor(text: Binding($DairyDes, replacingNilWith: ""))
//                                            .frame(width: UIScreen.main.bounds.width-30, height: 80, alignment: .leading)
//
//                                            .cornerRadius(6.0)
//                                            .foregroundColor(Color(.black))
//                                            .border(Color.gray, width: 0.5)
//                                            .multilineTextAlignment(.leading)
//                                            .toolbar {
//                                                            ToolbarItemGroup(placement: .keyboard) {
//                                                                Button("Done!") {
//                                                                    print("Clicked")
//                                                                }
//                                                            }
//                                                        }
//                                        Text(DairyDes ?? "Enter  Dairy Description")
//                                                                 // following line is a hack to create an inset similar to the TextEditor inset...
//                                            .padding([.top, .leading], 10.0)
//                                            .foregroundColor(Color(.lightGray))
//                                            .opacity(DairyDes == nil ? 1 : 0)
//                                    }
                                   // .font(.body)
                        HStack {
                            WrappedTextView(text: $DairyDes, textDidChange: self.textDidChange)
                                .frame(height: height ?? minHeight)
                                .padding(.horizontal, 8.0)
                                .font(.custom("Inter-Regular", size: 17))
                            
                                .foregroundColor(self.DairyDes == "Enter Dairy Description" ? .systemGray : .black)
                            
                                .onAppear {
                                    // remove the placeholder text when keyboard appears
                                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                                        withAnimation {
                                            if self.DairyDes == "Enter Dairy Description" {
                                                self.DairyDes = ""
                                            }
                                        }
                                    }
                                    
                                    // put back the placeholder text if the user dismisses the keyboard without adding any text
                                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                                        withAnimation {
                                            if self.DairyDes == "" {
                                                self.DairyDes = "Enter Dairy Description"
                                        }
                                    }
                                }
                            }
                        }
                        
                        .frame(width: UIScreen.main.bounds.width-30)
                        .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 1))
                       
                        
                        GeometryReader { geometry in
                          ZStack {

                            VStack {

                                self.gridViewall(geometry)
                                    .onTapGesture {
                                        shownextr = true
                                    }
                                    .fullScreenCover(isPresented: $shownextr, content: {
                                        //ImageViewer(imgstr : person.file)
                                        EventDetail(filelist : obs.filelistall , addrs : "")
                                    })
                            }
//                                .padding(.horizontal, 10.0)


                          }

                        }
                        
                        
                        Spacer()
                        

                        Button(action: {
                             //
                            
                            self.AddDairy()
                        }, label: {
                            Text("Update Diary")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width - 20 , height: 50)
                        .background((Color("themecolor-1")))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                       
                    }.padding()

                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
//                .cornerRadius(20)
//                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
        }.onAppear(){
            
            if (eventNOE == "New"){
                showDairy = true
            }
            if UIDevice.current.hasNotch {
                heightplus = 35
            } else {
                //... don't have to consider notch
                heightplus = 20
            }
            obs.fetch()
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "refreshGroupProfile"), object: nil, queue: OperationQueue.main) {
                            pNotification in
                obs.fetch()
            }
        }
//        .simpleToast(isPresented: $Coordinator.shouldShowtoastView, options: toastOptions) {
//               HStack {
//
//                   Text("Upload Successfully")
//               }
//               .padding()
//               .background(Color.red.opacity(0.8))
//               .foregroundColor(Color.white)
//               .cornerRadius(10)
//           }
        
    }
   
    private func textDidChange(_ textView: UITextView) {
                if textView.contentSize.height >= 150
                {
                    textView.contentSize.height = 150
                }
            self.height = max(textView.contentSize.height, minHeight)

        }
    func AddDairy(){
        UIApplication.dismissKeyboard()
        
        let evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""
        
        var checData: Parameters {
            [
                "id": evntId,
                "latitude": UserDefaults.standard.double(forKey: "latE"),
                "longitude": UserDefaults.standard.double(forKey: "longE"),
                "diaryName": DairyName,
                "diaryDescription": DairyDes as Any,
                "Address": UserDefaults.standard.string(forKey: "AddressE") ?? ""
                
            ]
            
        }
        
        print(checData)
        AccountAPI.signin(servciename: "EventDiary/UpdateEventDiaryWithFiles", checData) { res in
            switch res {
            case .success:
                print("resulllll",res)
                self.showDairy = false
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroupProfile"), object: self)
                
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    

    func AddNote(){
        UIApplication.dismissKeyboard()

        let evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""

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
       
        
        
        var checData: Parameters {
            [
                "dbEventDiaryId": evntId,
                "noteText": Note as Any,
                "Groupid1" : groupid,
                "IsGroup1" : isgroupid
  
            ]
        }
print(checData)
        AccountAPI.signin(servciename: "EventDiaryNote/CreateEventDiaryNote", checData) { res in
        switch res {
        case .success:
            print("resulllll",res)
            self.showdocPopUp = false
           // obs.fetch()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroupProfile"), object: self)

        case let .failure(error):
          print(error)
        }
      }
       }
    
    private func gridView(_ geometry: GeometryProxy) -> some View {


        QGrid(obs.piclist,
            columns: Int(self.columns),
            columnsInLandscape: Int(self.columns),

            vSpacing: min(self.vSpacing, 5),

            hSpacing: max(min(self.hSpacing, 5), 0.0),

            vPadding: min(self.vPadding, 0),

            hPadding: max(min(self.hPadding, 5), 0.0),
            isScrollable: false
        )
        {
            GridCell(person: $0)
      }
    }
    private func gridViewall(_ geometry: GeometryProxy) -> some View {


        QGrid(obs.filelistall,
            columns: Int(self.columns),
            columnsInLandscape: Int(self.columns),

            vSpacing: min(self.vSpacing, 0),

            hSpacing: max(min(self.hSpacing, 0), 0.0),

            vPadding: min(self.vPadding, 0),

            hPadding: max(min(self.hPadding, 0), 0.0),
            isScrollable: true
        )
        {
            GridCellview(person: $0, showCross: false)
      }
    }
    private func gridView1(_ geometry: GeometryProxy) -> some View {


        QGrid(obs.piclist,
            columns: Int(self.columns),
            columnsInLandscape: Int(self.columns),

            vSpacing: min(self.vSpacing, 5),

            hSpacing: max(min(self.hSpacing, 5), 0.0),

            vPadding: min(self.vPadding, 0),

            hPadding: max(min(self.hPadding, 5), 0.0),
            isScrollable: false
        )
        {
          
            GridCell1(person: $0)
      }
    }
    
    private func gridView2(_ geometry: GeometryProxy) -> some View {


        QGrid(obs.mp3list,
            columns: Int(self.columns),
            columnsInLandscape: Int(self.columns),

            vSpacing: min(self.vSpacing, 10),

            hSpacing: max(min(self.hSpacing, 10), 0.0),

            vPadding: min(self.vPadding, 0),

            hPadding: max(min(self.hPadding, 10), 0.0),
            isScrollable: false
        )
        {
            GridCell2(person: $0)
      }
    }
    
    
}

struct GUpdatepartyDetails_Previews: PreviewProvider {
    static var previews: some View {
        GUpdatepartyDetails()
    }
}
class GGpartyinfoObserver: ObservableObject {
    
    @Published   var eventlist = [eventmodalclassss]()
    @Published   var filelist = [FilesModal]()
    @Published   var mp3list = [FilesModal]()
    @Published   var piclist = [FilesModal]()
    @Published   var vidlist = [FilesModal]()
    @Published   var imglist = [String]()
    @Published   var filelistall = [AllFilesModal]()
    
    @Published   var notlist = [NotesModal]()
    @Published   var showview = false
    @Published   var showvideopopup = false
    @Published   var showvideopopup1 = false
    
    @Published   var showlist = false
    @Published   var showpiclist = false
    @Published   var showAlllist = false
    
    @Published   var showaudiolist = false
    @Published   var showvidlist = false
    // var evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""
    var urlstr = "EventDiary/Get?id=" + UserDefaults.standard.string(forKey: "eventID")!
    func  fetch() {
        self.showview = false
        
        self.showlist = false
        self.showpiclist = false
        self.showaudiolist = false
        self.showvidlist = false
        AccountAPI.getsignin(servciename:urlstr , nil) { res in
            switch res {
            case .success:
                print("resulllll",res)
                self.eventlist = []
                if let json = res.value{
                    
                    print("Josn",json)
                    let userdic = json["data"]
                    let filestinfor = userdic["files"]
                    let notestinfor = userdic["notes"]
                    
                    print("userdic",userdic as Any)
                    print("userdic",userdic["mobile"])
                    //
                    self.filelist = []
                    self.notlist = []
                    let fullName : String = userdic["userDOB"].stringValue
                    let fullNameArr : [String] = fullName.components(separatedBy: "T")
                    let datestr: String = fullNameArr[0]
                    
                    
                    UserDefaults.standard.set(userdic["userEmail"].string, forKey: "Gemail")
                    UserDefaults.standard.set((userdic["userName"].string ?? "") , forKey: "Gname")
                    UserDefaults.standard.set(datestr, forKey: "fDateOfBirth")
                    UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "GprofilePictureURL")
                    //
                    UserDefaults.standard.set(userdic["diary_Count"].int, forKey: "GtotalEvent")
                    // UserDefaults.standard.set(fullName, forKey: "fDateOfBirth")
                    
                    // UserDefaults.standard.set(userdic["tagLine"].string, forKey: "ftagLine")
                    UserDefaults.standard.set(userdic["friend_Count"].int, forKey: "GtotalFriend")
                    UserDefaults.standard.set(userdic["diary_Count"].int, forKey: "GtotalEvent")
                    
                    for i in filestinfor {
                        
                        let  acc  = FilesModal(i.1["fileId"].intValue,i.1["fileId"].stringValue, i.1["fileType"].stringValue, i.1["file"].stringValue, i.1["thumbnail"].stringValue)
                        self.filelist.append(acc)
                        let aca = AllFilesModal(i.1["fileId"].intValue,i.1["fileId"].stringValue, i.1["fileType"].stringValue, i.1["file"].stringValue, i.1["thumbnail"].stringValue,"")
                        self.filelistall.append(aca)
                        self.showAlllist = true
                        
                    }
                    self.mp3list =   self.filelist.filter { $0.fileType == "mp3" }
                    self.vidlist =   self.filelist.filter { $0.fileType == "mp4" || $0.fileType == "3gp"}
                    self.piclist =   self.filelist.filter { $0.fileType == "jpg" || $0.fileType == "jpeg" }
                    if self.piclist.count > 0 {
                        self.showpiclist = true
                    }
                    if self.vidlist.count > 0 {
                        self.showvidlist = true
                    }
                    if self.mp3list.count > 0 {
                        self.showaudiolist = true
                    }
                    
                    for i in notestinfor {
                        
                        let  acc  = NotesModal(i.1["noteId"].stringValue, i.1["noteText"].stringValue)
                        
                        let aca = AllFilesModal(i.1["noteId"].intValue,i.1["noteId"].stringValue, "Notes", "", i.1["thumbnail"].stringValue,i.1["noteText"].stringValue)
                        self.filelistall.append(aca)
                        self.notlist.append(acc)
                        self.showAlllist = true
                    }
                    if self.notlist.count > 0 {
                        self.showlist = true
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
                    
                    
                    let lat: Double = Double("\(userdic["latitude"].stringValue)")!
                    //21.228124
                    let lon: Double = Double("\(userdic["longitude"].stringValue)")!
                    
                    UserDefaults.standard.set(lat, forKey: "latE")
                    UserDefaults.standard.set(lon, forKey: "longE")
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                    let date = dateFormatter.date(from: userdic["date"].stringValue)
                    dateFormatter.dateFormat = "EEEE,d MMM  yyyy"
                    let dtstr  = dateFormatter.string(from: date!)
                    
                    let geocoder = GMSGeocoder()
                    let coordinate = CLLocationCoordinate2DMake(lat,lon)
                    
                    var currentAddress = String()
                    
                    geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
                        if let address = response?.firstResult() {
                            let lines1 = address.lines! as [String]
                            
                            print("Response is = \(address)")
                            print("Response line is = \(lines1)")
                            
                            currentAddress = lines1.joined(separator: "\n")
                            let str = userdic["address"].stringValue
                            if currentAddress == ""{
                                currentAddress = str
                            }
                            let scc = eventmodalclassss(0,userdic["eventId"].stringValue, userdic["userId"].stringValue, userdic["longitude"].stringValue, userdic["latitude"].stringValue, userdic["diaryName"].stringValue, userdic["diaryDescription"].stringValue, dtstr, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.vidlist.count),self.imglist as [String],currentAddress, "",userdic["diary_Count"].intValue,userdic["friend_Count"].intValue)
                            self.eventlist.append(scc)
                            self.showview = true
                        }
                        else{
                            
                            let scc = eventmodalclassss(0,userdic["eventId"].stringValue, userdic["userId"].stringValue, userdic["longitude"].stringValue, userdic["latitude"].stringValue, userdic["diaryName"].stringValue, userdic["diaryDescription"].stringValue, dtstr, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.vidlist.count),self.imglist as [String],userdic["address"].stringValue, "",userdic["diary_Count"].intValue,userdic["friend_Count"].intValue)
                            self.eventlist.append(scc)
                            self.showview = true
                        }
                        
                    }
                    
                    
                    
                    
                }
                
                
            case let .failure(error):
                print(error)
            }
        }
    }
}
