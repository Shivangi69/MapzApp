//
//  SearchResult.swift
//  MapzApp
//
//  Created by Misha Infotech on 21/09/2021.
//

import SwiftUI
import Alamofire
import CoreLocation
import GoogleMaps
import GooglePlaces
import ExytePopupView

struct SearchResult: View {
    @Environment(\.presentationMode) var presentationMode
       @ObservedObject var obs = searchinfoObserver()
       @ObservedObject var obs1 = friendObserver()
       @State var evntID = String()
       @State var Addressstr  = String()
       @State var sharedUrl = String()
       @State var text: String
       @State var duration : String = "Duration"
       @State var friendname: String = "Friend's Memories"
       @State var friendid: Int = 0
       @State var addrs: String = UserDefaults.standard.string(forKey: "Address") ?? ""
       @State var selectedradio: String = "All"
       @State var colr: String = ""

      // @State private var isEditing = false
     //@State  var showlist = false
       @State  var showbotton = false
    @State  var showbotton1 = true
    @State  var showtable = false

       @State  var showcollc = true
       @State var imgstr = "img_b"
       @State    var liftstr = "list_w"
       @State var heightview : CGFloat = 500
       @State var selectedTab: String
      // @State var colr: String = ""
       @State  var productitem: searcheventmodalclassss? = nil
       @State var showupdateview = false
       @State var isClicked: Bool = false
    @State private var redVisibility: ViewVisibility = .visible
    @State private var redVisibility1: ViewVisibility = .invisible

       @State  var latitt = 0.0
       @State  var longitt = 0.0
       var durationarr  = ["Earlier","3 Days","1 Week","3 Weeks","1 Month","3 Months"]
    var durationarr1  = ["Today","Before3Days","Before1Week","Before2Weeks","Before1Month","Before3Months"]
    var body: some View {
        ZStack{
            VStack() {
             
                ScrollView( showsIndicators: false){
                    
                    VStack{
                        VStack(alignment: .center, spacing: 0.0){
                        
                            MapView1(coordinate: CLLocationCoordinate2D(latitude: obs.Latit, longitude: obs.Longit), locitem:obs.eventlist, markerint: obs.selector,isClicked: $isClicked)
            //
//                                .sheet(isPresented: $isShown) { () -> View in
//                                            LoginViews()
//                                        }
                            }
                        .frame(height: UIScreen.main.bounds.height - 440)
                           
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
                                        showtable = false
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
                                        showtable = true
                                        showcollc = false
                                        imgstr = "img_w"
                                        liftstr = "list_b"
                                    }
                            }
                                
                            }.frame(width: 140, height: 40)
                            .background(Color("themecolor 1"))
                            .cornerRadius(25)
                            .offset(x: UIScreen.main.bounds.width/2-80 , y: -20)
                           // Spacer(minLength: 15)
                            
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
//                        {
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
//                                                 // MapView2.updateUIView(<#T##self: MapView2##MapView2#>)
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
//                                    NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "clickclose1"), object: nil, queue: OperationQueue.main) {
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
                        
                        
                        //
//                        if (showtable){
//                        VStack{
//                            HStack{
//                                Text("Date")
//                                    .font(.custom("Inter-Bold", size: 24))
//                                    .foregroundColor(Color.white)
//                                    .padding(.leading, 10.0)
//                                Spacer()
//                                Text("Name")
//                                    .font(.custom("Inter-Bold", size: 24))
//                                    .foregroundColor(Color.white)
//
//                                Spacer()
//
//                                Text("Location")
//                                    .font(.custom("Inter-Bold", size: 24))
//                                    .foregroundColor(Color.white)
//                                    .padding(.trailing, 10.0)
//
//
//                            }
//                            .padding(.horizontal, 15.0)
//                            .frame(height: 70)
//                            .background(Color("bluecolor"))
//
//
//                            List(obs.eventlist, id: \.self) { pokemon in
//
//                                HStack{
//                                    Text(pokemon.date)
//                                        .font(.custom("Inter-Regular", size: 16))
//
//                                    Spacer()
//                                    Text(pokemon.username)
//                                        .font(.custom("Inter-Regular", size: 16))
//
//                                    Spacer()
//
//                                    Text(pokemon.pcode)
//                                        .font(.custom("Inter-Regular", size: 16))
//
//                                } .padding(.horizontal, 15.0)
//                                .frame(height: 50)
//
//                            }
//
//                        }
//                            .frame(height: 300.0)
//
//                        //
//
//                        }
                        
                        
                        
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
            
//
                    
                }
                //.popup(isPresented: $showbotton1, type: .floater(verticalPadding: 130),position: .top, closeOnTap: false){
//
//                    VStack{
//                        HStack{
//
//                            Image("icons8-search-24")
//                                .resizable()
//                            .frame(width: 32.0, height: 32.0)
//
//                            TextField("Search", text: $text)
//                                            .padding(7)
//                                            .background(Color(.white))
//                                            .padding(.horizontal, 10)
//
//
//
//
//
//
//                            Button(action: {
//                                self.showbotton = true
//                                self.showbotton1 = false
//
//                            }) {
//                                Image("icon_down")
//                                    .foregroundColor(.white)
//                                    .font(.system(size:15))
//                            }
//                            .frame(width: 32.0, height: 32.0)
//
//                        }
//
//                    }
//                        .frame(width: UIScreen.main.bounds.width - 40,height: 60)
//                        .padding(.horizontal, 10.0)
//                        .background(Color.white)
//
//                        .cornerRadius(10.0)
//
//                       // .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: -(UIScreen.main.bounds.height/2 - 125))
//
//                        .shadow(color: .gray, radius: 3, x: 1, y: 1)
//                }
            }.onAppear(){
                UserDefaults.standard.set(0, forKey: "index")
                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "clickclose"), object: nil, queue: OperationQueue.main) {
                                pNotification in
                    
                    
                    self.callnotification()

                              
                           
                }
                
            
            }
