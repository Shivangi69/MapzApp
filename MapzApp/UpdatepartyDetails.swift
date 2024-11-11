//
//  Update partyDetails.swift
//  MapzApp
//
//  Created by Misha Infotech on 27/08/2021.
//


import SwiftUI
import Alamofire
import SwiftyJSON
import CoreLocation
import GoogleMaps
import GooglePlaces
import SimpleToast


struct UpdatepartyDetails: View {
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
    @ObservedObject var obs = partyinfoObserver()
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
    //@State var showDairy: Bool = false

  //  @State private var service = Coordinator()
    @State  var fromgroup = String()

    private let toastOptions = SimpleToastOptions(
        alignment: .bottom, hideAfter: 5, showBackdrop: false
        
    )
    @State var  eventNOE =  UserDefaults.standard.string(forKey: "eventNOE")
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
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroupD"), object: self)
                            
                        }
                    }) {
                        
                        Image("back")
                            .resizable()
                            .frame(width: 24.0, height: 24.0)
                        
                    }
                    .fullScreenCover(isPresented: $showupdateview, content: MainView.init)
                    
                    Spacer()
                }
                
                .frame(height: 32.0)
                if (obs.showview){
                    
                    ForEach(obs.eventlist, id: \.self) { person in
                        
                        VStack(spacing: 0.0){
                            
                            HStack(alignment: .center, spacing: 10.0){
                                
                                VStack{
                                    AsyncImage(
                                        url: NSURL(string: UserDefaults.standard.string(forKey: "profilePictureURL")!)! as URL ,
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
                                        Text(UserDefaults.standard.string(forKey: "name") ?? "")
                                            .font(.custom("Inter-Bold", size: 15))
                                        
                                    }
                                    
                                    
                                    
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
                                                    .multilineTextAlignment(.leading)
                                                
                                                Text(person.diaryName)
                                                    .font(.custom("Inter-Regular", size: 15))
                                                    .foregroundColor(Color.black)
                                                    .multilineTextAlignment(.leading)
                                                
                                                
                                            }
                                            
                                            Text(person.Addrs)
                                                .font(.custom("Inter-Regular", size: 14))
                                                .foregroundColor(Color.black)
                                            
                                        }
                                        Spacer()
                                        
                                        Image("Artboard 37")
                                            .resizable()
                                            .frame(width: 20.0, height: 20.0)
                                        //  .foregroundColor(.blue)
                                            .onTapGesture(){
                                                showDairy.toggle()
                                            }
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
                                    Text(String(UserDefaults.standard.integer(forKey: "totalEvent")))
                                        .font(.custom("Inter-Bold", size: 14))
                                    // .foregroundColor(Color("yellowColor"))
                                    // .foregroundColor(Color.white)
                                }
                                //.padding(.horizontal, 15.0)
                                
                                .frame(width : UIScreen.main.bounds.width/3-10,height: 40)
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
                                    
                                    Text(String(UserDefaults.standard.integer(forKey: "totalFriend")))
                                        .font(.custom("Inter-Bold", size: 14))
                                    // .foregroundColor(Color("yellowColor"))
                                    // .foregroundColor(Color.white)
                                    
                                }.frame(width : UIScreen.main.bounds.width/3-10,height: 40)
                                
                                    .onTapGesture {
                                        showfriendlist.toggle()
                                    }
                                    .fullScreenCover(isPresented: $showfriendlist, content: {
                                        FriendsListSearching()
                                    })
                                
                                HStack(alignment: .center){
                                    
                                }
                                
                                .frame(width : 2,height: 20)
                                .background(Color.black)
                                
                                HStack(alignment: .center){
                                    Text("Share")
                                        .font(.custom("Inter-Bold", size: 14))
                                        .foregroundColor(Color.orange)
                                        .onTapGesture(){
                                            showshareview.toggle()
                                        }
                                    
                                }
                                
                                .fullScreenCover(isPresented: $showshareview, content: {
                                    ShareEvent()
                                })
                                //.padding(.horizontal, 15.0)
                                
                                
                                .frame(width : UIScreen.main.bounds.width/3 - 10,height: 40)
                            }
                            
                            
                            //            Spacer()
                        }
                        .padding(.horizontal, 10.0)
                        .frame(width: UIScreen.main.bounds.width, height: 120 )
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
                                            EventDetail(filelist : obs.filelistall , addrs : person.Addrs)
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
                                        
                                    }
                                    .frame(width: 60, height: 60)
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
                                    .background(Color.white)
                            }
                            
                        }
                        //                .padding(.horizontal, 10.0)
                        .padding([.bottom],70.0)
                        .frame(width: UIScreen.main.bounds.width , height: 30, alignment: .center)
                        
                        
                        
                    }
                    
                    //                    VStack{
                    //                    HStack{
                    //                        //Spacer()
                    //
                    //                        Text("Photos")
                    //                                .font(.custom("Inter-Bold", size: 25))
                    //                            .foregroundColor(Color("themecolor"))
                    //                        Spacer()
                    //
                    //
                    //                    }
                    //                    .padding(.all, 30.0)
                    //
                    //
                    //                        if (obs.showpiclist){
                    //                         ScrollView(.horizontal, showsIndicators: false) {
                    //                             HStack(spacing: 10.0){
                    //                                ForEach(obs.piclist){i in
                    //
                    //                            // ForEach(0..<Databoarding.count){_ in
                    //                                 //gr(productitem: i)
                    //                                    GridCell(person : i)
                    //
                    //                             }
                    //                             }
                    //                             .padding(.all, 5)
                    //                         }.frame(height: 280)
                    //
                    //
                    //
                    //                    GeometryReader { geometry in
                    //                      ZStack {
                    //
                    //                        VStack {
                    //
                    //                            self.gridView(geometry)
                    //
                    //                        }
                    //                        .padding(.horizontal, 10.0)
                    //
                    //
                    //                      }
                    //
                    //                    }
                    //                 //   .frame(height: 550.0)
                    //                        }
                    //                        else{
                    //                            HStack{
                    //                                //Spacer()
                    //
                    //                                Text("No Items Found")
                    //                                        .font(.custom("Inter-Bold", size: 20))
                    //
                    //                            }
                    //        //
                    //                        }
                    //
                    //                    }
                    
                    
                    
                    //                    HStack{
                    //                        //Spacer()
                    //
                    //                        Text("Videos")
                    //                                .font(.custom("Inter-Bold", size: 25))
                    //                            .foregroundColor(Color("themecolor"))
                    //                        Spacer()
                    //
                    //
                    //                    }
                    ////
                    //                    .padding(.all, 30.0)
                    //
                    //                    GeometryReader { geometry in
                    //                      ZStack {
                    //
                    //                        VStack {
                    //
                    //                            self.gridView1(geometry)
                    //
                    //                        }
                    //                        .padding(.horizontal, 10.0)
                    //
                    //
                    //                      }
                    //
                    //                      }                    .frame(height: 550.0)
                    //                    if (obs.showvidlist){
                    //                    ScrollView(.horizontal, showsIndicators: false) {
                    //                        HStack(spacing: 10.0){
                    //                           ForEach(obs.vidlist){i in
                    //
                    //                       // ForEach(0..<Databoarding.count){_ in
                    //                            //gr(productitem: i)
                    //
                    //                            GridCell1(person : i)
                    //
                    //                        }
                    //                        }
                    //                        .padding(.all, 5)
                    //                    }.frame(height: 280)
                    //                    }
                    //                    else{
                    //                        HStack{
                    //                            //Spacer()
                    //
                    //                            Text("No Items Found")
                    //                                    .font(.custom("Inter-Bold", size: 20))
                    //
                    //                        }
                    //    //
                    //                    }
                    
                    //                    HStack{
                    //                        //Spacer()
                    //
                    //                        Text("Voices")
                    //                                .font(.custom("Inter-Bold", size: 25))
                    //                            .foregroundColor(Color("themecolor"))
                    //                        Spacer()
                    //
                    //
                    //                    }
                    //
                    //  .padding(.all, 30.0)
                    //
                    //                    if (obs.showaudiolist){
                    //                    GeometryReader { geometry in
                    //                      ZStack {
                    //
                    //                        VStack {
                    //
                    //                            self.gridView2(geometry)
                    //
                    //                        }
                    //                        .padding(.horizontal, 10.0)
                    //
                    //
                    //                      }
                    //
                    //                      }
                    //                    .frame(height: CGFloat(obs.mp3list.count)/2 * 90)
                    //                    } else{
                    //                        HStack{
                    //                            //Spacer()
                    //
                    //                            Text("No Items Found")
                    //                                    .font(.custom("Inter-Bold", size: 20))
                    //
                    //                        }
                    //    //
                    //                    }
                    
                    //                    VStack{
                    //                    HStack{
                    //                        //Spacer()
                    //
                    //                        Text("Notes")
                    //                                .font(.custom("Inter-Bold", size: 25))
                    //                            .foregroundColor(Color("themecolor"))
                    //                        Spacer()
                    //
                    //
                    //                    }
                    //                    .padding(.all, 30.0)
                    //
                    //                        if (obs.showlist){
                    //              //   List{
                    //                        ForEach(obs.notlist, id: \.self) { person in
                    //                           // ForEach(0..<obs.notlist.count){_ in
                    //                        HStack(alignment: .center, spacing: 10.0){
                    //                            Image("icons8-sticky-notes-24")
                    //                                .resizable()
                    //
                    //                                .aspectRatio(contentMode: .fill)
                    //                                .frame(width: 60.0, height: 60.0)
                    //
                    //
                    //                            Text(person.noteText)
                    //                                    .font(.custom("Inter-Bold", size: 22))
                    //                                    .foregroundColor(Color("themecolor"))
                    //
                    //                            Spacer()
                    //                            Button(action: {
                    //
                    //                                var checData: Parameters {
                    //                                    [
                    //                                        "id": person.Id,
                    //
                    //                                          ]
                    //
                    //                                }
                    //                        print(checData)
                    //                                AccountAPI.signin(servciename: "EventDiaryNote/DeleteEventDiaryNote", checData) { res in
                    //                                switch res {
                    //                                case .success:
                    //                                    print("resulllll",res)
                    //                        //            if let json = res.value{
                    //                        //
                    //                        //            }
                    //
                    //
                    //                                    obs.showlist = true
                    //                                    obs.showpiclist = true
                    //                                    obs.showvidlist = true
                    //                                    obs.showaudiolist = true
                    //
                    //                                    obs.fetch()
                    //                                case let .failure(error):
                    //                                  print(error)
                    //                                }
                    //                              }
                    //                               }) {
                    //                               Image("icons8-macos-close-24 (1)")
                    //                                    .resizable()
                    //
                    //                                    .aspectRatio(contentMode: .fit)
                    //
                    //
                    //                            } .frame(width: 40.0, height: 40.0)
                    //
                    //
                    //                        }
                    //
                    //                        //.padding(.vertical, 4.0)
                    //                        .background(Color.white)
                    //                        .cornerRadius(15.0)
                    //
                    //                        //.shadow(color: .gray, radius: 5, x: 1, y: 1)
                    //                    }
                    //
                    //                        } else{
                    //                            HStack{
                    //                                //Spacer()
                    //
                    //                                Text("No Items Found")
                    //                                        .font(.custom("Inter-Bold", size: 20))
                    //
                    //                            }
                    //        //
                    //                        }
                    //                    }
                    
                    
                    
                    // Spacer()
                    // }
                    
                }
            }
            // Spacer(minLength: 30)
                
            
            if $showCameraPopUp.wrappedValue {
                ZStack {
                    Color.white
                    VStack(alignment: .center, spacing: 10.0) {
                        Spacer().frame(height : 10)
                        
 
                  
                        HStack{
                            
                            Text("Add New Photos")
                                .font(.custom("Inter-Bold", size: 25))
                            .foregroundColor(Color.black)
                            Spacer()
                            Button(action: {
                                self.showCameraPopUp = false
                               // self.obs.fetch()
                            }) {
                               Image("cross")
                                    .resizable()
                                    
                                    .aspectRatio(contentMode: .fit)
                               
                            }
                            .frame(width: 20, height: 20)
//   .offset(x: UIScreen.main.bounds.width/2 - 50)
                     
                        }
                     
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
            
            
            
            if $obs.showvideopopup1.wrappedValue
            {
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
            
//            {
//                ZStack {
//                   //
//                    Color.white
//                    VStack(alignment: .center, spacing: 20.0) {
//                        Spacer()
//                    Button(action: {
//                        obs.showvideopopup1 = false
//                        self.obs.fetch()
//                    }) {
//                       Image("icons8-macos-close-24 (1)")
//                            .resizable()
//                            
//                            .aspectRatio(contentMode: .fit)
//                       
//                        
//                    }
//                    .frame(width: 32.0, height: 32.0)
//                    .offset(x: 100)
//                    
//                   
//                        Text("Add New Videos")
//                            .font(.custom("Inter-Bold", size: 24))
//                            .foregroundColor(Color("themecolor"))
//                        Spacer()
//                        Button(action: {
//                            UserDefaults.standard.set("Edit", forKey: "eventNOE")
//                            UserDefaults.standard.set("video", forKey: "fromwhere")
//
//                            self.showVideoscreenPopUp = true
//
//                           // self.showVideoPopUp = false
//                        }, label: {
//                            Text("Click Using Camera")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        .fullScreenCover(isPresented: $showVideoscreenPopUp, content: CreateEventView.init)
//
//                        Button(action: {
//                            UserDefaults.standard.set("vid", forKey: "pov")
//                             self.showvideoPicker = true
//                            
//
//                        }, label: {
//                            Text("Choose from gallery")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        .sheet(isPresented: $showvideoPicker) {
//                        ImagePicker(sourceType: .photoLibrary) { video in
//                                self.showvideoPicker = false
//                            }
//                                    
//                        }
//                        Spacer()
//                    }.padding()
//                   
//
//                }
//                .frame(width: UIScreen.main.bounds.width-60, height: 290)
//                .cornerRadius(20)
//                .shadow(color: .gray, radius: 3, x: 1, y: 1)
//            }
            
            
            if $showrecdPopUp.wrappedValue
            {
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
                                    Image("mic 1")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .scaledToFill()
                                }
                                .frame(width: 70, height: 70)
                                //.background((Color("themecolor 1")))
                                //.foregroundColor(.white)
                                //.cornerRadius(10)
                                
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
                                Image("mic 1")
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
//            {
//                ZStack {
//                   //
//                    Color.white
//                    VStack(alignment: .center, spacing: 20.0) {
//                        Spacer()
//                    Button(action: {
//                        showrecdPopUp = false
//                        self.obs.fetch()
//                    }) {
//                       Image("icons8-macos-close-24 (1)")
//                            .resizable()
//
//                            .aspectRatio(contentMode: .fit)
//
//
//                    }
//                    .frame(width: 32.0, height: 32.0)
//                    .offset(x: 100)
//
//
//
//
//                        Text("Add New Voices")
//                            .font(.custom("Inter-Bold", size: 24))
//                            .foregroundColor(Color("themecolor"))
//                        Spacer()
//                        Button(action: {
//                            UserDefaults.standard.set("Edit", forKey: "eventNOE")
//                            UserDefaults.standard.set("audio", forKey: "fromwhere")
//                            self.showrecdscreenPopUp = true
//                            //self.showrecdPopUp = false
//                        }, label: {
//                            Text("Record  Using Mobile")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        .fullScreenCover(isPresented: $showrecdscreenPopUp, content: CreateEventView.init)
//                        Button(action: {
//                            showmp3Picker = true
//                             ///
//                        }, label: {
//                            Text("Choose from device")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        .sheet(isPresented: $showmp3Picker) {
//                            MusicPicker()
//                                    }
//                        Spacer()
//                    }.padding()
//
//
//                }
//                .frame(width: UIScreen.main.bounds.width-60, height: 290)
//                .cornerRadius(20)
//                .shadow(color: .gray, radius: 3, x: 1, y: 1)
//            }
            
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
                .frame(width: UIScreen.main.bounds.width)
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
                                .font(.custom("Inter-Bold", size: 18))
                                .foregroundColor(Color.black)
                        
                            Spacer()
                        } .frame(width: UIScreen.main.bounds.width - 20 )
                        
                        HStack{
                            
                        }
                        .frame(width: UIScreen.main.bounds.width-30, height: 1.0)
                        .border(Color.black, width: 1)
                        .padding(.bottom, 3.0)
                        
                        
                        VStack(spacing: 10){
                            
                            
                            VStack{
                                TextField("Enter Dairy Name", text: $DairyName)
                                    .padding(.all)
                                    .font(.custom("Inter-Regular", size: 14))
                                    .frame(width: UIScreen.main.bounds.width-30, height: 50)
                                    .border(Color.gray, width: 0.5)
                            }
                            
                            
                            HStack{
                                Text(Datestr)
                                    .font(.custom("Inter-Regular", size: 14))
                                    .foregroundColor(Color.black)
                                
                              Spacer()
                            }  .frame(width: UIScreen.main.bounds.width - 20 )

                            HStack{
                                Text(Addressstr)
                                    .font(.custom("Inter-Regular", size: 14))
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
                            //                                        Text(DairyDes ?? "Enter  Dairy Description")
                            //                                                                 // following line is a hack to create an inset similar to the TextEditor inset...
                            //                                            .padding([.top, .leading], 10.0)
                            //                                            .foregroundColor(Color(.lightGray))
                            //                                            .opacity(DairyDes == nil ? 1 : 0)
                            //                                    }
                            //   .font(.body)

                            
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
                                        EventDetail(filelist : obs.filelistall , addrs : "")
                                    })
                            }
//           .padding(.horizontal, 10.0)
                              
                          }

                        }
                        
                        Spacer()
                        
                        HStack{
                            
                            Button(action: {
                            
                                self.deleteevent()
                            }, label: {
                                Text("Delete Entry")
                                    .font(.custom("Inter-Bold", size: 18))
                                    .frame(width: UIScreen.main.bounds.width/2-10, height: 50)

                            })
                            .background((Color.black))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            
                            Button(action: {
                                //
                                self.AddDairy()
                            }, label: {
                                Text("Update Diary")
                                    .font(.custom("Inter-Bold", size: 18))
                                    .frame(width: UIScreen.main.bounds.width/2-10, height: 50)

                            })
                            .background((Color("themecolor-1")))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            
                        }   .frame(width: UIScreen.main.bounds.width-20, height: 50)

                    }.padding()
                   

                }
                .frame(width: UIScreen.main.bounds.width)
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
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "refreshProfile"), object: nil, queue: OperationQueue.main) {
                            pNotification in
                obs.fetch()
            }
            obs.fetch()
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
          //  obs.fetch()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshProfile"), object: self)

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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshProfile"), object: self)

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
            GridCellview(person: $0, showCross: showDairy)
      }
    }
    private func gridView1(_ geometry: GeometryProxy) -> some View {
        QGrid(obs.piclist,
            columns: Int(self.columns),
            columnsInLandscape: Int(self.columns),

            vSpacing: min(self.vSpacing, 0),

            hSpacing: max(min(self.hSpacing, 0), 0.0),

            vPadding: min(self.vPadding, 0),

            hPadding: max(min(self.hPadding, 0), 0.0),
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


struct GridCell: View {
    @ObservedObject var obs = partyinfoObserver()

  var person: FilesModal
   // @State var books = [Book]()
    @State var showPopup = false
    @State var showpicture = false

  var body: some View {
    ZStack{
    VStack() {
        let baseURLimg11 = URL(string: person.file)
        AsyncImage(
            url: baseURLimg11!,
            placeholder: { Text("Loading..").foregroundColor(colorGrey1) },
                        image: { Image(uiImage: $0).resizable()
                             }
        )
//        Image(person.image)
//            .resizable()
        .frame(width: UIScreen.main.bounds.width/2 - 20, height: 260)
        .clipShape(Rectangle())
        //.padding([.top, .leading, .trailing], 10)
        .aspectRatio(contentMode: .fit)
        
    } .onTapGesture {
       showpicture = true
    }.fullScreenCover(isPresented: $showpicture, content: {
        ImageViewer(imgstr : person.file)
    })
        
        
        
       HStack{
        
        
            Image("icons8-macos-close-24")
                .resizable()
            .frame(width: 40, height: 40)
            .clipShape(Rectangle())
            //.padding([.top, .leading, .trailing], 10)
            .aspectRatio(contentMode: .fit)
        }.frame(width: 40, height: 40)
       .onTapGesture {
        obs.showpiclist = true

        var checData: Parameters {
            [
                "id": person.fileId,

                  ]

        }
print(checData)
        AccountAPI.signin(servciename: "Upload/DeleteUploadedFile", checData) { res in
        switch res {
        case .success:
            print("resulllll",res)
//            if let json = res.value{
//
//            }
            obs.showlist = true
            obs.showpiclist = true
            obs.showvidlist = true
            obs.showaudiolist = true
            obs.fetch()
        case let .failure(error):
          print(error)
        }
      }
       }
       .offset(x: UIScreen.main.bounds.width/4-30 , y : -105)
        
        
    }.background(Color.white
                    .ignoresSafeArea())
    .cornerRadius(30)
    //.shadow(color: colorGrey1, radius: 3)
    .padding([.top, .leading, .trailing,.bottom], 5)
    .font(.headline).foregroundColor(.black)
//    .onTapGesture {
//        print(person.catname)
//        showPopup = true
//        UserDefaults.standard.set(person.id, forKey: "catID")
//        UserDefaults.standard.set(person.catname, forKey: "catname")
//
//    }.fullScreenCover(isPresented: $showPopup, content: {
//                SubCatagory()
//
//            })
  }
}

import AVKit

struct GridCellview: View {
   //
    @ObservedObject var obs = partyinfoObserver()

  var person: AllFilesModal
    @State var showPopup = false
    @State var showpicture = false
    @State var audioPlayer: AVAudioPlayer!
    @State var showCross : Bool

  var body: some View {
    ZStack{
    VStack (spacing: 0){
        if person.fileType == "jpg" || person.fileType == "jpeg"{
            let baseURLimg11 = URL(string: person.thumbnail)
            AsyncImage(
                url: baseURLimg11!,
                placeholder: { Text("Loading..").foregroundColor(colorGrey1) },
                image: { Image(uiImage: $0).resizable()
                }
            )
            
            .frame(width: UIScreen.main.bounds.width/3, height: 100)
            .clipShape(Rectangle())
            //.padding([.top, .leading, .trailing], 10)
            .scaledToFill()
        } 
        else if person.fileType == "Notes"{
            VStack{
                Image("icons8-notepad-100")
                    .resizable()
             .frame(width: 60, height: 60)

            }
            .frame(width: UIScreen.main.bounds.width/3, height: 100)
                .background(Color("themecolor"))
            
        }
        else if person.fileType == "mp4" ||  person.fileType == "3gp"{
            ZStack{
               
                let baseURLimg11 = URL(string: person.thumbnail)
                AsyncImage(
                    url: baseURLimg11!,
                    placeholder: { Text("Loading..").foregroundColor(colorGrey1) },
                    image: { Image(uiImage: $0).resizable()
                    }
                )
                
                .frame(width: UIScreen.main.bounds.width/3, height: 100)
                .clipShape(Rectangle())
                //.padding([.top, .leading, .trailing], 10)
                .scaledToFill()
                
                
                Image("icons8-circled-play-24")
                    .resizable()
             .frame(width: 40, height: 40)

            }
        }
        else if person.fileType == "mp3"{
            ZStack{
               
                let baseURLimg11 = URL(string: person.thumbnail)
                AsyncImage(
                    url: baseURLimg11!,
                    placeholder: { Text("Loading..").foregroundColor(colorGrey1) },
                    image: { Image(uiImage: $0).resizable()
                    }
                )
                
                .frame(width: UIScreen.main.bounds.width/3, height: 100)
                .clipShape(Rectangle())
                //.padding([.top, .leading, .trailing], 10)
                .scaledToFill()
                
                Image("icons8-microphone-100_w")
                    .resizable()
             .frame(width: 40, height: 40)

            }
        }
    }.frame(width: UIScreen.main.bounds.width/3, height: 100)
//     .padding(.leading, 10)
//    .onTapGesture {
//       showpicture = true
//    }
//    .fullScreenCover(isPresented: $showpicture, content: {
//        ImageViewer(imgstr : person.file)
//    })
        
        
        if showCross == true {
            HStack{
                
                Image("icons8-multiply-90")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Rectangle())
                   // .padding([.top, .leading, .trailing], 10)
                    .aspectRatio(contentMode: .fit)
                   
            }
            
            .frame(width: 32, height: 32)
                .onTapGesture {
                    obs.showpiclist = true
                    
                    var checData: Parameters {
                        [
                            "id": person.fileId,
                            
                        ]
                        
                    }
                    print(checData)
                    AccountAPI.signin(servciename: "Upload/DeleteUploadedFile", checData) { res in
                        switch res {
                        case .success:
                            print("resulllll",res)
                           
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshProfile"), object: self)
                            
                            
                        case let .failure(error):
                            print(error)
                        }
                    }
                }
                .offset(x: UIScreen.main.bounds.width/6 - 20 , y : -32)
        }
        
    }.background(Color.white.ignoresSafeArea())
    .cornerRadius(0)
//    //.shadow(color: colorGrey1, radius: 3)
//    .padding([.top, .leading, .trailing,.bottom], 5)
//    .font(.headline).foregroundColor(.black)
//    .onTapGesture {
//        print(person.catname)
//        showPopup = true
//        UserDefaults.standard.set(person.id, forKey: "catID")
//        UserDefaults.standard.set(person.catname, forKey: "catname")
//
//    }.fullScreenCover(isPresented: $showPopup, content: {
//                SubCatagory()
//
//            })
  }
}

struct GridCell1: View {
    @ObservedObject var obs = partyinfoObserver()

  var person: FilesModal
   // @State var books = [Book]()
    @State var showPopup = false

  var body: some View {
    ZStack{
    VStack() {

        let baseURLimg11 = URL(string: person.thumbnail)
        AsyncImage(
            url: baseURLimg11!,
            placeholder: { Text("Loading..").foregroundColor(colorGrey1) },
            image: { Image(uiImage: $0).resizable()
            }
        )
//        Image(person.image)
//            .resizable()
        .frame(width: UIScreen.main.bounds.width/2 - 20, height: 260)
        .clipShape(Rectangle())
        //.padding([.top, .leading, .trailing], 10)
        .aspectRatio(contentMode: .fit)
        
        
    }
        HStack(){
           
            Image("icons8-macos-close-24")
                .resizable()
            .frame(width: 40, height: 40)
            .clipShape(Rectangle())
            //.padding([.top, .leading, .trailing], 10)
            .aspectRatio(contentMode: .fit)
        }.frame(width: 40, height: 40)
        .onTapGesture {
         var checData: Parameters {
             [
                 "id": person.fileId,
             ]
         }

         AccountAPI.signin(servciename: "Upload/DeleteUploadedFile", checData) { res in
         switch res {
         case .success:
             print("resulllll",res)
 //            if let json = res.value{
 //
 //            }
            obs.showlist = true
            obs.showpiclist = true
            obs.showvidlist = true
            obs.showaudiolist = true
             obs.fetch()
         case let .failure(error):
           print(error)
         }
       }
        }
        //.offset(x: 50 , y : -105)
        .offset(x: UIScreen.main.bounds.width/4-30 , y : -105)

        HStack{
            Image("icons8-circled-play-24")
                .resizable()
            .frame(width: 40, height: 40)
            .clipShape(Rectangle())
            //.padding([.top, .leading, .trailing], 10)
            .aspectRatio(contentMode: .fit)
        }
        
        
    }.background(Color.white
                    .ignoresSafeArea())
    .cornerRadius(30)
    //.shadow(color: colorGrey1, radius: 3)
    .padding([.top, .leading, .trailing,.bottom], 5)
    .font(.headline).foregroundColor(.black)
//    .onTapGesture {
//        print(person.catname)
//        showPopup = true
//        UserDefaults.standard.set(person.id, forKey: "catID")
//        UserDefaults.standard.set(person.catname, forKey: "catname")
//
//    }.fullScreenCover(isPresented: $showPopup, content: {
//                SubCatagory()
//
//            })
      
  }
}
struct GridCell2: View {
    @ObservedObject var obs = partyinfoObserver()
    
    var person: FilesModal
    
    // @State var books = [Book]()
    @State var showPopup = false
    
    var body: some View {
        
        HStack(){
            
            Image("icons8-play-24")
                .resizable()
                .frame(width: 32, height: 22)
                .clipShape(Rectangle())
            //.padding([.top, .leading, .trailing], 10)
                .aspectRatio(contentMode: .fit)
            
            Image("recording")
                .resizable()
                .frame(height: 40)
            
                .aspectRatio(contentMode: .fit)
            
            Image("icons8-macos-close-24")
                .resizable()
                .frame(width: 32, height: 32)
                .clipShape(Rectangle())
            //.padding([.top, .leading, .trailing], 10)
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    var checData: Parameters {
                        [
                            "id": person.fileId,
                            
                        ]
                    }
                    
                    AccountAPI.signin(servciename: "Upload/DeleteUploadedFile", checData) { res in
                        switch res {
                        case .success:
                            print("resulllll",res)
                            //            if let json = res.value{
                            //
                            //            }
                            obs.showlist = true
                            obs.showpiclist = true
                            obs.showvidlist = true
                            obs.showaudiolist = true
                            obs.fetch()
                        case let .failure(error):
                            print(error)
                    }
                }
            }
        }
        .padding(.horizontal, 5.0)
        .frame(height: 80)
        .background(Color("themecolor"))
        .cornerRadius(40)
        
    }
}
struct UpdatepartyDetails_Previews: PreviewProvider {
    static var previews: some View {
        UpdatepartyDetails()
    }
}






