//
//  friendsProfileView.swift
//  MapzApp
//
//  Created by Admin on 16/12/22.
//

import SwiftUI


struct friendsProfileView_Previews: PreviewProvider {
    static var previews: some View {
        friendsProfileView( selectedTab: "")
    }
}
//
//  ProfileView.swift
//  MapzApp
//
//  Created by Misha Infotech on 30/08/2021.
//

import SwiftUI
import CoreLocation
import GoogleMaps
import GooglePlaces
import Alamofire
import ExytePopupView

struct friendsProfileView: View {
    //@Binding var x : CGFloat
    @State var offsetX = -UIScreen.main.bounds.width + 80
   
    @ObservedObject var obs = FriendprofileinfoObserver()
    @Environment(\.presentationMode) var presentationMode
    @State var selectedTab: String
    @State var Addressstr  = String()
    @State var imgstr = "img_b"
    @State    var liftstr = "list_w"
    @State var showNextView = false
    @State var colr: String = ""
    @State  var latitt = 0.0
    @State  var longitt = 0.0
    @State var isClicked: Bool = false
    @State  var productitem: Friendprofileeventmodalclasssss? = nil
    @State var showupdateview = false
    @State var showfriendlist: Bool = false
    @State var showFilterList: Bool = false

    @State  var showsetting = false

    @State  var showlist = false
    @State  var showFriendlist = false

      @State  var showbotton = false

      @State  var showcollc = true
    @State var evntID = String()
    @State var grpD = String()

    @State var sharedUrl = String()
    @State var heightview : CGFloat = 370
    @State var heightplus : CGFloat = 35

    @State var duration : String = "Duration"
    var durationarr  = ["Earlier","3 Days","1 Week","2 Weeks","1 Month","3 Months"]
    var durationarr1  = ["Today","Before3Days","Before1Week","Before2Weeks","Before1Month","Before3Months"]