//            .popup(isPresented: $showbotton, type: .floater(verticalPadding: 90),position: .top, closeOnTap: false){
//
//                VStack(spacing: 10.0){
//                    HStack{
//
//                        Image("icons8-search-24")
//                            .resizable()
//                        .frame(width: 32.0, height: 32.0)
//
//                        TextField("Search", text: $text)
//                                        .padding(7)
//                                        .background(Color(.white))
//                                        .padding(.horizontal, 10)
//
//    //                                    .onTapGesture {
//    //                                        self.isEditing = true
//    //                                    }
//
//    //                                        if isEditing {
//    //                                            Button(
//    //                                                action: {
//    //                                                self.isEditing = false
//    //                                                self.text = ""
//    //
//    //                                            })
//    //                                        }
//                        Image("icon_up")
//                            .resizable()
//
//                            .frame(width: 32.0, height: 32.0)
//                            .onTapGesture {
//                                self.showbotton = false
//                                self.showbotton1 = true
//
//                            }
//
//
//
//                    }
//                    .frame(width: UIScreen.main.bounds.width - 40,height: 60)
//                    .padding(.horizontal, 10.0)
//
//
//                    HStack(spacing: 5.0){
//
//
//                        Image("location")
//                            .resizable()
//                            .frame(width: 32.0, height: 32.0)
//                        Text(addrs)
//                            .font(.custom("Inter-Bold", size: 16))
//                            .foregroundColor(Color("themecolor"))
//                        Button(" Change "){
//
//                                }.font(.custom("Inter-Bold", size: 20))
//                        .foregroundColor(Color.white)
//                        .frame(height: 40)
//                        .background(Color("themecolor"))
//                        .cornerRadius(10)
//
//                        Button(" Clear "){
//
//                                }.font(.custom("Inter-Bold", size: 20))
//                        .foregroundColor(Color("themecolor"))
//                        .frame(height: 40)
//                        .background(Color("darkyellow"))
//                        .cornerRadius(10)
//
//                    }.frame(width:UIScreen.main.bounds.width - 40 ,height:50)
//
//                    .padding(.all, 5.0)
//
//
//                    RadioButtonGroup(items: ["All", "My Memories", "Friend's"], selectedId: "All") { selected in
//                                print("Selected is: \(selected)")
//                        selectedradio = selected
//                            }.frame(width:UIScreen.main.bounds.width - 40 ,height:50)
//
//                    .padding(.all, 5.0)
//
//                    HStack(spacing: 10.0){
//                        Spacer()
//                        VStack(spacing: 0.0){
//
//                            HStack{
//                                Text(duration)
//                                    .font(.custom("Inter-Bold", size: 18))
//                                    .foregroundColor(Color("themecolor"))
//                                    .padding(.all, 5.0)
//                                    .frame(height: 50.0)
//
//                              Spacer()
//                            }
//                            .background(RoundedCorners(color: Color("bluecolor"), tl: 0, tr: 0, bl: 25, br: 25))
//                            .frame(height: 50.0)
//
//
//
//                            List {
//                                ForEach(durationarr, id: \.self) { string in
//
//                                    Text(string)
//                                                .frame(height: 30)
//                                        .onTapGesture {
//                                            duration = string
//                                        }
//                                        }.listRowBackground(Color("lightBlue"))
//                                        .background(Color("lightBlue"))
//                                    }
//
//
//
//
//
//
//
//                        }.background(Color("lightBlue"))
//                        .padding(.all, 0.0)
//                        .frame(height: 210)
//                        .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
//
//                        VStack(spacing: 0.0){
//
//                            HStack{
//                                Text(friendname)
//                                    .font(.custom("Inter-Bold", size: 18))
//                                    .foregroundColor(Color("themecolor"))
//                                    .padding(.all, 5.0)
//                                    .frame(height: 50.0)
//
//                              Spacer()
//                            }
//                            .background(RoundedCorners(color: Color("bluecolor"), tl: 0, tr: 0, bl: 25, br: 25))
//                            .frame(height: 50.0)
//
//
//
//                            List {
//                                ForEach(obs1.friendlist, id: \.self) { pokemon in
//
//                                    Text(pokemon.name)
//                                                .frame(height: 30)
//                                        .onTapGesture {
//                                            friendname = pokemon.name
//                                            friendid = Int(pokemon.Id)!
//                                        }
//                                        }.listRowBackground(Color("lightBlue"))
//                                        .background(Color("lightBlue"))
//                                    }
//
//
//
//
//
//
//
//                        }
//
//                        .background(Color("lightBlue"))
//                        .padding(.all, 0.0)
//                        .frame(height: 210)
//                        .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
//
//                        Spacer()
//
//                    }
//                    .frame(height: 210.0)
//
//
//                    Button(" Apply "){
//
//                        UserDefaults.standard.set(friendid, forKey: "frID")
//                        UserDefaults.standard.set(duration, forKey: "duration")
//                        UserDefaults.standard.set(selectedradio, forKey: "sR")
//    //                    UserDefaults.standard.set(friendname, forKey: "slat")
//    //                    UserDefaults.standard.set(friendname, forKey: "slon")
//
//                        UserDefaults.standard.set(text, forKey: "sN")
//
//                      obs.eventlist = []
//                      obs.iq = 1
//                        obs.fetchEvent()
//
//                            }.font(.custom("Inter-Bold", size: 20))
//                    .foregroundColor(Color.white)
//                    .frame(width: UIScreen.main.bounds.width - 50,height: 40)
//                    .background(Color("themecolor"))
//                    .cornerRadius(10)
//
//
//
//
//                    Spacer()
//
//                }
//                .padding(.top, 10.0)
//                .frame(width: UIScreen.main.bounds.width - 30,height: heightview)
//
//                .background(Color.white)
//                .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
//                //.offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: -(UIScreen.main.bounds.height/2 - 345))
//                .shadow(color: .gray, radius: 3, x: 1, y: 1)
//            }
//            .popup(isPresented: $showbotton1, type: .floater(verticalPadding: 130),position: .top, closeOnTap: false){
//
//                VStack{
//                    HStack{
//
//                        Image("icons8-search-24")
//                            .resizable()
//                        .frame(width: 32.0, height: 32.0)
//
//                        TextField("Search", text: $text)
//                                        .padding(7)
//                                        .background(Color(.white))
//                                        .padding(.horizontal, 10)
//
//
//
//
//
//
//                        Button(action: {
//                            self.showbotton = true
//                            self.showbotton1 = false
//
//                        }) {
//                            Image("icon_down")
//                                .foregroundColor(.white)
//                                .font(.system(size:15))
//                        }
//                        .frame(width: 32.0, height: 32.0)
//
//                    }
//
//                }
//                    .frame(width: UIScreen.main.bounds.width - 40,height: 60)
//                    .padding(.horizontal, 10.0)
//                    .background(Color.white)
//
//                    .cornerRadius(10.0)
//
//                   // .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: -(UIScreen.main.bounds.height/2 - 125))
//
//                    .shadow(color: .gray, radius: 3, x: 1, y: 1)
//            }
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
                        .offset(y : 50)

                    } .frame(width : UIScreen.main.bounds.width - 30 , height: 250)

                }
                .frame(width : UIScreen.main.bounds.width - 30 , height: 400.0)
                .background(RoundedCorners(color: Color("lightBlue"), tl: 30, tr: 30, bl: 30, br: 30))
                .onTapGesture {
                    UserDefaults.standard.set("Edit", forKey: "eventNOE")
                    UserDefaults.standard.set(productitem?.eventId, forKey: "eventID")
                    showupdateview = true
                   // isClicked = false
                }
                .fullScreenCover(isPresented: $showupdateview, content: UpdatepartyDetails.init)

            }
            
            
            
            
        }.onAppear(){//"duration"
            showupdateview = false
            UserDefaults.standard.set(0, forKey: "index")
            UserDefaults.standard.set("", forKey: "duration")

            
        
        }
        
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
    
    func searchonlybutton() -> some View{
        
        VStack(spacing: 10.0){
            HStack{
                
                Image("icons8-search-24")
                    .resizable()
                .frame(width: 32.0, height: 32.0)

                TextField("Search", text: $text)
                                .padding(7)
                                .background(Color(.white))
                                .padding(.horizontal, 10)
                    
//                                    .onTapGesture {
//                                        self.isEditing = true
//                                    }
                 
//                                        if isEditing {
//                                            Button(
//                                                action: {
//                                                self.isEditing = false
//                                                self.text = ""
//
//                                            })
//                                        }
                Image("icon_up")
                    .resizable()

                    .frame(width: 32.0, height: 32.0)
                    .onTapGesture {
                        self.showbotton.toggle()
                    }
                    
                
                
            }
            .frame(width: UIScreen.main.bounds.width - 40,height: 60)
            .padding(.horizontal, 10.0)
            .background(Color.white)
            .cornerRadius(25)
            .padding(.top, -10.0)

            HStack(spacing: 5.0){
                
            
                Image("location")
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
                Text(addrs)
                    .font(.custom("Inter-Bold", size: 16))
                    .foregroundColor(Color("themecolor"))
                Button(" Change "){
                   
                        }.font(.custom("Inter-Bold", size: 20))
                .foregroundColor(Color.white)
                .frame(height: 40)
                .background(Color("themecolor"))
                .cornerRadius(10)
                
                Button(" Clear "){
                   
                        }.font(.custom("Inter-Bold", size: 20))
                .foregroundColor(Color("themecolor"))
                .frame(height: 40)
                .background(Color("darkyellow"))
                .cornerRadius(10)
                
            }.frame(width:UIScreen.main.bounds.width - 40 ,height:50)

            .padding(.all, 5.0)
            
            
            RadioButtonGroup(items: ["All", "My Memories", "Friend's"], selectedId: "All") { selected in
                        print("Selected is: \(selected)")
                selectedradio = selected
                    }.frame(width:UIScreen.main.bounds.width - 40 ,height:50)
            
            .padding(.all, 5.0)

            HStack(spacing: 10.0){
                Spacer()
                VStack(spacing: 0.0){
                    
                    HStack{
                        Text(duration)
                            .font(.custom("Inter-Bold", size: 18))
                            .foregroundColor(Color("bluecolor"))
                            .padding(.all, 5.0)
                            .frame(height: 50.0)
                           
                      Spacer()
                    }
                    .background(RoundedCorners(color: Color("themecolor 1"), tl: 25, tr: 25, bl: 25, br: 25))
                    .frame(height: 50.0)
                   
                   
                  
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
                    
                    .frame(height: 160)

                    
                    
                    
                    
                    
                }.background(Color("lightBlue"))
                .padding(.all, 0.0)
                .frame(height: 210)
                .cornerRadius(25)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)

                VStack(spacing: 0.0){
                    
                    HStack{
                        Text(friendname)
                            .font(.custom("Inter-Bold", size: 18))
                            .foregroundColor(Color("bluecolor"))
                            .padding(.all, 5.0)
                            .frame(height: 50.0)
                           
                      Spacer()
                    }
                    .background(RoundedCorners(color: Color("themecolor 1"), tl: 25, tr: 25, bl: 25, br: 25))
                    .frame(height: 50.0)
                   
                   
                  
                    List {
                        ForEach(obs1.friendlist, id: \.self) { pokemon in

                            Text(pokemon.name)
                                        .frame(height: 30)
                                .onTapGesture {
                                    friendname = pokemon.name
                                    friendid = Int(pokemon.Id)!
                                }
                                }.listRowBackground(Color("lightBlue"))
                                .background(Color("lightBlue"))
                            }
                    
                    .frame(height: 160)
                    .background(Color("lightBlue"))
                    
                    
                    
                    
                    
                }
                    
                
                .padding(.all, 0.0)
                .frame(height: 210)
                .background(Color("lightBlue"))
                .cornerRadius(25)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
                Spacer()

            }
            .frame(height: 210.0)
            .background(Color("lightBlue"))

           
          
            
            Button(" Apply "){
            
                UserDefaults.standard.set(friendid, forKey: "frID")
                UserDefaults.standard.set(duration, forKey: "duration")
                UserDefaults.standard.set(selectedradio, forKey: "sR")
//                    UserDefaults.standard.set(friendname, forKey: "slat")
//                    UserDefaults.standard.set(friendname, forKey: "slon")
                
                UserDefaults.standard.set(text, forKey: "sN")
                for i in 0..<durationarr.count {
                    let str = durationarr[i]
                    
                    if (str == duration ){
                        UserDefaults.standard.set(durationarr1[i], forKey: "duration")
                    }
//                    else{
//                        UserDefaults.standard.set("", forKey: "duration")
//                    }
                }
                

               
                                    obs.eventlist = []
                                    obs.iq = 1
                obs.page = 0
                                      obs.fetchEvent()
                
                    }.font(.custom("Inter-Bold", size: 20))
            .foregroundColor(Color.white)
            .frame(width: UIScreen.main.bounds.width - 50,height: 40)
            .background(Color("themecolor"))
            .cornerRadius(10)
            
            
            
            
            Spacer()
            
        }
        .padding(.top, 10.0)
        .frame(width: UIScreen.main.bounds.width - 30,height: heightview)
        
        .background(Color("lightBlue"))
        .cornerRadius(25)
      //  .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: -(UIScreen.main.bounds.height/2 - 345))
        .shadow(color: .gray, radius: 3, x: 1, y: 1)
        .padding(.top, -(UIScreen.main.bounds.height/2 - 290))

        }
    func searchallbutton() -> some View{
        VStack{
            HStack{
                
                Image("icons8-search-24")
                    .resizable()
                .frame(width: 32.0, height: 32.0)

                TextField("Search", text: $text)
                                .padding(7)
                                .background(Color(.white))
                                .padding(.horizontal, 10)
                    

                
                
                
                
                Button(action: {
                    self.showbotton.toggle()
                }) {
                    Image("icon_down")
                        .foregroundColor(.white)
                        .font(.system(size:15))
                }
                .frame(width: 32.0, height: 32.0)

            }
            
        }
            .frame(width: UIScreen.main.bounds.width - 40,height: 60)
            .padding(.horizontal, 10.0)
            .background(Color.white)
       
            .cornerRadius(25)
       
            //.offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: -(UIScreen.main.bounds.height/2 - 125))
       
        .shadow(color: .gray, radius: 3, x: 1, y: 1)
        .padding(.top, -(UIScreen.main.bounds.height/2 - 105))

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

                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "clickclose1"), object: nil, queue: OperationQueue.main) {
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
//            HStack{
//                Text("Date")
//                    .font(.custom("Inter-Bold", size: 24))
//                    .foregroundColor(Color.white)
//                    .padding(.leading, 10.0)
//                Spacer()
//                Text("Name")
//                    .font(.custom("Inter-Bold", size: 24))
//                    .foregroundColor(Color.white)
//
//                Spacer()
//
//                Text("Location")
//                    .font(.custom("Inter-Bold", size: 24))
//                    .foregroundColor(Color.white)
//                    .padding(.trailing, 10.0)
//
//
//            }
//            .padding(.horizontal, 15.0)
//            .frame(height: 70)
//            .background(Color("bluecolor"))


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

struct SearchResult_Previews: PreviewProvider {
    static var previews: some View {
       
       
        SearchResult(text: "", selectedTab: "")
    }
}
//struct FreshCellView4 : View
//{
////    @Environment(\.managedObjectContext) var moc
////    @FetchRequest(entity: CartDetails.entity(), sortDescriptors: [])
//////    var cartdata: FetchedResults<CartDetails>
////    @State  var productitem: relatedProductlist? = nil
////    @State var imgname : String = "Add"
////    @State  var productpriceitem: relatedprice? = nil
//    @State  var productitem: searcheventmodalclassss? = nil
//    @State  var product: imagesModal?  = nil//= self.productitem?.imageArray
//    @State var showupdateview = false
//    @State var showNextView = false
//    @State var showNextView1 = false
//    @State var evntID = String()
//
//    @State var sharedUrl = String()
//    func share() {
//
//
//        let str1  = "EventDiary/ExportToPDFByEventtId/?id="+evntID
//        AccountAPI.getsignin(servciename: str1, nil) { res in
//        switch res {
//        case .success:
//            print("resulllll",res)
//
//            if let json = res.value{
//               // self.friendlist = []
//                print("Josn",json)
//
//                if(json["status"].string == "true"){
//                sharedUrl = json["data"].string!
//                    self.actionSheet()
//
//                }else{
//                    Toast(text:json["message"].string).show()
//
//                }
//            }
//
//
//        case let .failure(error):
//          print(error)
//        }
//      }
//    }
//    func actionSheet() {
//        guard let data = URL(string: sharedUrl) else { return }
//            let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
//            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
//        }
//
//    var body : some View{
//
//        ZStack{
//            VStack{
//                HStack{
//                    AsyncImage(
//                        url: NSURL(string: productitem!.profilePictureURL)! as URL ,
//                                       placeholder: { Image("icons8-male-user-72").foregroundColor(colorGrey1)
//                                        .aspectRatio(contentMode: .fit)
//                                       },
//                                                   image: { Image(uiImage: $0).resizable()
//
//                                                        }
//                                   )
//                   // Image("icons8-male-user-72")
//
//                    .frame(width: 70, height: 70)
//                    .cornerRadius(35)
//                    .aspectRatio(contentMode: .fit)
//                    .onTapGesture {
//
//                        UserDefaults.standard.set(productitem?.userId, forKey: "fid")
//                        showNextView = true
//                    }
//                    .fullScreenCover(isPresented: $showNextView, content: {
//                        friendsProfile()
//
//                            })
//                    VStack(alignment: .leading, spacing: 5.0){
//
//                        Text(productitem!.username)                    .font(.custom("Inter-Bold", size: 20))
//
//                            .onTapGesture {
//
//                                UserDefaults.standard.set(productitem?.userId, forKey: "fid")
//                                showNextView1 = true
//                            }
//                            .fullScreenCover(isPresented: $showNextView1, content: {
//                                friendsProfile()
//
//                                    })
//                        HStack{
//                        Image("loccc")
//                            .resizable()
//
//                            .padding(.trailing, 10.0)
//                            .frame(width: 32, height: 32)
//
//                            .aspectRatio(contentMode: .fit)
//                            Text(productitem!.Addrs)
//                                .font(.custom("Inter-Regular", size: 16))
//                                .frame(height: 32)
//                            Spacer()
//                        }
//                    }
//                    Spacer()
//                    Image("share")
//                        .resizable()
//
//                        .padding(.trailing, 10.0)
//                        .frame(width: 32, height: 32)
//                        .cornerRadius(16)
//
//                        .aspectRatio(contentMode: .fit)
//                        .onTapGesture {
//                            self.evntID = productitem!.eventId
//                            self.share()
//                        }
//                }
//                .frame(width : 320 , height: 90)
//
//                ZStack{
//
//                   //
//                    HStack{
//
//                    VStack(alignment: .leading, spacing: 5.0){
//                        Text(productitem?.date ?? "")
//                                .font(.custom("Inter-Bold", size: 16))
//                                .foregroundColor(Color.white)
//                        Text(productitem?.diaryDescription ?? "")
//                                .font(.custom("Inter-Regular", size: 16))
//                                .foregroundColor(Color("darkyellow"))
//                        Text(productitem!.diaryName)
//                                    .font(.custom("Inter-Bold", size: 25))
//                                .foregroundColor(Color("lightBlue"))
//
//
//
//                        HStack(spacing: 10.0){
//                            HStack{
//                            //Spacer()
//                            Image("img_y")
//                                 .resizable()
//                                .frame(width: 32, height: 32)
//                                 .aspectRatio(contentMode: .fit)
//
//                               Text(productitem!.picCount)
//                                .font(.custom("Inter-Regular", size: 16))
//                                .foregroundColor(Color.white)
//
//                            Spacer()
//                            Image("vid_y")
//                                 .resizable()
//                                .frame(width: 32, height: 32)
//                                 .aspectRatio(contentMode: .fit)
//
//                               Text(productitem!.vedioCount)
//                                .font(.custom("Inter-Regular", size: 16))
//                                .foregroundColor(Color.white)
//                           //
//                                Spacer()
//
//                            }
//                            HStack{
//                            Image("rec_y")
//                                 .resizable()
//                                .frame(width: 32, height: 32)
//                                 .aspectRatio(contentMode: .fit)
//
//                            Text(productitem!.audioCount)
//                                .font(.custom("Inter-Regular", size: 16))
//                                .foregroundColor(Color.white)
//                           //
//                            //
//                                Spacer()
//                            Image("note_y")
//                                 .resizable()
//                                .frame(width: 32, height: 32)
//                                 .aspectRatio(contentMode: .fit)
//
//                            Text(String((productitem?.Notes.count)!))
//                                .font(.custom("Inter-Regular", size: 16))
//                                .foregroundColor(Color.white)
//                            //
//                                Spacer()
//                            }
//                        }
//
//
//
//                        }
//                        .padding(.leading, 20.0)
//
//                      //
//                        Spacer()
//                  //
//
//                    }
//                    //
//                    .frame(width : UIScreen.main.bounds.width - 25 , height: 120)
//                    .background(Color.black.opacity(0.8))
//                    .offset(x : -15, y : 50)
//
//                }
//                .offset( y : 15)
//                .frame(width : UIScreen.main.bounds.width - 25 , height: 290)
//
//                 .onTapGesture {
//                     UserDefaults.standard.set("Edit", forKey: "eventNOE")
//                     UserDefaults.standard.set(productitem?.eventId, forKey: "eventID")
//                    showupdateview = true
//                 }
//                 .fullScreenCover(isPresented: $showupdateview, content: UpdatepartyDetails.init)
//
//
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
//                    .onTapGesture {
//                        UserDefaults.standard.set("Edit", forKey: "eventNOE")
//                        UserDefaults.standard.set(productitem?.eventId, forKey: "eventID")
//                        showupdateview = true
//                    }
//                    .fullScreenCover(isPresented: $showupdateview, content: UpdatepartyDetails.init)
//
//
//
//
//    )
//            }
//            .frame(width : UIScreen.main.bounds.width - 25 , height: 440.0)
//            .background(RoundedCorners(color: Color("lightBlue"), tl: 30, tr: 30, bl: 30, br: 30))
//
//        }
//        .padding(.leading, 30.0)
//
//    }
//
//}
//{
////    @Environment(\.managedObjectContext) var moc
////    @FetchRequest(entity: CartDetails.entity(), sortDescriptors: [])
//////    var cartdata: FetchedResults<CartDetails>
////    @State  var productitem: relatedProductlist? = nil
////    @State var imgname : String = "Add"
////    @State  var productpriceitem: relatedprice? = nil
//    @State  var productitem: searcheventmodalclassss? = nil
//    @State  var product: imagesModal?  = nil//= self.productitem?.imageArray
//    @State var showupdateview = false
//    @State var showNextView = false
//    @State var showNextView1 = false
//    @State var evntID = String()
//
//    @State var sharedUrl = String()
//    func share() {
//
//
//        let str1  = "EventDiary/ExportToPDFByEventtId/?id="+evntID
//        AccountAPI.getsignin(servciename: str1, nil) { res in
//        switch res {
//        case .success:
//            print("resulllll",res)
//
//            if let json = res.value{
//               // self.friendlist = []
//                print("Josn",json)
//
//                if(json["status"].string == "true"){
//                sharedUrl = json["data"].string!
//                    self.actionSheet()
//
//                }else{
//                    Toast(text:json["message"].string).show()
//
//                }
//            }
//
//
//        case let .failure(error):
//          print(error)
//        }
//      }
//    }
//    func actionSheet() {
//        guard let data = URL(string: sharedUrl) else { return }
//            let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
//            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
//        }
//
//    var body : some View{
//
//        ZStack{
//            VStack{
//                      AsyncImage(
//                            url: NSURL(string: productitem?.imgStr ?? "")! as URL ,
//                                           placeholder: { Image("").foregroundColor(colorGrey1)
//                                            .aspectRatio(contentMode: .fit)
//                                           },
//                                                       image: { Image(uiImage: $0).resizable()
//
//                                                            }
//                                       )
//
//                      .frame(width : 150.0 , height:150.0)
//                    //  .aspectRatio(contentMode: .fill)
//                      //  .cornerRadius(20)
//                       // .offset(x : -15,y : -15)
//
//
//                    }
//            .frame(width : 150.0 , height:150.0)
////.background(Color("bluecolor"))
//
////                    .onTapGesture {
////                        UserDefaults.standard.set("Edit", forKey: "eventNOE")
////                        UserDefaults.standard.set(productitem?.eventId, forKey: "eventID")
////                        showupdateview = true
////                    }
////                    .fullScreenCover(isPresented: $showupdateview, content: UpdatepartyDetails.init)
////
////
////
////
////    )
//            }
//           // .background(RoundedCorners(color: Color("lightBlue"), tl: 10, tr: 10, bl: 10, br: 10))
//
////        }
////        .padding(.leading, 30.0)
//
//    }
//
//}
import Foundation
import Combine


class searchinfoObserver: ObservableObject {
   
    @Published   var eventlist = [searcheventmodalclassss]()
    @Published   var filelist = [FilesModal]()
    @Published   var mp3list = [FilesModal]()
    @Published   var piclist = [FilesModal]()
    @Published   var vidlist = [FilesModal]()
    @Published   var imglist = [String]()
    @Published   var imgl = String()

    @Published   var notlist = [NotesModal]()

    @Published   var showlist = false
    @Published   var showpiclist = false
    @Published   var showaudiolist = false
    @Published   var showvidlist = false
//    var membersListFull = false
//    // Tracks last page loaded. Used to load next page (current + 1)
//    var currentPage = 0
//    // Limit of records per page. (Only if backend supports, it usually does)
//    let perPage = 9
//
    @Published   var showview = false
    @Published   var show = false

//
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
    func loadMoreContent(currentItem item: searcheventmodalclassss){
            let thresholdIndex = self.eventlist.index(self.eventlist.endIndex, offsetBy: -1)
        print(thresholdIndex)
            if thresholdIndex == item.Id, (page + 1) <= totalPages {
                page += 1
                print(item.Id)
              //  print(thresholdIndex)
                fetchEvent()
            }
        }
    
    
  func  fetchEvent() {
    selector = 0
    Latit = 0.0
    Longit = 0.0
    var logInFormData: Parameters {
        [
            
            
            
          
            "userId":    UserDefaults.standard.string(forKey: "id") ?? "" ,
            "page": String(page),
           
              "latitude": 0,
              "longitude": 0,
              "type": UserDefaults.standard.string(forKey: "sR") ?? "",
              "duration": UserDefaults.standard.string(forKey: "duration") ?? "",
              "friendId":UserDefaults.standard.integer(forKey: "frID"),
            "name" : UserDefaults.standard.string(forKey: "sN") ?? "",
              ]
    }
   
        print(logInFormData)

        
    AccountAPI.signin(servciename: "EventListingWithSearch/SearchEventDiariesByFilter", logInFormData) { [self] res in
        switch res {
        case .success:
            print("resulllll",res)
            if let json = res.value{

                print("Josn",json)
        let userdic = json["data"]
               // self.eventlist = []
                for j in userdic {
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
                        imgl = ""
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

                    let scc = searcheventmodalclassss(iq,j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, datestr, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.piclist.count),self.imglist as [String],j.1["address"].stringValue,j.1["userName"].stringValue, j.1["profilePictureURL"].stringValue,j.1["dob"].stringValue,"201301",self.imgl)
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
//                        let scc = searcheventmodalclassss(j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, datestr, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.vidlist.count),self.imglist as [String],currentAddress,j.1["userName"].stringValue, j.1["profilePictureURL"].stringValue,j.1["dob"].stringValue, postalAddress)
//                    self.eventlist.append(scc)
//                }
//                    else{
//                        let scc = searcheventmodalclassss(j.1["eventId"].stringValue, j.1["userId"].stringValue, j.1["longitude"].stringValue, j.1["latitude"].stringValue, j.1["diaryName"].stringValue, j.1["diaryDescription"].stringValue, datestr, self.filelist as NSArray, self.notlist as NSArray,String(self.mp3list.count),String(self.vidlist.count),String(self.vidlist.count),self.imglist as [String],"",j.1["userName"].stringValue,j.1["profilePictureURL"].stringValue,j.1["dob"].stringValue,"")
//                    self.eventlist.append(scc)
//                    }
//
//                }
                
                   
                    print("kdckmdckdmkck",self.eventlist)
                }
                if (self.eventlist.count > 0){
                    self.selector = 0
                    self.Latit = Double(self.eventlist[0].latitude) ?? 0.0
                    self.Longit =  Double(self.eventlist[0].longitude) ?? 0.0
                   //
                    self.show = true

                    }

                print(self.eventlist)
               //
                self.showview  = true
               
            }
        case let .failure(error):
          print(error)
        }
      }
    }
}
struct searcheventmodalclassss : Hashable{
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

struct MapView1: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D
    var locitem = [searcheventmodalclassss]()
    var locationManager = CLLocationManager()
    let marker1 : GMSMarker = GMSMarker()
//    let latit : Double
//    let longit : Double
    @State  var mapDelegateWrapper = GMSMapViewDelegateWrapper4()
    private static var bounds = GMSCoordinateBounds()