class partyinfoObserver: ObservableObject {
   
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
            self.filelistall = []
            self.filelist = []
            self.notlist = []
            self.mp3list = []
            self.piclist = []
            self.vidlist = []
            self.imglist = []
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
                self.mp3list = []
                self.piclist = []
                self.vidlist = []
//                var i = Int()
//                                i = 0
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
                        let dtstr  = ""//dateFormatter.string(from: date!)

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

struct FilesModal :Identifiable {
    var id: Int
    
    var  fileId : String
    var    fileType : String
    var    file : String
    var    thumbnail : String

    
    init(_ id:Int,_ fileId:String,_ fileType:String,_ file:String,_ thumbnail:String){
        self.id  = id

       self.fileId  = fileId
       self.fileType = fileType
        self.file = file
        self.thumbnail = thumbnail

    }
    
    
}
struct AllFilesModal :Identifiable {
    var id: Int
    
    var  fileId : String
    var    fileType : String
    var    file : String
    var    thumbnail : String
    var    noteText : String

    
    init(_ id:Int,_ fileId:String,_ fileType:String,_ file:String,_ thumbnail:String,_ noteText:String){
        self.id  = id

       self.fileId  = fileId
       self.fileType = fileType
        self.file = file
        self.thumbnail = thumbnail
        self.noteText = noteText

    }
    
}
struct imagesModal :Hashable {
   