    let arrlist = ["","","",""]
    
    
    var body: some View {
        ZStack{
            VStack(spacing: 0.0) {
               
           
                Spacer()
                      .frame(height :heightplus)
//                ScrollView( showsIndicators: false){
                    VStack(spacing: 0.0){
                     
                        
                        HStack{
                          
                            Image("back")
                                .resizable()
                                .frame(width: 24.0, height: 24.0)
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()

                                }
                                .frame(height: 32)
                            Spacer()
                        }
                      

                    HStack(alignment: .center, spacing: 10.0){
                    
                        VStack{
                    AsyncImage(
                        url: NSURL(string: UserDefaults.standard.string(forKey: "fprofilePictureURL") ?? "")! as URL ,
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
                  
                    
                        }
                        VStack(alignment: .leading, spacing: 5.0){
                            
                            Text(UserDefaults.standard.string(forKey: "fname") ?? "")
                                .font(.custom("Inter-Bold", size: 19))
                            
                            Text(UserDefaults.standard.string(forKey: "fdateOfBirth") ?? "")
                                .font(.custom("Inter-Regular", size: 14))
                            
                            Text(UserDefaults.standard.string(forKey: "ftagLine") ?? "")
                                .font(.custom("Inter-Regular", size: 14))
                            
                        }
                        Spacer()
                    
                    }
                        Spacer()
                            .frame(height: 7.0)
                        HStack(spacing: 20.0) {
                          
                             
                        }
                        
                        .frame(width :UIScreen.main.bounds.width-20 , height: 1.0)
                        .background(Color.black)
                        Spacer()
                            .frame(height: 10.0)
                        HStack(spacing: 0.0){
                       // Spacer()
                       HStack(alignment: .center){
                         Text("Diary")
                               .font(.custom("Inter-Regular", size: 14))
                            Text(String(UserDefaults.standard.integer(forKey: "ftotalEvent")))
                                .font(.custom("Inter-Bold", size: 14))
                               // .foregroundColor(Color("yellowColor"))
                               // .foregroundColor(Color.white)
                        }
                       //.padding(.horizontal, 15.0)

                       .frame(width : UIScreen.main.bounds.width/2-10,height: 30)
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
                                    .foregroundColor(.gray)
                                
                                 Text(String(UserDefaults.standard.integer(forKey: "ftotalFriend")))
                                     .font(.custom("Inter-Bold", size: 14))
                                     .foregroundColor(.gray)

                                    // .foregroundColor(Color("yellowColor"))
                                 
                                 
                               
                                    // .foregroundColor(Color.white)
                             }
//                            .background(true)
                            .onTapGesture {
//                                showfriendlist.toggle()
                            }
                            .fullScreenCover(isPresented: $showfriendlist, content: {
                                friendSFriendlist()
                            })
                            
                            
                            //.padding(.horizontal, 15.0)

                            .frame(width : UIScreen.main.bounds.width/2 - 10,height: 30)
                            
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
//      Super                       .fullScreenCover(isPresented: $showFilterList, content: {
//                                FilterView()
//                            })

                            
                            
                        }
                    }
                    .padding(.horizontal, 10.0)
                    .frame(width: UIScreen.main.bounds.width , height: 170)
                
                    ZStack{
                    
                    VStack(alignment: .center, spacing: 0.0){
                        VStack(alignment: .center, spacing: 0.0){
                        
                            MapView2f(coordinate: CLLocationCoordinate2D(latitude: obs.Latit, longitude: obs.Longit), locitem:obs.eventlist, markerint: obs.selector,isClicked: $isClicked)
            //
//                                .sheet(isPresented: $isShown) { () -> View in
//                                            LoginViews()
//                                        }
                            }
                        .frame(height: UIScreen.main.bounds.height - 350 - heightplus)
                        //.offset( y: 10)
                        HStack(spacing : 8){
                                Image("loctio")
                                    .resizable()
                                   
                                    .frame(width: 15, height: 32.0)
                                Text(Addressstr)
                                .font(.custom("Inter-SemiBold", size: 12))
                                    .foregroundColor(Color.white)
                                Spacer()
                                
                            }
//                            .padding(.horizontal , 10)
                            .padding()

                            .frame(height: 40.0)
                            //.background(Color("themecolor"))
                            .background(RoundedCorners(color: Color("themecolor"), tl: 0, tr: 0, bl: 0, br: 0))
                        
                        if (obs.show == false){
                            blankView(imageNAme: "no_found_diary",ErrorMsg : "Diary not Found")
                                .frame(height: 125)

                        }
                        else{
                            if (showcollc && obs.show){
                                collectionview()
//                                VStack{
//                                collectionview()
//                                }  .frame(height: 125)
//                                    .background(Color.gray)
                        }
 
                        }
                    }
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
                                                obs.selector = index
                                                obs.Latit = Double(pokemon.latitude) ?? 0.0
                                                obs.Longit = Double(pokemon.longitude) ?? 0.0
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
                        }
                        
                        if (showFriendlist ){
                              
                            ScrollView{
                            ForEach(obs.eventlist, id: \.self) { pokemon in
                                            HStack{
                                                Image("loccc-2")
                                                    .resizable()
                                                    .frame(width: 20.0, height: 40.0)

                                                    
                                                VStack(alignment: .leading){
                                                Text(pokemon.diaryName  + pokemon.date)
                                                    .font(.custom("Inter-Bold", size: 16))
                                              
                                                Text(pokemon.Addrs)
                                                    .font(.custom("Inter-Regular", size: 16))

                                               
                                            }
                                            Spacer()
                                                
                                            }
                                           // .padding(.horizontal)
                                            .frame(width: UIScreen.main.bounds.width)
                                                .background(Color.white)
                                        }
                        
//                            listvieww()
                                
                            }
                                .frame(width :UIScreen.main.bounds.width , height: UIScreen.main.bounds.height - 170 + heightplus)
                                .background(Color.white)
                        }
                    }
                    
                    
//                    if (showview){
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 30.0){
//
//                            ForEach(obs.eventlist, id: \.self) { i in
//
//                       // ForEach(0..<Databoarding.count){_ in
//                            FreshCellView2F(productitem: i)
//
//
//                        }
//                        }
//                        .padding(.all, 10.0)
//                    }.frame(width : UIScreen.main.bounds.width ,height: 460.0)
//
//                    }
                
                Spacer()
//                Spacer()
//                      .frame(height :heightplus)
               // }.disabled(true)
                
                //.environment(\.isScrollEnabled, false)
            }//.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-60)
            .edgesIgnoringSafeArea(.all)
            .onAppear(){//"duration"
                UserDefaults.standard.set("", forKey: "startdate")
                UserDefaults.standard.set("", forKey: "EndDate")

                
                UserDefaults.standard.set(0, forKey: "index")
               // UserDefaults.standard.set("", forKey: "duration")

                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "click__closef"), object: nil, queue: OperationQueue.main) {
                                pNotification in
                    
                    self.callnotification()

                }

                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "filter"), object: nil, queue: OperationQueue.main) {
                                pNotification in
                    UserDefaults.standard.set(0, forKey: "index")
                    UserDefaults.standard.set("", forKey: "duration")
                    obs.eventlist = []
                    obs.iq = 1
                    obs.page = 0
                    obs.gid = grpD
                     
                    obs.fetchEvent()
                   

                }
                if UIDevice.current.hasNotch {
                    heightplus = 35
                } else {
                    //... don't have to consider notch
                    heightplus = 20
                }
            
            }
