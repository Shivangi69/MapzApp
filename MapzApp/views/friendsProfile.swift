//
//  friendsProfile.swift
//  MapzApp
//
//  Created by Misha Infotech on 22/09/2021.
//

import SwiftUI
import SwiftUI
import CoreLocation
import GoogleMaps
import GooglePlaces

struct friendsProfile: View {
//    @Binding var x : CGFloat
//    @State var offsetX = -UIScreen.main.bounds.width + 80
    @ObservedObject var obs = friendprofileinfoObserver()
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
    @State  var productitem: profileeventmodalclasssss? = nil
    @State var showupdateview = false

    @State  var showlist = false
      @State  var showbotton = false

      @State  var showcollc = true
    @State var evntID = String()

    @State var sharedUrl = String()
    @State var duration : String = "Duration"
    @State var heightview : CGFloat = 370

    var durationarr  = ["Earlier","3 Days","1 Week","2 Weeks","1 Month","3 Months"]
    var durationarr1  = ["Today","Before3Days","Before1Week","Before2Weeks","Before1Month","Before3Months"]
    let arrlist = ["","","",""]
    var body: some View {
        ZStack{
            VStack() {
             
             HStack(spacing: 20.0) {
                 Button(action: {
                    presentationMode.wrappedValue.dismiss()
//                    withAnimation {
//                        x = 0
//                    }
                 }) {
                    Image("icons8-back-24")
                         .resizable()
                         
                         .aspectRatio(contentMode: .fit)

                 }
                Spacer()
                Text("Friend's Profile")
                    .foregroundColor(Color.white)
                    .font(.custom("Inter-Bold", size: 20))
                Spacer()
                  
             }
             .padding()
             .padding(.top,10)
             .frame(height: 55.0)
             .background(Color("themecolor"))
             
                ScrollView( showsIndicators: false){
                    
                    HStack(alignment: .center, spacing: 10.0){
                    
                        VStack{
                    AsyncImage(
                        url: NSURL(string: UserDefaults.standard.string(forKey: "fpic")!)! as URL ,
                                       placeholder: { Image("icons8-male-user-72")
                                      
                                        .resizable()
                                        .foregroundColor(colorGrey1)
                                        .aspectRatio(contentMode: .fill)
                                       },
                                                   image: { Image(uiImage: $0).resizable()
                                                    
                                                        }
                                   )
                   // Image("icons8-male-user-72")
                     
                    .frame(width: 80, height: 80)
                    .cornerRadius(40)
                     .aspectRatio(contentMode: .fit)
                  
                    
//                Button("Edit Profile"){
//                    showNextView.toggle()
//                }.font(.custom("Inter-Bold", size: 16))
//                .foregroundColor(Color.white)
//                .frame(width:90 ,height: 30)
//                .background(Color("bluecolor"))
//                .cornerRadius(15)
//                .offset(y : -30)
//                .fullScreenCover(isPresented: $showNextView, content: updateProfile.init)
//
                        }
                        VStack(alignment: .center, spacing: 5.0){
                Text(UserDefaults.standard.string(forKey: "fname") ?? "")
                    .font(.custom("Inter-Bold", size: 24))
                    .frame(height: 20)

                    .foregroundColor(Color("themecolor 1"))
                
                HStack{
                    Image("Dob_y")
                         .resizable()
                        .frame(width: 32, height: 32)
                         .aspectRatio(contentMode: .fit)
                    
                    Text(UserDefaults.standard.string(forKey: "dateOfBirth") ?? "")
                        .font(.custom("Inter-Regular", size: 16))
                }
                .padding(.top, 5.0)
                
                   
                    HStack(spacing: 30.0){
                   // Spacer()
                   HStack(alignment: .center){
                        Text(String(obs.eventlist.count))
                            .font(.custom("Inter-Bold", size: 18))
                            .foregroundColor(Color("yellowColor"))
                        
                        
                        Text("Diary")
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundColor(Color.white)
                    }
                   .padding(.horizontal, 15.0)

                    .frame(height: 30)
                   
                    .background(Color("themecolor"))
                    .cornerRadius(15)
                    //Spacer()
//                    VStack(alignment: .center){
//                        Text("125")
//                            .font(.custom("Inter-Bold", size: 22))
//                            .foregroundColor(Color("yellowColor"))
//
//
//                        Text("Followers")
//                            .font(.custom("Inter-Bold", size: 20))
//                            .foregroundColor(Color.white)
//                    }
//                    Spacer()
                    HStack(alignment: .center){
                        Text(String(obs.friendScount))
                            .font(.custom("Inter-Bold", size: 18))
                            .foregroundColor(Color("yellowColor"))
                        
                        
                        Text("Friends")
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundColor(Color.white)
                    }
                    .padding(.horizontal, 15.0)
                    .frame(height: 30)
                   
                    .background(Color("themecolor"))
                    .cornerRadius(15)
                    //Spacer()
                    }
                            
                        }
                    }
                    .padding(.horizontal, 10.0)
                
               
                    .frame(width: UIScreen.main.bounds.width - 20 , height: 120)
               
                    
                    
                    VStack{
                        VStack(alignment: .center, spacing: 0.0){
                        
                            MapView3(coordinate: CLLocationCoordinate2D(latitude: obs.Latit, longitude: obs.Longit), locitem:obs.eventlist, markerint: obs.selector,isClicked: $isClicked)
            //
//                                .sheet(isPresented: $isShown) { () -> View in
//                                            LoginViews()
//                                        }
                            }
                        .frame(height: UIScreen.main.bounds.height - 560)
                            HStack{
                                Image("mappin")
                                    .padding(.leading, 20.0)
                                    .frame(width: 32.0, height: 32.0)
                                Text(Addressstr)
                                .font(.custom("Inter-Bold", size: 17))
                            .foregroundColor(Color("darkyellow"))
                                Spacer()
                                
                            }.frame(height: 40.0)
                            //.background(Color("themecolor"))
                            .background(RoundedCorners(color: Color("themecolor"), tl: 0, tr: 0, bl: 15, br: 15))

                                        
                        VStack(spacing: 10.0){
                            HStack(spacing: 10.0){
                                Image(imgstr)
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .aspectRatio(contentMode: .fit)
                                    .onTapGesture {
                                        showlist = false
                                        showcollc = true
                                        imgstr = "img_b"
                                        liftstr = "list_w"

                                    }
                                
                                HStack{
                                    
                                }
                                .frame(width: 1, height: 32)
                                .background(Color.white)
                              
                                Image(liftstr)
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .aspectRatio(contentMode: .fit)
                                    .onTapGesture {
                                        showlist = true
                                        showcollc = false
                                        imgstr = "img_w"
                                        liftstr = "list_b"
                                    }
                            }
                                
                            }.frame(width: 140, height: 40)
                            .background(Color("themecolor 1"))
                            .cornerRadius(25)
                            .offset(x: UIScreen.main.bounds.width/2-80 , y: -20)
                        
                        
//                            if (showlist){
//                            VStack{
//                                HStack{
//                                    Text("Date")
//                                        .font(.custom("Inter-Bold", size: 24))
//                                        .foregroundColor(Color.white)
//                                        .padding(.leading, 10.0)
//                                    Spacer()
//                                    Text("Name")
//                                        .font(.custom("Inter-Bold", size: 24))
//                                        .foregroundColor(Color.white)
//
//                                    Spacer()
//
//                                    Text("Location")
//                                        .font(.custom("Inter-Bold", size: 24))
//                                        .foregroundColor(Color.white)
//                                        .padding(.trailing, 10.0)
//
//
//                                }
//                                .padding(.horizontal, 15.0)
//                                .frame(height: 70)
//                                .background(Color("bluecolor"))
//
//
//                                List(obs.eventlist, id: \.self) { pokemon in
//
//                                    HStack{
//                                        Text(pokemon.date)
//                                            .font(.custom("Inter-Regular", size: 16))
//
//                                        Spacer()
//                                        Text(pokemon.username)
//                                            .font(.custom("Inter-Regular", size: 16))
//
//                                        Spacer()
//
//                                        Text(pokemon.pcode)
//                                            .font(.custom("Inter-Regular", size: 16))
//
//                                    } .padding(.horizontal, 15.0)
//                                    .frame(height: 50)
//
//                                }
//
//                            }
//                                .frame(height: 300.0)
//
//                            }
//                        if (showcollc && obs.show){
//
//                            ScrollViewReader { scrollProxy in
//
//                                ScrollView(.horizontal, showsIndicators: false) {
//                                    LazyHStack(spacing: 10.0){
//                                        //ForEach(obs.eventlist, id: \.self) { person in
//                                            ForEach(Array(obs.eventlist.enumerated()), id: \.offset) { index, person in
//
//
////
//                                                VStack{
//
//                                 //   if (self.person?.imgStr != ""){
//
//                                                      AsyncImage(
//                                                        url: NSURL(string: person.imgStr )! as URL ,
//                                                                           placeholder: { Image("").foregroundColor(colorGrey1)
//                                                                            .aspectRatio(contentMode: .fit)
//                                                                           },
//                                                                                       image: { Image(uiImage: $0).resizable()
//
//                                                                                            }
//                                                                       )
//
//
//                                                      .frame(width : 180.0 , height:150.0)
//                                                    //  .aspectRatio(contentMode: .fill)
//                                                      //  .cornerRadius(20)
//                                                       // .offset(x : -15,y : -15)
//
//
//
//                                               //     }
//
//                                           //
////                                    else{
////                                        Image()
////                                            .resizable()
////                                            .frame(width : 180.0 , height:150.0)
////
////                                    }
//
//                                                }
//
//
//                                                .onTapGesture {
//                                                  selectedTab = person.eventId
//                                                    Addressstr = person.Addrs
//                                                  colr = "lightBlue"
//                                                    print(Addressstr)
//                                                  obs.selector = index
//                                                  obs.Latit = Double(person.latitude) ?? 0.0
//                                                  obs.Longit = Double(person.longitude) ?? 0.0
//                                                  UserDefaults.standard.set(index, forKey: "index")
//                                                  productitem = person
//                                                }
//                                                .border((selectedTab == person.eventId ? Color("bluecolor") : Color("")), width: 5)
//                                                .onAppear(){
//
//                                                    obs.loadMoreContent(currentItem: person)
//                                                }
//
//
//                                        }
//                                    }
//
//                                }.padding(.horizontal, 10.0)
//                                .frame(height: 150)
//                                .onAppear(){
//                                    if (obs.eventlist.count > 0){
//                                    selectedTab = obs.eventlist[0].eventId
//                                        Addressstr = obs.eventlist[0].Addrs
//                                        productitem = obs.eventlist[0]
//                                    }
//
//                                    NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "click_close1"), object: nil, queue: OperationQueue.main) {
//                                                    pNotification in
//
//                                        //
//                                        selectedTab = UserDefaults.standard.string(forKey: "eID") ?? ""
//                                       var indx = Int()
//
//                                        for i in 0..<obs.eventlist.count {
//                                            let item = obs.eventlist[i]
//                                            if (selectedTab == item.eventId){
//                                                selectedTab = item.eventId
//                                                  Addressstr = item.Addrs
//
//                                                  print(Addressstr)
//                                                obs.selector = i
//                                                indx = i
//                                                UserDefaults.standard.set(i, forKey: "index")
//                                                productitem = item
//                                            }
//
//                                        }
//                                        scrollProxy.scrollTo(indx)
//                                    }
//
//                                }
//                            }
//
//                        }
                        if (obs.show == false){
                            blankView(imageNAme: "no_found_diary",ErrorMsg : "Diary not Found")
                                .frame(height: 150)

                        }
                        if (showcollc && obs.show){
                               
                            collectionview()
                        }
                        else{
                            listvieww()
                            
                        }
                        }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
//                    if (showview){
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 30.0){
//
//                            ForEach(obs.eventlist, id: \.self) { i in
//
//                       // ForEach(0..<Databoarding.count){_ in
//                            FreshCellView2(productitem: i)
//
//
//                        }
//                        }
//                        .padding(.all, 10.0)
//                    }.frame(width : UIScreen.main.bounds.width ,height: 460.0)
//
//                    }
                
                Spacer()
            
                }
            }.onAppear(){
                UserDefaults.standard.set(0, forKey: "index")
                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "click_close"), object: nil, queue: OperationQueue.main) {
                                pNotification in
                    
                    
                    self.callnotification()

                              
                           
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
            if (showbotton){
                searchonlybutton()
            }else{
                        searchallbutton()
                      }

            if (isClicked == true){
//                VStack{
//                    Text(" bjk bfjk bjkf bfkb kf b fbkj bk bkje jbefbjk bkjf bjkefb jkfbjk fbjk bkjf bkjfebjk fj jkf jkfebkj jefk jkfej kfejk jkef bjkej kef ")
//                }                            .background(Color("bluecolor"))


                //FreshCellView2()
                //FreshCellView2(productitem: obs.eventlist[0])

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
                            
                                url: NSURL(string: UserDefaults.standard.string(forKey: "profilePictureURL")!)! as URL,
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
                           
                            Text(UserDefaults.standard.string(forKey: "name") ?? "")                    .font(.custom("Inter-Bold", size: 20))
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
                            //Text(productitem?.diaryDescription ?? "")
                              //      .font(.custom("Inter-Regular", size: 16))
                                //    .foregroundColor(Color("darkyellow"))
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
                .fullScreenCover(isPresented: $showupdateview, content: UpdatepartyDetails.init)

//                .onAppear(){
//                    productitem = obs.eventlist[UserDefaults.standard.integer(forKey: "index")]
//                }
                
                
                
                
            }
           
        }.onAppear(){//"duration"
            showupdateview = false
            UserDefaults.standard.set(0, forKey: "index")
            UserDefaults.standard.set("", forKey: "duration")

            
        
        }
        
    }
    