    @State var mapDelegate = GMSMapViewDelegateWrapper4()
    @State var markerint : Int
    @State var camera = GMSCameraPosition()
    @State var mapView = GMSMapView()
   // @StateObject var locationManager = LocationManager()
    private static var defaultCamera = GMSCameraPosition.camera(withLatitude: -37.8136, longitude: 144.9631, zoom: 11.0)
    @Binding var isClicked: Bool

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
        MapView1.defaultCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: lat,longitude: lon), zoom: 11.0)
        
       
        self.mapDelegate = mapDelegateWrapper

        self.mapView.delegate = mapDelegateWrapper
        
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: MapView1.defaultCamera)
        self.mapView.animate(to:  MapView1.defaultCamera)

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
           // marker1.snippet = city.eventId + " " + city.date + " at " +  city.diaryName
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
        
               
                MapView1.defaultCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: Double(city.latitude)!,longitude: Double(city.longitude)!), zoom: 15.0)
                //self.mapView.animate(to: MapView1.defaultCamera)
                marker1.icon = UIImage(named: "loctio")
                self.mapView.selectedMarker = marker1

            }else{
                marker1.icon = UIImage(named: "loccc-2")

            }
//            let tap = UITapGestureRecognizer(target: self, action: Selector(("handleTap:")))
//            tap.numberOfTouchesRequired = 2
//            tap.delegate = self
//            marker1.addGesture(tap)
            MapView1.bounds = MapView1.bounds.includingCoordinate(marker1.position)
        }
   //
        let update = GMSCameraUpdate.fit(MapView1.bounds, withPadding: 50)
   //
        self.mapView.animate(with: update)
   //
    
  //  self.mapView.animate(with: GMSCameraUpdate.fit(MapView1.bounds, with: UIEdgeInsets(top: 50.0 , left: 50.0 ,bottom: 50.0 ,right: 50.0)))

    }
}
struct ColorInvert: ViewModifier {

    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        Group {
            if colorScheme == .dark {
                content.colorInvert()
            } else {
                
                content
            }
        }
    }
}
class GMSMapViewDelegateWrapper4: NSObject, GMSMapViewDelegate {
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
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf didTapInfoWindowOfMarker: GMSMarker) {
            print("You tapped a marker's infowindow!")
    //        This is where i need to get the view to appear as a modal, and my attempt below
//            let venueD2 = UIHostingController(rootView: VenueDetail2())
//            venueD2.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 48)
//            self.view.addSubview(venueD2.view)
     //
        self.isClicked.toggle()

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "clickclose"), object: self)
        
        
        
            return
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
//
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
    private func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) -> Bool {
        return false
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("hello TAP")
        print("hello TAP")
        print(marker.snippet!)
        var str = String()
        str = marker.snippet!
        
        let fullNameArr = str.split(separator: " ") //marker.title!.componentsSeparatedByString(" ")
        UserDefaults.standard.set(fullNameArr[0], forKey: "eID")
       // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "clickclose1"), object: self)
        self.isClicked.toggle()

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "clickclose"), object: self)
        
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
    
    
}