//            if (obs.show == true){
//
////                    if (obs.eventlist.count > 0){
////                    selectedTab = obs.eventlist[0].eventId
////                        Addressstr = obs.eventlist[0].Addrs
////
////
////
////                }
//            }
//            if (showbotton){
//                searchonlybutton()
//            }else{
//                        searchallbutton()
//                      }
//
//
            if (isClicked == true){
//
                VStack{
                    Image("icons8-macos-close-24 (1)")
                        .resizable()

                        //.padding(.trailing, 10.0)
                        .frame(width: 32, height: 32)
                        //.cornerRadius(16)

                       // .aspectRatio(contentMode: .fit)
                        .onTapGesture {
//                                self.evntID = productitem!.eventId
//                                self.share()
                            isClicked = false
                        }
                        .offset(x : +(UIScreen.main.bounds.width/2 - 60))
                    
                    HStack{
                        
                        AsyncImage(
                            
                                url: NSURL(string: UserDefaults.standard.string(forKey: "fprofilePictureURL")!)! as URL,
                                           placeholder: { Image("icons8-male-user-72").foregroundColor(colorGrey1)
                                            .aspectRatio(contentMode: .fit)
                                           },
                                                       image: { Image(uiImage: $0).resizable()
                                                        
                                                            }
                                       )
                       // Image("icons8-male-user-72")
                         
                        .frame(width: 70, height: 70)
                        .cornerRadius(35)
                        .aspectRatio(contentMode: .fit)
                        
                       
                        VStack(alignment: .leading, spacing: 5.0){
                           
                            Text(UserDefaults.standard.string(forKey: "fname") ?? "")                    .font(.custom("Inter-Bold", size: 20))
                            HStack{
                            Image("loccc")
                                .resizable()

                                .padding(.trailing, 10.0)
                                .frame(width: 32, height: 32)
                                
                                .aspectRatio(contentMode: .fit)
                                Text(productitem?.Addrs ?? "")//(getAddressFromLatLon(pdblLatitude: "22.3232",withLongitude: "76.43423"))
                                    .font(.custom("Inter-Regular", size: 16))
                                Spacer()
                            }
                        }
                        Spacer()
                       
                    }
                    .frame(width :  UIScreen.main.bounds.width - 30 , height: 70)

                    ZStack{
                        VStack{
                            AsyncImage(
                                url: NSURL(string: self.productitem?.imgStr ?? "")! as URL ,
                                               placeholder: { Image("").foregroundColor(colorGrey1)
                                                .aspectRatio(contentMode: .fit)
                                               },
                                                           image: { Image(uiImage: $0).resizable()
                                               }
                                           )
                         
                            .cornerRadius(20)
                           
                        }
                       //
                        HStack{
                          
                        VStack(alignment: .leading, spacing: 5.0){
                            Text(productitem?.date ?? "")
                                    .font(.custom("Inter-Bold", size: 16))
                                    .foregroundColor(Color.white)
                           
                            Text(productitem!.diaryName)
                                        .font(.custom("Inter-Bold", size: 25))
                                    .foregroundColor(Color("lightBlue"))
                            
                            
                            
                            HStack(spacing: 8.0){
                                HStack{
                                //Spacer()
                                Image("img_y")
                                     .resizable()
                                    .frame(width: 24, height: 24)
                                     .aspectRatio(contentMode: .fit)
                                
                                   Text(productitem!.picCount)
                                    .font(.custom("Inter-Regular", size: 13))
                                    .foregroundColor(Color.white)
                              
                               // Spacer()
                                Image("vid_y")
                                     .resizable()
                                    .frame(width: 24, height: 24)
                                     .aspectRatio(contentMode: .fit)
                                
                                   Text(productitem!.vedioCount)
                                    .font(.custom("Inter-Regular", size: 13))
                                    .foregroundColor(Color.white)
                               //
                                   // Spacer()
                                    
                                }
                                HStack{
                                Image("rec_y")
                                     .resizable()
                                    .frame(width: 24, height: 24)
                                     .aspectRatio(contentMode: .fit)
                                
                                Text(productitem!.audioCount)
                                    .font(.custom("Inter-Regular", size: 13))
                                    .foregroundColor(Color.white)
                               //
                                //
                                   // Spacer()
                                Image("note_y")
                                     .resizable()
                                    .frame(width: 24, height: 24)
                                     .aspectRatio(contentMode: .fit)
                                
                                Text(String((productitem?.Notes.count)!))
                                    .font(.custom("Inter-Regular", size: 13))
                                    .foregroundColor(Color.white)
                                //
                                    Spacer()
                                    
                                    Image("icons8-share-24")
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
                            }

                            Spacer()
                            
                            }
                           
                        .padding(.leading, 20.0)
                           
                           // Spacer()
                      //
                            
                        }
                        .padding(.top, 10.0)
                        //
                        .frame(width : UIScreen.main.bounds.width - 30 , height: 120)
                        .background(Color.black.opacity(0.5))
                        //
                        .offset(y : 70)

                    } .frame(width : UIScreen.main.bounds.width - 30 , height: 290)

                }
                .frame(width : UIScreen.main.bounds.width - 30 , height: 440.0)
                .background(RoundedCorners(color: Color("lightBlue"), tl: 30, tr: 30, bl: 30, br: 30))
                .onTapGesture {
                    UserDefaults.standard.set("Edit", forKey: "eventNOE")
                    UserDefaults.standard.set(productitem?.eventId, forKey: "eventID")
                    showupdateview = true
                    //isClicked = false
                }
                .fullScreenCover(isPresented: $showupdateview, content: FFUpdatepartyDetails.init)

            
                
                
                
            }
           
        }.onAppear(){//"duration"
            showupdateview = false
            UserDefaults.standard.set(0, forKey: "index")
            UserDefaults.standard.set("", forKey: "duration")
            obs.eventlist = []
            obs.iq = 1
obs.page = 0
            obs.gid = grpD
            obs.fetchEvent()
        
        }
        
    }
    
    func searchonlybutton() -> some View{
        
        VStack(spacing: 10.0){
                VStack(spacing: 0.0){
                    
                    HStack{
                        Text(duration)
                            .font(.custom("Inter-Bold", size: 18))
                            .foregroundColor(Color("themecolor 1"))
                            .padding(.all, 5.0)
                            .frame(height: 50.0)
                           
                      Spacer()
                        Image("icon_up")
                            .resizable()
                            .frame(width: 32.0, height: 32.0)
                            .onTapGesture {
                                self.showbotton.toggle()
                            }
                            
                    }
                    .background(RoundedCorners(color: Color("themecolor 1"), tl: 25, tr: 25, bl: 25, br: 25))
                    .frame(width:180,height: 60)
                        .padding(.horizontal, 10.0)
                  
                    List {
                        ForEach(durationarr, id: \.self) { string in

                            Text(string)
                                        .frame(height: 30)
                                .onTapGesture {
                                    duration = string
                                }
                        }.listRowBackground(Color("lightBlue"))
                                .background(Color("lightBlue"))
                            }.background(Color("lightBlue"))
                    
                   // .frame(height: 160)

                    
                    
                    
                    
                    
                }.background(Color("lightBlue"))
                .padding(.all, 0.0)
                .frame(height: 310)
                .cornerRadius(25)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)

            
            
            Button(" Apply "){
            
                for i in 0..<durationarr.count {
                    let str = durationarr[i]
                    
                    if (str == duration ){
                        UserDefaults.standard.set(durationarr1[i], forKey: "duration")
                    }
                }
                
                
                

               
                                    obs.eventlist = []
                                    obs.iq = 1
                obs.gid = grpD
                obs.page = 0
                                      obs.fetchEvent()
                
                    }.font(.custom("Inter-Bold", size: 20))
                    .foregroundColor(Color.white)
                    .frame(width: 160,height: 40)
                    .background(Color("themecolor"))
                    .cornerRadius(10)
            
            
            
            
            Spacer()
            
        }
        //.padding(.top, 10.0)
        .frame(width: 180,height: heightview)
        
        .background(Color("lightBlue"))
        .cornerRadius(25)
      //
        //.offset(x:UIScreen.main.bounds.width/2 - 90)
        .shadow(color: .gray, radius: 3, x: 1, y: 1)