    var    imgname : String
    
    init(_ imgname:String){
     
       self.imgname = imgname
       
    }
    
}
struct NotesModal :Hashable {
    var  Id : String
    var   noteText : String
    
    init(_ Id:String,_ noteText:String){
       self.Id  = Id
       self.noteText = noteText
       
    }
    
}
struct eventmodalclassss:Hashable {
    var    Id : Int
    var    eventId : String
    var    userId : String
    var    longitude : String
    var    latitude : String
    var    diaryName : String
    var    diaryDescription  : String
    var    date : String
    var    Files : NSArray
    var    Notes : NSArray
    var    audioCount : String
    var    vedioCount : String
    var    picCount : String
    var    imageArray : [String]
    var    Addrs : String
    var    imgStr : String
    var    diary_Count : Int
    var    friend_Count : Int

    init(_ Id:Int,_ eventId:String,_ userId:String,_ longitude:String,_ latitude:String,_ diaryName:String,_ diaryDescription:String,_ date:String,_ Files:NSArray,_ Notes:NSArray,_ audioCount:String,_ vedioCount:String,_ picCount:String,_ imageArray:[String],_ Addrs:String,_ imgStr:String,_ diary_Count:Int,_ friend_Count:Int){
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
        self.imgStr = imgStr
        self.Id = Id
        self.diary_Count = diary_Count

        self.friend_Count = friend_Count

    }
    
}
struct pineventmodalclassss:Hashable {
    var  eventId : String
            var  userId : String
    var    longitude : String
    var    latitude : String
    var    diaryName : String
    var    diaryDescription  : String
    var    date : String
    var    thumbnail : String
    var    Addrs : String

   
    init(_ eventId:String,_ userId:String,_ longitude:String,_ latitude:String,_ diaryName:String,_ diaryDescription:String,_ date:String,_ thumbnail:String,_ Addrs:String){
       self.eventId  = eventId
       self.userId = userId
        self.longitude = longitude
        self.latitude = latitude
        self.diaryName = diaryName
        self.diaryDescription = diaryDescription
        self.date = date
        self.thumbnail = thumbnail
        self.Addrs = Addrs

    }
    
}
struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    private var presentationMode
   

    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void
    let mediaType = String()
    final class Coordinator: NSObject,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {
        @ObservedObject var obs = partyinfoObserver()
        @Published var showToast: Bool = false
        @Published var message: String = ""
        @Binding
        private var presentationMode: PresentationMode
        private let sourceType: UIImagePickerController.SourceType
        private let onImagePicked: (UIImage) -> Void
        private let mediaType = String()