    func searchonlybutton() -> some View{
        
        VStack(spacing: 10.0){
                VStack(spacing: 0.0){
                    
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
    
    func collectionview() -> some View{
        
        ScrollViewReader { scrollProxy in

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10.0){
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
                                   

                                  .frame(width : 180.0 , height:150.0)
                                //  .aspectRatio(contentMode: .fill)
                                  //  .cornerRadius(20)
                                   // .offset(x : -15,y : -15)
                        
                        
                                 
                                }
                                
                       
                                    else{
                                        Image("note_thumbnail (2)")
                                            .resizable()
                                            .frame(width : 180.0 , height:150.0)

                                    }
                                
                            }
                            
                            .onTapGesture {
                              selectedTab = person.eventId
                                Addressstr = person.Addrs
                              colr = "lightBlue"
                                print(Addressstr)
                              obs.selector = index
                              obs.Latit = Double(person.latitude) ?? 0.0
                              obs.Longit = Double(person.longitude) ?? 0.0
                              UserDefaults.standard.set(index, forKey: "index")
                              productitem = person
                             // MapView2.updateUIView(<#T##self: MapView2##MapView2#>)
                            }
                            .border((selectedTab == person.eventId ? Color("themecolor 1") : Color("")), width: 5)
                            .onAppear(){
                                
                                obs.loadMoreContent(currentItem: person)
                            }
                           
               
                    }
                }
                
            }.padding(.horizontal, 10.0)
            .frame(height: 150)
            .onAppear(){
                if (obs.eventlist.count > 0){
                selectedTab = obs.eventlist[0].eventId
                    Addressstr = obs.eventlist[0].Addrs
                    productitem = obs.eventlist[0]
                }

                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "click__close1"), object: nil, queue: OperationQueue.main) {
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
        }
            
    }
    
    func listvieww() -> some View{
        VStack {
//             HStack{
//                 Text("Date")
//                     .font(.custom("Inter-Bold", size: 24))
//                     .foregroundColor(Color.white)
//                     .padding(.leading, 10.0)
//                 Spacer()
//                 Text("Name")
//                     .font(.custom("Inter-Bold", size: 24))
//                     .foregroundColor(Color.white)
//
//                 Spacer()
//
//                 Text("Location")
//                     .font(.custom("Inter-Bold", size: 24))
//                     .foregroundColor(Color.white)
//                     .padding(.trailing, 10.0)
//
//
//             }
//             .padding(.horizontal, 15.0)
//             .frame(height: 70)
//             .background(Color("bluecolor"))


             List(obs.eventlist, id: \.self) { pokemon in

                 HStack{
                     Text(pokemon.date)
                         .font(.custom("Inter-Regular", size: 16))

                     Spacer()
                     Text(pokemon.username)
                         .font(.custom("Inter-Regular", size: 16))

                     Spacer()

                     Text(pokemon.pcode)
                         .font(.custom("Inter-Regular", size: 16))

                 } .padding(.horizontal, 15.0)
                 .frame(height: 50)

             }

         } .frame(height: 300.0)
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

struct friendsProfile_Previews: PreviewProvider {
    static var previews: some View {
       
        friendsProfile(selectedTab: "")
    }
}
struct FreshCellView7 : View {
    @State  var productitem: profileeventmodalclasssss? = nil
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
                        
                            url: NSURL(string: UserDefaults.standard.string(forKey: "profilePictureURL")!)! as URL,
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
                       
                        Text(UserDefaults.standard.string(forKey: "name") ?? "")                    .font(.custom("Inter-Bold", size: 20))
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

            }
            .frame(width : UIScreen.main.bounds.width - 30 , height: 440.0)
            .background(RoundedCorners(color: Color("lightBlue"), tl: 30, tr: 30, bl: 30, br: 30))
            
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
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
class friendprofileinfoObserver: ObservableObject {
    
    @Published   var eventlist = [profileeventmodalclasssss]()
    @Published   var filelist = [FilesModal]()
    @Published   var mp3list = [FilesModal]()
    @Published   var piclist = [FilesModal]()
    @Published   var vidlist = [FilesModal]()
    @Published   var imgl = String()

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
      
    
    
    init() {
        fetchEvent()
    }
    
    func loadMoreContent(currentItem item: profileeventmodalclasssss){
            let thresholdIndex = self.eventlist.index(self.eventlist.endIndex, offsetBy: -1)
        print(thresholdIndex)
            if thresholdIndex == item.Id, (page + 1) <= totalPages {
                page += 1
                print(item.Id)
              //  print(thresholdIndex)
                fetchEvent()
            }
        }
    
    
    func fetchEvent(){
        selector = 0
        Latit = 0.0
        Longit = 0.0
        let stt = UserDefaults.standard.string(forKey: "fid") ?? ""
        let stt1 = UserDefaults.standard.string(forKey: "duration") ?? ""

        let str = "id=" +  stt + "&&Duration=" + stt1 + "&&Page=" + String(page)
       
        
        let str1  = "Profile/GetProfileDetailsWithEventById/?" + str
        AccountAPI.getsignin(servciename: str1, nil) { res in
        switch res {
        case .success:
            print("resulllll",res)
            
            if let json = res.value{
                print("Josn",json)
        let userdic = json["data"]
                
                let events = userdic["events"]
                //
               // self.eventlist = []
              //  var pgs  = String()
                //let pgs =
                    self.totalPages =  json["totalPage"].int ?? 0 + 1
                //self.totalPages = Int(truncating: NSNumber( nonretainedObject: json["totalPage"] ))//Int(json["totalPage"])
                self.friendScount = userdic["friends"].int ?? 0

                for j in events {
                    let filestinfor = j.1["files"]
                    let notestinfor = j.1["notes"]

                self.filelist = []
                self.notlist = []
                    self.totalPages =  json["totalPage"].int ?? 0 + 1
                ///    self.friendScount = userdic["friends"].string ?? "0"

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

                    let scc = profileeventmodalclasssss(self.iq,j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, datestr, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.piclist.count),self.imglist as [String],j.1["address"].stringValue,j.1["userName"].stringValue, j.1["profilePictureURL"].stringValue,j.1["dob"].stringValue,"201301",self.imgl)
                self.eventlist.append(scc)
                    
                    
//                geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
//                    if let address = response?.firstResult() {
//                        let lines1 = address.lines! as [String]
//
//                        print("Response is = \(address)")
//                        print("Response line is = \(lines1)")
//
//                        currentAddress = lines1.joined(separator: "\n")
//                        postalAddress = address.postalCode ?? ""
//
//                        let scc = searchprofileeventmodalclasssss(j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, datestr, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.vidlist.count),self.imglist as [String],currentAddress,j.1["userName"].stringValue, j.1["profilePictureURL"].stringValue,j.1["dob"].stringValue, postalAddress)
//                    self.eventlist.append(scc)
//                }
//                    else{
//                        let scc = searchprofileeventmodalclasssss(j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, datestr, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.vidlist.count),self.imglist as [String],"",j.1["userName"].stringValue,j.1["profilePictureURL"].stringValue,j.1["dob"].stringValue,"")
//                    self.eventlist.append(scc)
//                    }
//
//                }
                
                   
                    print("kdckmdckdmkck",self.eventlist)
                    self.iq = self.iq + 1
                }
                if (self.eventlist.count > 0){
                    self.selector = 0
                    self.Latit = Double(self.eventlist[0].latitude) ?? 0.0
                    self.Longit =  Double(self.eventlist[0].longitude) ?? 0.0
                    self.show = true

                    }

                print(self.eventlist)
                self.showview  = true
            }
          

        case let .failure(error):
          print(error)
        }
      }
    }
}
struct MapView3: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D
    var locitem = [profileeventmodalclasssss]()
    var locationManager = CLLocationManager()
    let marker1 : GMSMarker = GMSMarker()