//
        //.padding(.top, -(UIScreen.main.bounds.height/2 - 120))
//        .padding(.leading ,130)
        
        .padding(.bottom ,100)
        .padding(.leading ,130)
        }
    func searchallbutton() -> some View{
        VStack{
            
            
            HStack{
                Text(duration)
                    .font(.custom("Inter-Bold", size: 18))
                    .foregroundColor(Color("bluecolor"))
                    .padding(.all, 5.0)
                    .frame(height: 50.0)
                   
              Spacer()
                Image("icon_up")
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
                    .onTapGesture {
                        self.showbotton.toggle()
                    }
                    
            }
            .background(RoundedCorners(color: Color("themecolor 1"), tl: 25, tr: 25, bl: 25, br: 25))
            .frame(height: 50.0)
           
           
            
            
            
        }.frame(width:180,height: 60)
            .padding(.horizontal, 10.0)
        //.padding(.horizontal, 0.0)

            .background(Color("themecolor 1"))
       
            .cornerRadius(25)
       
            //.offset(x: 50)
       
        .shadow(color: .gray, radius: 3, x: 1, y: 1)
        .padding(.bottom ,330)
        .padding(.leading ,130)

        }
    
    func collectionview() -> some View{
        
        ScrollViewReader { scrollProxy in

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0.0){
                    //ForEach(obs.eventlist, id: \.self) { person in
                        ForEach(Array(obs.eventlist.enumerated()), id: \.offset) { index, person in


//
                            VStack{
                               
             
                                if (person.imgStr != ""){

                                  AsyncImage(
                                    url: NSURL(string: person.imgStr )! as URL ,
                                                       placeholder: { Image("LOADER_X").foregroundColor(colorGrey1)
                                                        .aspectRatio(contentMode: .fit)
                                                       },
                                                                   image: { Image(uiImage: $0).resizable()

                                                                        }
                                                   )
                                   

                                  .frame(width : 125.0 , height:125.0)
                                 .aspectRatio(contentMode: .fill)
                                  //  .cornerRadius(20)
                                   // .offset(x : -15,y : -15)
                        
                        
                                 
                                }
                                
                       
                                    else{
                                      //  SVGImage(svgName: "ic_note")
                                                    //.frame(width: 50, height: 550)
                                        Image("note_thumbnail (2)")
                                            .resizable()
                                            .frame(width : 125.0 , height:125.0)

                                    }
                                
                            }.onAppear(){
                                obs.loadMoreContent(currentItem: person)
                            }
                            .frame(height: 125.0)
                            .background(Color.gray)

                            .onTapGesture(count: 2) {
                                print("Double Tap!")
                               
                                selectedTab = person.eventId
                                  Addressstr = person.Addrs
                                colr = "lightBlue"
                                  print(Addressstr)
                                obs.selector = index
                                obs.Latit = Double(person.latitude) ?? 0.0
                                obs.Longit = Double(person.longitude) ?? 0.0
                                UserDefaults.standard.set(index, forKey: "index")
                                productitem = person
                                UserDefaults.standard.set("Edit", forKey: "eventNOE")
                                UserDefaults.standard.set(productitem?.eventId, forKey: "eventID")
                                showupdateview = true
                                
                            }
                            
                            .onTapGesture(count: 1) {
                                print("Single Tap!")

                              selectedTab = person.eventId
                                Addressstr = person.Addrs
                              colr = "lightBlue"
                                print(Addressstr)
                              obs.selector = index
                              obs.Latit = Double(person.latitude) ?? 0.0
                              obs.Longit = Double(person.longitude) ?? 0.0
                              UserDefaults.standard.set(index, forKey: "index")
                              productitem = person
                             // MapView2f.updateUIView(<#T##self: MapView2f##MapView2f#>)
                            }
                            .fullScreenCover(isPresented: $showupdateview, content: FFUpdatepartyDetails.init)

                            .border((selectedTab == person.eventId ? Color.white : Color("")), width: 2)
                            
                            
                    }
                }            .background(Color.white)

               //                .fullScreenCover(isPresented: $showupdateview, content: UpdatepartyDetails.init)

            }//.padding(.horizontal, 5.0)
            .frame(height: 125)
            .background(Color.white)
            .onAppear(){
                if (obs.eventlist.count > 0){
//                selectedTab = obs.eventlist[0].eventId
                    Addressstr = obs.eventlist[0].Addrs
//                    productitem = obs.eventlist[0]
                }

                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "click__closef1"), object: nil, queue: OperationQueue.main) {
                                pNotification in
                    
                    //
                    selectedTab = UserDefaults.standard.string(forKey: "eID") ?? ""
                   var indx = Int()
                   
                    for i in 0..<obs.eventlist.count {
                        let item = obs.eventlist[i]
                        if (selectedTab == item.eventId){
                            selectedTab = item.eventId
                              Addressstr = item.Addrs
                         
                              print(Addressstr)
                            obs.selector = i
                            indx = i
                            UserDefaults.standard.set(i, forKey: "index")
                            productitem = item
                        }
                              
                    }
                    scrollProxy.scrollTo(indx)
                }
                
            }
        } .frame(height: 125)
            
    }
    func listvieww() -> some View{
        VStack(spacing : 5) {
            List(Array(obs.eventlist.enumerated()), id: \.offset) { index, pokemon in

          //  List(obs.eventlist, id: \.self) { pokemon in
                            HStack{
                                Image("loccc-2")
                                    .resizable()
                                    .frame(width: 20.0, height: 40.0)

                                VStack(alignment: .leading){
                                Text(pokemon.diaryName  + pokemon.date)
                                    .font(.custom("Inter-Bold", size: 16))
                              
                                Text(pokemon.Addrs)
                                    .font(.custom("Inter-Regular", size: 16))

                               
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
                                    obs.selector = index
                                    obs.Latit = Double(pokemon.latitude) ?? 0.0
                                    obs.Longit = Double(pokemon.longitude) ?? 0.0
                                    UserDefaults.standard.set(index, forKey: "index")
                                    productitem = pokemon
                                    UserDefaults.standard.set("Edit", forKey: "eventNOE")
                                    UserDefaults.standard.set(productitem?.eventId, forKey: "eventID")
                                    showupdateview = true
                                    
                                }
                        }

        }                 .frame(width: UIScreen.main.bounds.width,height:  UIScreen.main.bounds.height-170)
            .background(Color.white)

 //.frame(height: 300.0)
     }
    
    
    func callnotification(){
        selectedTab = UserDefaults.standard.string(forKey: "eID") ?? ""
        for i in 0..<obs.eventlist.count {
            let item = obs.eventlist[i]
            if (selectedTab == item.eventId){
                selectedTab = item.eventId
                  Addressstr = item.Addrs
             
                  print(Addressstr)
                obs.selector = i
//                indx = i
//                UserDefaults.standard.set(i, forKey: "index")
                productitem = item
            }
                  
        }
        
        
        
        
        isClicked = true
    }
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) -> String  {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(pdblLatitude)")!
            //21.228124
            let lon: Double = Double("\(pdblLongitude)")!
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        var addressString : String = ""

            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }


                        print(addressString)
                  }
            })