        init(presentationMode: Binding<PresentationMode>,
             sourceType: UIImagePickerController.SourceType,
             onImagePicked: @escaping (UIImage) -> Void) {
            _presentationMode = presentationMode
            self.sourceType = sourceType
            self.onImagePicked = onImagePicked
         
           //

        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            let myId = UserDefaults.standard.string(forKey: "pov") ?? ""
            if (myId == "pic"){
                let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                onImagePicked(uiImage)
               
                let imageUrl = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerImageURL")]
                self.uploadInBackground(fileInData: imageUrl as! URL)

            }else if(myId == "vid") {
                let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
                obs.showvideopopup1 = false
                
                self.uploadInBackground(fileInData: videoUrl!)


            }
           
//            let asset = PHAsset.fetchAssetsWithALAssetURLs([imageUrl], options: nil).firstObject as! PHAsset
//            print("location: " + String(asset.location))
//            print("Creation Date: " + String(asset.creationDate))

            presentationMode.dismiss()
            

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

        func uploadInBackground(fileInData: URL) {
            
            let evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""

            var groupid = String()
            var isgroupid = String()
        //
            let ISfromGroup =            UserDefaults.standard.string(forKey: "isGroup")
        //        UserDefaults.standard.set("yes", forKey: "isGroup")

            if ISfromGroup == "yes"{
                groupid = UserDefaults.standard.string(forKey: "groupId") ?? ""
                isgroupid = "true"
            }else{
                groupid = "0"
                isgroupid = "false"
            }
           
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
                    let myId = UserDefaults.standard.string(forKey: "pov") ?? ""
                    if (myId == "pic"){
                        print("fileInData",fileInData)
                        multipartFormData.append(fileInData, withName: "file", fileName: "jpg", mimeType: "image/jpg")

                    }else if(myId == "vid") {
                        multipartFormData.append(fileInData, withName: "file", fileName: "mp4", mimeType: "video/mp4")


                    }
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
                            if ISfromGroup == "yes"{
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroupProfile"), object: self)

                            }else{
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshProfile"), object: self)

                            }
                           
                        }
                        
                    case .failure(let encodingError):
                        //print encodingError.description
                        print(encodingError.localizedDescription)
                    }
                }
            }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode,
                           sourceType: sourceType,
                           onImagePicked: onImagePicked)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        let myId = UserDefaults.standard.string(forKey: "pov") ?? ""
        if (myId == "pic"){
            picker.mediaTypes = ["public.image"]

        }else if(myId == "vid") {
            picker.mediaTypes = ["public.movie"]

        }
        
        picker.allowsEditing = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
      

    }

}
import SwiftUI
import MediaPlayer
import AVFoundation
struct MusicPicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentationMode
   // @EnvironmentObject var player: AudioPlayer

    class Coordinator: NSObject, UINavigationControllerDelegate, MPMediaPickerControllerDelegate {

        var parent: MusicPicker

        init(_ parent: MusicPicker) {
            self.parent = parent
        }

        func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {

            let selectedSong = mediaItemCollection.items

            if (selectedSong.count) > 0 {
                let songItem = selectedSong[0]
                parent.setSong(song: songItem)
                mediaPicker.dismiss(animated: true, completion: nil)
            }
        }
    }

    func setSong(song: MPMediaItem) {
       // player.setAudioTrack(song: song)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MusicPicker>) -> MPMediaPickerController {
        let picker = MPMediaPickerController()
        picker.allowsPickingMultipleItems = false
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: MPMediaPickerController, context: UIViewControllerRepresentableContext<MusicPicker>) {
    }

}
struct TextView: UIViewRepresentable {
 