//    let latit : Double
//    let longit : Double
    @State  var mapDelegateWrapper = GMSMapViewDelegateWrapper3()

    @State var mapDelegate = GMSMapViewDelegateWrapper3()
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
        MapView3.defaultCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: lat,longitude: lon), zoom: 11.0)
        
       
        self.mapDelegate = mapDelegateWrapper

        self.mapView.delegate = mapDelegateWrapper
        
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: MapView3.defaultCamera)
        self.mapView.animate(to:  MapView3.defaultCamera)

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
            //marker1.snippet = city.eventId + " " + city.date + " at " +  city.diaryName
           //
            marker1.title = city.diaryName + "%"  + city.date
            marker1.snippet = city.eventId
          //  marker1.snippet = city.Addrs
            marker1.map = mapView
            let index = UserDefaults.standard.integer(forKey: "index")
            print(index)
            if (city.eventId == locitem[index].eventId){
                //camera = GMSCameraPosition.camera(withLatitude: Double(city.latitude)!, longitude: Double(city.longitude)!
                //        , zoom: 10.0)
        
               
                MapView3.defaultCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: Double(city.latitude)!,longitude: Double(city.longitude)!), zoom: 15.0)
               // self.mapView.animate(to: MapView3.defaultCamera)
                marker1.icon = UIImage(named: "loctio")
                self.mapView.selectedMarker = marker1

            }else{
                marker1.icon = UIImage(named: "loccc-2")

            }
            MapView3.bounds = MapView3.bounds.includingCoordinate(marker1.position)
        }
   //
        let update = GMSCameraUpdate.fit(MapView3.bounds, withPadding: 50)
   //
        self.mapView.animate(with: update)
   //
    
    //self.mapView.animate(with: GMSCameraUpdate.fit(MapView3.bounds, with: UIEdgeInsets(top: 50.0 , left: 50.0 ,bottom: 50.0 ,right: 50.0)))
 
    }
}
class GMSMapViewDelegateWrapper3: NSObject, GMSMapViewDelegate {
  //  var gmap = GoogleMapAdapterView()
    var shouldHandleTap: Bool = true
   // @Binding
  //
    var isClicked: Bool = true

    deinit {
        
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return shouldHandleTap
    }
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
//            id = marker.snippet ?? ""
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
            self.isClicked.toggle()

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "click_close"), object: self)
        
        
        
            return
        }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
       
        print("hello TAP")
        print(marker.snippet!)
        var str = String()
        str = marker.snippet!
        
        let fullNameArr = str.split(separator: " ") //marker.title!.componentsSeparatedByString(" ")
        UserDefaults.standard.set(fullNameArr[0], forKey: "eID")
        ///NotificationCenter.default.post(name: NSNotification.Name(rawValue: "click_close1"), object: self)
        self.isClicked.toggle()

    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "click_close"), object: self)
    
    
        return true

    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker)
    {
               print(mapView.myLocation!)
     
    }
   
    
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        print("hello")
        
        print(CLLocationCoordinate2D())
    }

    
}