return addressString
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
struct FreshCellView2F : View {
    @State  var productitem: Friendprofileeventmodalclasssss? = nil
    @State  var product: imagesModal?  = nil//= self.productitem?.imageArray
    @State var evntID = String()

    @State var sharedUrl = String()
    @Environment(\.presentationMode) var presentationMode

//    var image1 = String()
//    var image2 = String()
//    var image3 = String()
//    var image4 = String()
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) -> String  {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(pdblLatitude)")!
            //21.228124
            let lon: Double = Double("\(pdblLongitude)")!
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        var addressString : String = ""

            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }


                        print(addressString)
                  }
            })
return addressString
        }
    
    
    
    
    var body : some View{
        
        ZStack{
            VStack{
                HStack{
                    
                    AsyncImage(
                        
                            url: NSURL(string: UserDefaults.standard.string(forKey: "fprofilePictureURL")!)! as URL,
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
                    
                   
                    VStack(alignment: .leading, spacing: 5.0){
                       
                        Text(UserDefaults.standard.string(forKey: "fname") ?? "")                    .font(.custom("Inter-Bold", size: 20))
                        HStack{
                        Image("loccc")
                            .resizable()

                            .padding(.trailing, 10.0)
                            .frame(width: 32, height: 32)
                            
                            .aspectRatio(contentMode: .fit)
                            Text(productitem?.Addrs ?? "")//(getAddressFromLatLon(pdblLatitude: "22.3232",withLongitude: "76.43423"))
                                .font(.custom("Inter-Regular", size: 16))
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
                .frame(width :  UIScreen.main.bounds.width - 30 , height: 90)

                ZStack{
                    VStack{
                        AsyncImage(
                            url: NSURL(string: self.productitem?.imgStr ?? "")! as URL ,
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
                    }
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
                    .frame(width : UIScreen.main.bounds.width - 30 , height: 120)
                    .background(Color.black.opacity(0.8))
                    //
                    .offset(y : 50)

                } .frame(width : UIScreen.main.bounds.width - 30 , height: 290)

//                .background(
//                    ZStack{
//
//
//                        AsyncImage(
//                            url: NSURL(string: self.productitem!.imageArray[3])! as URL ,
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
//                            url: NSURL(string: self.productitem!.imageArray[2])! as URL ,
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
//                            url: NSURL(string: self.productitem!.imageArray[1])! as URL ,
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
//                            url: NSURL(string: self.productitem!.imageArray[0])! as URL ,
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
//
//
//
//
//
//    )
            }
            .frame(width : UIScreen.main.bounds.width - 30 , height: 440.0)
            .background(RoundedCorners(color: Color("lightBlue"), tl: 30, tr: 30, bl: 30, br: 30))
            
        }
        
       // .padding(.leading, 30.0)
    
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
class FriendprofileinfoObserver: ObservableObject {
   
    @Published   var eventlist = [Friendprofileeventmodalclasssss]()
    @Published   var filelist = [FilesModal]()
    @Published   var mp3list = [FilesModal]()
    @Published   var piclist = [FilesModal]()
    @Published   var vidlist = [FilesModal]()
    @Published   var imgl = String()
    @Published   var gid = String()

    @Published   var notlist = [NotesModal]()
    @Published   var showview = false
    @Published   var show = false
    @Published   var friendScount = Int()

    @Published   var showlist = false
    @Published   var showpiclist = false
    @Published   var showaudiolist = false
    @Published   var showvidlist = false
    @Published   var imglist = [String]()
    @Published   var selector = Int()
    @Published   var Latit = Double()
    @Published   var Longit = Double()

    var iq : Int = 0
                   // i = 1
    var totalPages : Int = 0
       var page : Int = 0
      
    
    
//    init() {
//        fetchEvent()
//    }
    
    func loadMoreContent(currentItem item: Friendprofileeventmodalclasssss){
            let thresholdIndex = self.eventlist.index(self.eventlist.endIndex, offsetBy: -1)
        print(thresholdIndex)
            if thresholdIndex == item.Id - 1, (page + 1) <= totalPages {
                page += 1
                print(item.Id)
              //  print(thresholdIndex)
                fetchEvent()
            }
        }
    
    
    func fetchEvent(){
        UserDefaults.standard.set(0, forKey: "index")

        selector = 0
        Latit = 0.0
        Longit = 0.0
        let stt = UserDefaults.standard.string(forKey: "fid") ?? ""
        let stt1 = UserDefaults.standard.string(forKey: "duration") ?? ""
        let str = "id=" +  stt + "&&Duration=" + stt1 + "&&Page=" + String(page)
       
        
      //  let str1  = "Profile/GetProfileDetailsWithEventById/?" + str
       // AccountAPI.getsignin(servciename: str1, nil) { res in
     
        
        var logInFormData: Parameters {
            [
                "id": stt,
                  "page": page,
                  "duration": "",
                  "title": "",
                "startDate": "",
                "endDate": "",
                "groupId" : gid,
                  ]
        
        }
        
        print(logInFormData)
            AccountAPI.signin(servciename: "Profile/GetProfileDetailsWithEventById", logInFormData) { res in

            switch res {
        case .success:
            print("resulllll",res)
            
            if let json = res.value{
                print("Josn",json)
        let userdic = json["data"]
                
                let profile = userdic["profile"]
                let events = userdic["events"]
                //
                let fullName : String = profile["dateOfBirth"].stringValue
                let fullNameArr : [String] = fullName.components(separatedBy: "T")
                let datestr: String = fullNameArr[0]
            
                UserDefaults.standard.set(profile["id"].int, forKey: "fid")

                        UserDefaults.standard.set(profile["email"].string, forKey: "femail")
                UserDefaults.standard.set((profile["firstName"].string ?? "") + (profile["lastName"].string ?? "") , forKey: "fname")
                     //   UserDefaults.standard.set(profile["mobile"].string, forKey: "phoneNumber")
                        UserDefaults.standard.set(datestr, forKey: "fDateOfBirth")
                        UserDefaults.standard.set(profile["profilePictureURL"].string, forKey: "fprofilePictureURL")
        //
                UserDefaults.standard.set(profile["totalEvent"].int, forKey: "ftotalEvent")
               // UserDefaults.standard.set(fullName, forKey: "fDateOfBirth")

                UserDefaults.standard.set(profile["tagLine"].string, forKey: "ftagLine")
                UserDefaults.standard.set(profile["totalFriend"].int, forKey: "ftotalFriend")
                UserDefaults.standard.set(profile["totalEvent"].int, forKey: "ftotalEvent")

                 
                self.friendScount = userdic["friends"].int ?? 0
               // self.eventlist = []
              //  var pgs  = String()
                //let pgs =
                    self.totalPages =  json["totalPage"].int ?? 0 + 1
                //self.totalPages = Int(truncating: NSNumber( nonretainedObject: json["totalPage"] ))//Int(json["totalPage"])

                for j in events {
                    let filestinfor = j.1["files"]
                    let notestinfor = j.1["notes"]

                self.filelist = []
                self.notlist = []
                    self.totalPages =  json["totalPage"].int ?? 0 + 1

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
//                if self.notlist.count > 0 {
//                    self.showlist.toggle()
//                }
               
                    if (self.piclist.count > 0){
                        self.self.imgl = self.piclist[0].file
                    } else if (self.vidlist.count > 0){
                        self.imgl = self.vidlist[0].thumbnail
                    }
                    else if (self.mp3list.count > 0){
                        self.imgl = self.mp3list[0].thumbnail
                    }
                    else {
                        self.imgl = ""
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
            
                    
                    
                    let lat: Double = Double("\(j.1["latitude"].stringValue)")!
                    let lon: Double = Double("\(j.1["longitude"].stringValue)")!
                    let fullName : String = j.1["date"].stringValue
                    let fullNameArr : [String] = fullName.components(separatedBy: " ")
                    let datestr: String = fullNameArr[0]

                let geocoder = GMSGeocoder()
                let coordinate = CLLocationCoordinate2DMake(lat,lon)
                var currentAddress = String()
                var postalAddress = String()

                    
//
                    let str = j.1["address"].stringValue
                    print(str)
                    
                    if str == ""{
                        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
                            if let address = response?.firstResult() {
                                let lines1 = address.lines! as [String]
                                
                                print("Response is = \(address)")
                                print("Response line is = \(lines1)")
                                
                                currentAddress = lines1.joined(separator: "\n")
                                postalAddress = address.postalCode ?? ""
                                let scc = Friendprofileeventmodalclasssss(self.iq,j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, datestr, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.piclist.count),self.imglist as [String],currentAddress,j.1["userName"].stringValue, j.1["profilePictureURL"].stringValue,j.1["dob"].stringValue,"201301",self.imgl)
                                self.eventlist.append(scc)
                                self.iq = self.iq + 1

                            }
                        }}else{
                        let scc = Friendprofileeventmodalclasssss(self.iq,j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, datestr, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.piclist.count),self.imglist as [String],j.1["address"].stringValue,j.1["userName"].stringValue, j.1["profilePictureURL"].stringValue,j.1["dob"].stringValue,"201301",self.imgl)
                    self.eventlist.append(scc)
                            self.iq = self.iq + 1

                    }
               
                
                   
                  //  print("kdckmdckdmkck",self.eventlist)
                }
                if (self.eventlist.count > 0){
                    self.selector = 0
                    self.Latit = Double(self.eventlist[0].latitude) ?? 0.0
                    self.Longit =  Double(self.eventlist[0].longitude) ?? 0.0
                    self.show = true

                }else{
                    self.show = false
                }

             //   print(self.eventlist)
                self.showview  = true
            }
          

        case let .failure(error):
          print(error)
        }
      }
    }
    
}
struct MapView2f: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D
    var locitem = [Friendprofileeventmodalclasssss]()
    var locationManager = CLLocationManager()
    let marker1 : GMSMarker = GMSMarker()
//    let latit : Double
//    let longit : Double
    @State  var mapDelegateWrapper = GMSMapViewDelegateWrapper2f()

    @State var mapDelegate = GMSMapViewDelegateWrapper2f()
    @State var markerint : Int
    @State var camera = GMSCameraPosition()
    @State var mapView = GMSMapView()
   // @StateObject var locationManager = LocationManager()
    private static var defaultCamera = GMSCameraPosition.camera(withLatitude: -37.8136, longitude: 144.9631, zoom: 11.0)
    @Binding var isClicked: Bool
    private static var bounds = GMSCoordinateBounds()

    let marker : GMSMarker = GMSMarker()
   // @ObservedObject var memberData = friendsinfoObserver()

    func makeUIView(context: Self.Context) -> GMSMapView {
        
      
        
              var currentLoc: CLLocation!
        currentLoc = locationManager.location
        var lat = 28.656526
        var lon = 77.563582
       //
        mapDelegateWrapper.isClicked = isClicked
        //self.markerint = 0
//        switch locationManager.authorizationStatus {
//        case .restricted, .denied:
//            camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 10.0)
//             mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        default:
//            currentLoc = locationManager.location
//
//            camera = GMSCameraPosition.camera(withLatitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude, zoom: 10.0)
//             mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        }
        MapView2f.defaultCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: lat,longitude: lon), zoom: 11.0)
        
       
        self.mapDelegate = mapDelegateWrapper

        self.mapView.delegate = mapDelegateWrapper
        
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: MapView2f.defaultCamera)
        self.mapView.animate(to:  MapView2f.defaultCamera)

        mapView.settings.compassButton = false
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = false
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = false
        mapView.settings.tiltGestures = false
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
            , zoom: 11.0)
        self.mapView.animate(to: camera)
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
       // reverseGeocoding(marker: marker)
        return true

    }
   

    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        
        print("locitem ::::%@",locitem.count)
        self.mapView.clear()

        for city in locitem {

            let marker1 : GMSMarker = GMSMarker()
            marker1.position = CLLocationCoordinate2D(latitude: Double(city.latitude)!, longitude: Double(city.longitude)!)
           //
           // marker1.title = city.diaryName + "%"  + city.date
            marker1.snippet = city.eventId
           //
            
          //  marker1.snippet = city.Addrs
            marker1.map = mapView
            let index = UserDefaults.standard.integer(forKey: "index")
            print(index)
            if (city.eventId == locitem[index].eventId){
                //camera = GMSCameraPosition.camera(withLatitude: Double(city.latitude)!, longitude: Double(city.longitude)!
                //        , zoom: 10.0)
        
               
                MapView2f.defaultCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: Double(city.latitude)!,longitude: Double(city.longitude)!), zoom: 15.0)
               // self.mapView.animate(to: MapView2f.defaultCamera)
                marker1.icon = UIImage(named: "loctio")
                self.mapView.selectedMarker = marker1

            }else{
                marker1.icon = UIImage(named: "loccc-2")

            }
            
         
           // MapView2f.bounds = MapView2f.bounds.includingCoordinate(marker1.position)

            }
        self.mapView.animate(to: MapView2f.defaultCamera)
       //
      //  let update = GMSCameraUpdate.fit(MapView2f.bounds, withPadding: 50)
       //
       // self.mapView.animate(with: update)
       //
        
      //  self.mapView.animate(with: GMSCameraUpdate.fit(MapView2f.bounds, with: UIEdgeInsets(top: 50.0 , left: 50.0 ,bottom: 50.0 ,right: 50.0)))

 //       if(locitem.count > 0 )