    @Binding var text: String
    @Binding var textStyle: UIFont.TextStyle
 
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
 
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.layer.borderWidth = 0.3
        //textView.layer.borderColor = UIColor.gray.cgColor
        return textView
    }
 
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
}
import GoogleMaps
import CoreLocation

struct GoogleMapAdapterView1: UIViewRepresentable {
     
    typealias UIViewType = GMSMapView
    let marker : GMSMarker = GMSMarker()

    private static var defaultCamera1 = GMSCameraPosition.camera(withLatitude: 77.8136, longitude: 28.767677, zoom: 10.0)
  
    @State var camera = GMSCameraPosition()
    @State var mapView = GMSMapView()
    @State  var mapDelegateWrapper = GMSMapViewDelegateWrapper1()

    @State var mapDelegate = GMSMapViewDelegateWrapper1()
    
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
                UserDefaults.standard.set(currentAddress, forKey: "AddressE")
                

       
            }
    
        }
    }
   
    
    
    /// Creates a `UIView` instance to be presented.
    
     func makeUIView(context: Self.Context) -> UIViewType {
        print("IPPROTO_HELLO:::%@","IPPROTO_HELLO")
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        var currentLocation: CLLocation!

        
        if CLLocationManager.locationServicesEnabled() {
            switch locManager.authorizationStatus {
            case .restricted, .denied:
                    print("Location services are not enabled")
               
            default:
                    currentLocation = locManager.location
                }
            } else {
                print("Location services are not enabled")
            }
      
        var lat = 28.896526
        var lon = 77.773582
//
      //  UserDefaults.standard.set(lat, forKey: "latE")
      //  UserDefaults.standard.set(lon, forKey: "longE")
        
        
//        let lat = Double(userLatitude)!
//        let lon = Double(userLongitude)!
//        var lat = Double()
//
        lat   = UserDefaults.standard.double(forKey: "latE")
//        var lon = Double()
//
        lon   = UserDefaults.standard.double(forKey: "longE")
//
        print(lat)

        print(lon)
        
      
      
        GoogleMapAdapterView1.defaultCamera1 = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: lat,longitude: lon), zoom: 8.0)
        
       // mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GoogleMapAdapterView1.defaultCamera1)
        mapView.isMyLocationEnabled = true

        self.mapDelegate = mapDelegateWrapper

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
        self.mapView.animate(to: GoogleMapAdapterView1.defaultCamera1)

        marker.isDraggable  = true
        mapView.selectedMarker = marker
        marker.tracksInfoWindowChanges = true
        reverseGeocoding(marker: marker)
        //self.mapView.delegate = self
