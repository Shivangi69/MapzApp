//

//
//  friendSFriendlist.swift
//  MapzApp
//
//  Created by Misha Infotech on 25/11/2022.

import SwiftUI
import Alamofire

struct friendSFriendlist: View {
    @ObservedObject var obs = FFfriendObserver1()
    @Environment(\.presentationMode) var presentationMode
    @State private var showdocPopUp = false
    @State private var Note = String()
    @State private var showupdateview = false
    //  @State private var searchText = ""
    @State var searchText =  String()
    var onCommit: () ->Void = {
        print("onCommit")
        
    }
    @State var heightplus : CGFloat = 40

    @State private var showCancelButton: Bool = false
    
    var body: some View {
        ZStack{
            VStack(spacing : 12.0){

                Spacer()
                      .frame(height :heightplus)

              
                HStack(alignment: .center) {
         //  Spacer(minLength: 12)
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        //                    withAnimation {
                        //                        x = 0
                        //                    }
                    }) {
                        Image("back")
                            .resizable()
                            .frame(width: 24.0, height: 24.0)
                        //    .padding(.top,12.0)
          
                        //.cornerRadius(24)
                    }
                  Spacer()
                }
                .padding(.horizontal, 10.0)
              
          
                HStack(spacing : 10.0) {
                    Text("Friends")
                        .foregroundColor(Color.black)
                        .font(.custom("Inter-Bold", size: 18
                         ))
                       
                 Spacer()
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                          
                        // Search text field
                        ZStack (alignment: .leading) {
                            if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                                Text("")
                            }
                            TextField("", text: $searchText, onEditingChanged: { isEditing in
                                self.showCancelButton = true
                            }, onCommit: onCommit).foregroundColor(.primary)
                        }
                        // Clear button
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary) // For magnifying glass and placeholder test
                    .background(Color(.white))
                    .overlay(RoundedRectangle(cornerRadius: (16)).stroke(lineWidth: 1.0))
                    
                    
                }.frame(width: UIScreen.main.bounds.width-30)
                 
                
                VStack{
                    if ((obs.friendlist).count > 0){
                        ScrollView{
                            ForEach((obs.friendlist).filter{$0.name.contains(searchText) || searchText == ""}, id:\.self) { pokemon in
                                
                                //List((obs.friendlist).filter($0.name.contains(searchText)), id: \.self) { pokemon in
                                //  List{
                                HStack(alignment: .center, spacing: 10.0){
                                    //                        Image("icons8-male-user-72")
                                    //                            .frame(width: 60.0, height: 60.0)
                                    //                            .cornerRadius(30)
                                    
                                    AsyncImage(
                                        url: NSURL(string: pokemon.ProfilePic)! as URL ,
                                        placeholder: { Image("icons8-male-user-72").foregroundColor(colorGrey1)
                                                .aspectRatio(contentMode: .fit)
                                        },
                                        image: { Image(uiImage: $0).resizable()
                                            
                                        }
                                    )
                                    
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(30)
                                    .aspectRatio(contentMode: .fit)
                                    
                                    HStack(spacing: 20.0){
                                        HStack{
                                            Text(pokemon.name)
                                           .font(.custom("Inter-Bold", size: 20))
                                        }
                                        .onTapGesture {
                                            
                                            UserDefaults.standard.set(pokemon.Id, forKey: "fid")
                                            UserDefaults.standard.set(pokemon.name, forKey: "fname")
                                            
                                            UserDefaults.standard.set(pokemon.ProfilePic, forKey: "fpic")
                                            
                                            //
                                            showupdateview.toggle()
                                        }
                                        .fullScreenCover(isPresented: $showupdateview, content: {
                                            //friendsProfile(selectedTab: "")
                                            friendsProfileView( selectedTab: "" ,grpD: "")
                                        })
                                        
                                        Spacer()
//
//                                        HStack{
//                                            Image("cross")
//                                                .padding(.trailing, 5.0)
//                                        }
                                      
                                    }
                                    
                                }
                                .padding(10.0)
                                //.padding(.vertical, 4.0)
                                .background(Color.white)
                                .cornerRadius(15.0)
                                
                                //.shadow(color: .gray, radius: 5, x: 1, y: 1)
                            }
                        }
                    }
                    else{
                            blankView(imageNAme: "no_found_friend",ErrorMsg : "No Friends Found")
                                .offset(y : UIScreen.main.bounds.height/2-120)
                            Spacer()
                            
                        }
                    
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-60)
                   
                                
                //                    Button(action: {
                //                        showdocPopUp = true
                //                    }) {
                //                       Image("icons8-plus-+-24 (1)")
                //                            .resizable()
                //
                //                            .aspectRatio(contentMode: .fit)
                //
                //
                //                    }
                //                    .background(Color("themecolor"))
                //                        .frame(width: 70, height: 70)
                //                        .cornerRadius(35)
                //                    .offset(x :UIScreen.main.bounds.width/2 - 60, y : UIScreen.main.bounds.height/2 - 120 )
                //
                
                //                    if $showdocPopUp.wrappedValue {
                //                        ZStack {
                //                           //
                //                            Color.white
                //                            VStack(alignment: .center, spacing: 20.0) {
                //                                Spacer(minLength: 10)
                //                                Button(action: {
                //                                    showdocPopUp = false
                //                                }) {
                //                                   Image("icons8-macos-close-24 (1)")
                //                                        .resizable()
                //
                //                                        .aspectRatio(contentMode: .fit)
                //
                //
                //                                }
                //
                //                                    .frame(width: 24, height: 24)
                //                                .offset(x :UIScreen.main.bounds.width/2 - 60 )
                //
                //
                //
                //                                TextField("Enter E-mail", text: $Note)
                //                                    .padding(.horizontal, 10.0)
                //                                    .font(.custom("Inter-Regular", size: 17))
                //                                    .frame(width: UIScreen.main.bounds.width-100, height: 60)
                //                                    .border(Color.gray, width: 0.5)
                //
                //                                Button(action: {
                //                                     self.showdocPopUp = false
                //                                    self.sendInvite()
                //
                //                                }, label: {
                //                                    Text("Send Invite")
                //                                        .font(.custom("Inter-Bold", size: 18))
                //                                })
                //                                .frame(width: UIScreen.main.bounds.width-100, height: 60)
                //                                .background((Color("bluecolor")))
                //                                .foregroundColor(.white)
                //                                .cornerRadius(10)
                //                               Spacer()
                //                            }.padding()
                //
                //
                //                        }
                //                        .frame(width: UIScreen.main.bounds.width-60, height: 240)
                //                        .cornerRadius(20)
                //                        .shadow(color: .gray, radius: 5, x: 1, y: 1)
                //                    }
            }.edgesIgnoringSafeArea(.all)
                .onAppear(){
                    if UIDevice.current.hasNotch {
                        heightplus = 40
                    } else {
                        //... don't have to consider notch
                        heightplus = 20
                    }
                
                }
        }.edgesIgnoringSafeArea(.all)
        
    }
    
    
    
    func sendInvite() {
        
        var logInFormData: Parameters {
            [
                "fromEmail": UserDefaults.standard.string(forKey: "email") ?? "",
                "toEmail": Note
                
            ]
            
        }
        
        print(logInFormData)
        
        
        AccountAPI.signin(servciename: "FriendInvite/InviteFriendAsync", logInFormData) { res in
            switch res {
            case .success:
                print("resulllll",res)
                if let json = res.value{
                    
                    
                    print("Josn",json)
                    if (json["status"] == "true")
                    {
                        let userdic = json["data"]
                    }
                    else{
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}



struct friendSFriendlist_Previews: PreviewProvider {
    static var previews: some View {
        friendSFriendlist()
    }
}
//struct friendlistModal1 :Hashable {
//    var  Id : String
//
//    var  name : String
//    var    ProfilePic : String
//
//    var  dob : String
//
//    init(_ Id :String,_ name:String,_ ProfilePic:String,_ dob:String){
//        self.Id  = Id
//
//        self.name  = name
//        self.ProfilePic = ProfilePic
//        self.dob = dob
//
//
//    }
//
//}
class FFfriendObserver1: ObservableObject {
    
    @Published   var friendlist = [friendlistModal]()
    
    @Published   var showview = false
    
    init() {
        
        let str = UserDefaults.standard.string(forKey: "fid") ?? ""
        let str1  = "FriendInvite/GetAllFriends/?id="+str
        AccountAPI.getsignin(servciename: str1, nil) { res in
            switch res {
            case .success:
                print("resulllll",res)
                
                if let json = res.value{
                    self.friendlist = []
                    print("Josn",json)
                    
                    
                    let events = json["data"]
                    for i in events {
                        let fullName : String = i.1["dateOfBirth"].stringValue
                        let fullNameArr : [String] = fullName.components(separatedBy: "T")
                        let datestr: String = fullNameArr[0]
                        let email : String = i.1["email"].stringValue
                        
                        let  acc  = friendlistModal(i.1["id"].stringValue,i.1["firstName"].stringValue,("https://mapzapp.swadhasoftwares.com/Uploads/ProfilePicture/" + i.1["profilePictureURL"].stringValue),datestr,i.1["email"].stringValue )
                        
                    self.friendlist.append(acc)
                    }
                    print(self.friendlist)
                    self.showview.toggle()
                }
                
                
            case let .failure(error):
                print(error)
            }
        }
    }
}