//        {
//
//        let city1 = locitem[markerint]
////
        
//        camera = GMSCameraPosition.camera(withLatitude: Double(city1.latitude)!, longitude: Double(city1.longitude)!
////                , zoom: 10.0)
////
//        self.mapView.animate(to: camera)
//        MapView2f.defaultCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude:coordinate.latitude,longitude: coordinate.longitude), zoom: 15.0)

//            marker1.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
//            marker1.title = city1.Addrs
//            marker1.snippet = city1.diaryName
//            marker1.map = mapView
//            marker1.icon = UIImage(named: "loctio")
//            self.mapView.animate(to:  MapView2f.defaultCamera)
//
//        }
    }
}
class GMSMapViewDelegateWrapper2f: NSObject, GMSMapViewDelegate {
  //  var gmap = GoogleMapAdapterView()
    var shouldHandleTap: Bool = true
    var isClicked: Bool = true

    deinit {
        
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return shouldHandleTap
    }
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//       // let customMarker:CustomMarker = CustomMarker
//
////        let newView = CustomMarker(frame:CGRect(x:UIScreen.main.bounds.width/2 - 90  , y:0, width:180, height:125))
////        if (marker.title != nil){
////            print(marker.title ?? "test")
////        newView.titleLabel.text = marker.title
////        newView.DescriptionLabel.text = marker.snippet
////        }
////        return newView
//
//
//    }
    
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        print("Showing marker infowindow")
//        var str = String()
//        str = marker.title!
//
//
//        let fullNameArr = str.split(separator: "%")
//       var title = String()
//        var id = String()
//
//        var des = String()
//
//        if (fullNameArr.count > 0){
//            title = String(fullNameArr[0])
//            if (fullNameArr.count > 1){
//                des = String(fullNameArr[1])
//            }else{
//                des = ""
//            }
//            id = marker.e ?? ""
//
//        }else{
//            title = ""
//            des = ""
//            id = ""
//
//        }
//        let callout = UIHostingController(rootView: MarkerInfoWindow(titleLabel: title , DescriptionLabel: des, Id: id))
//        callout.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 110, height: 120)
//        return callout.view
//    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf didTapInfoWindowOfMarker: GMSMarker) {
            print("You tapped a marker's infowindow!")
    //        This is where i need to get the view to appear as a modal, and my attempt below
//            let venueD2 = UIHostingController(rootView: VenueDetail2())
//            venueD2.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 48)
//            self.view.addSubview(venueD2.view)
     //
        self.isClicked.toggle()

       // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "click__closef"), object: self)
        
        
        
            return
        }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("hello TAP")
        print("hello TAP")
        print(marker.snippet!)
        var str = String()
        str = marker.snippet!
        let fullNameArr = str.split(separator: " ") //marker.title!.componentsSeparatedByString(" ")
        UserDefaults.standard.set(fullNameArr[0], forKey: "eID")
       //
        self.isClicked.toggle()

       // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "click__closef"), object: self)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "click__closef1"), object: self)

        return true

    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker)
    {
       // gmap.reverseGeocoding(marker: marker)
      //  GoogleMapAdapterView.reverseGeocoding(marker: marker)
      
        //self.mapView.delegate = self
//        UserDefaults.standard.set(mapView.myLocation?.coordinate.latitude, forKey: "latE")
//        UserDefaults.standard.set(mapView.myLocation?.coordinate.longitude, forKey: "longE")
//      //  gmap.marker.map = mapView
        print(mapView.myLocation!)
     //   self.reverseGeocoding(marker: marker)
//        if marker.userData as! String == "changedestination"
//        {
//            self.destinationLocation = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
//            self.destinationCoordinate = self.destinationLocation.coordinate
//            //getAddressFromLatLong(destinationCoordinate)
//        }
    }
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
//            marker.title = currentAddress
//            //marker.map = self.mapView
//                UserDefaults.standard.set(currentAddress, forKey: "AddressE")
//
//            }
//
//        }
//    }
   
    
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        print("hello")
        
        print(CLLocationCoordinate2D())
    }
//    func  mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker){
//        print("hello TAP")
//
//    }
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) {
//        print("hello TAP")
//    }
    private func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        return true
    }
    
}
struct Friendprofileeventmodalclasssss : Hashable{
    var  Id : Int

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
    var    dob : String
    var    pcode : String
    var    imgStr : String

    init(_ Id:Int,_ eventId:String,_ userId:String,_ longitude:String,_ latitude:String,_ diaryName:String,_ diaryDescription:String,_ date:String,_ Files:NSArray,_ Notes:NSArray,_ audioCount:String,_ vedioCount:String,_ picCount:String,_ imageArray:[String],_ Addrs:String,_ username:String,_ profilePictureURL:String,_ dob:String,_ pcode:String,_ imgStr:String){
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
        self.dob = dob
        self.pcode = pcode
        self.imgStr = imgStr
        self.Id = Id


    }
    
}