//        UserDefaults.standard.set(lat, forKey: "lat")
//        UserDefaults.standard.set(lon, forKey: "long")
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
class GMSMapViewDelegateWrapper1: NSObject, GMSMapViewDelegate {
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
        UserDefaults.standard.set(mapView.myLocation?.coordinate.latitude, forKey: "latE")
        UserDefaults.standard.set(mapView.myLocation?.coordinate.longitude, forKey: "longE")
      //  gmap.marker.map = mapView
        print(mapView.myLocation!)
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
//        UserDefaults.standard.set(String(marker.position.latitude), forKey: "lat")
//        UserDefaults.standard.set(String(marker.position.longitude), forKey: "long")

        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                let lines1 = address.lines! as [String]
                
                print("Response is = \(address)")
                print("Response line is = \(lines1)")
                
                currentAddress = lines1.joined(separator: "\n")
              
            marker.title = currentAddress
            //marker.map = self.mapView
                UserDefaults.standard.set(currentAddress, forKey: "AddressE")
                
            }
    
        }
    }
   
    
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        print("hello")

        
        print(CLLocationCoordinate2D())
    }
    
    
    
}

struct GoogleMapView_Previews1: PreviewProvider {
    static var previews: some View {
        GoogleMapAdapterView1()
    }
}

//import Macaw
//
//struct SVGImage: UIViewRepresentable {
//  // a binding allows for dynamic updates to the shown image
//  @Binding var name: String
//
//  init(name: Binding<String>) {
//    _name = name
//  }
//
//  // convenience constructor to allow for a constant image name
//  init(name: String) {
//    _name = .constant(name)
//  }
//
//  func makeUIView(context: Context) -> SVGView {
//    let svgView = SVGView()
//    svgView.backgroundColor = UIColor(white: 1.0, alpha: 0.0) // otherwise the background is black
//    svgView.contentMode = .scaleToFill
//    return svgView
//  }
//
//  func updateUIView(_ uiView: SVGView, context: Context) {
//    uiView.fileName = name
//  }
//}