struct RadioButton: View {

    @Environment(\.colorScheme) var colorScheme

    let id: String
    let callback: (String)->()
    let selectedID : String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat

    init(
        _ id: String,
        callback: @escaping (String)->(),
        selectedID: String,
        size: CGFloat = 20,
        color: Color = Color.primary,
        textSize: CGFloat = 14
        ) {
        self.id = id
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedID = selectedID
        self.callback = callback
    }

    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.selectedID == self.id ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .modifier(ColorInvert())
                Text(id)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(self.color)
    }
}

struct RadioButtonGroup: View {

    let items : [String]

    @State var selectedId: String = ""

    let callback: (String) -> ()

    var body: some View {
        HStack(spacing: 5.0) {
            ForEach(0..<items.count) { index in
                RadioButton(self.items[index], callback: self.radioGroupCallback, selectedID: self.selectedId)
            }
        }
        .padding(.leading, 10.0)
    }

    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}
enum ViewVisibility: CaseIterable {
  case visible, // view is fully visible
       invisible, // view is hidden but takes up space
       gone // view is fully removed from the view hierarchy
}
extension View {
  @ViewBuilder func visibility(_ visibility: ViewVisibility) -> some View {
    if visibility != .gone {
      if visibility == .visible {
        self
      } else {
        hidden()
      }
    }
  }
}
