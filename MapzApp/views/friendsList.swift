//
//  friendsList.swift
//  MapzApp
//
//  Created by Misha Infotech on 16/08/2021.
//

import SwiftUI
import Alamofire

struct friendsList: View {
    @ObservedObject var obs = friendObserver()
    @Environment(\.presentationMode) var presentationMode
    @State private var showdocPopUp = false
    @State private var Note = String()
    @State private var showupdateview = false
    
    var body: some View {
        ZStack{
            VStack(spacing: 20.0) {
                
                //             HStack(spacing: 20.0) {
                //                 Button(action: {
                //                    presentationMode.wrappedValue.dismiss()
                //                 }) {
                //                    Image("menu")
                //                         .resizable()
                //
                //                         .aspectRatio(contentMode: .fit)
                //
                //
                //                 }
                //
                //
                //                Spacer()
                //
                //                Text("My Friends")
                //                    .foregroundColor(Color.white)
                //                    .font(.custom("Inter-Bold", size: 22))
                //                Spacer()
                //                Image("")
                //                     .resizable()
                //                     .aspectRatio(contentMode: .fit)
                //   }
                //             .padding()
                //             .padding(.top,10)
                //             .frame(height: 50.0)
                //             .background(Color("themecolor"))
                //
                
                
                ZStack{
                    
                    VStack{
                        if (obs.friendlist.count > 0){
                            List(obs.friendlist, id: \.self) { pokemon in
                                //  List{
                                HStack(alignment: .center, spacing: 10.0){
                                    //  Image("icons8-male-user-72")
                                    //  .frame(width: 60.0, height: 60.0)
                                    //  .cornerRadius(30)
                                    
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
                                    
                                    Text(pokemon.name)
                                        .font(.custom("Inter-Bold", size: 20))
                                    
                                }
                                
                                .onTapGesture {
                                    
                                    UserDefaults.standard.set(pokemon.Id, forKey: "fid")
                                    UserDefaults.standard.set(pokemon.name, forKey: "fname")
                                    
                                    UserDefaults.standard.set(pokemon.ProfilePic, forKey: "fpic")
                                    
                                    showupdateview.toggle()
                                }
                                .fullScreenCover(isPresented: $showupdateview, content: {
                                    //   friendsProfile(selectedTab: "")
                                    friendsProfileView( selectedTab: "" ,grpD: "")
                                    
                                })
                                //.padding(.vertical, 4.0)
                                .background(Color.white)
                                .cornerRadius(15.0)
                                
                                //.shadow(color: .gray, radius: 5, x: 1, y: 1)
                            }
                        }
                        else{
                            blankView(imageNAme: "no_found_friend",ErrorMsg : "No friends found!")
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
                    //            }
                    //            .frame(width: UIScreen.main.bounds.width-60, height: 240)
                    //           .cornerRadius(20)
                    //           .shadow(color: .gray, radius: 5, x: 1, y: 1)
                    //       }
                    
                }
            }
        }
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

struct friendsList_Previews: PreviewProvider {
    static var previews: some View {
        friendsList()
    }
}
struct friendlistModal :Hashable {
    var  Id : String

    var  name : String
    var    ProfilePic : String
    
    var  dob : String
    var  email : String

    init(_ Id :String,_ name:String,_ ProfilePic:String,_ dob:String , _ email:String){
        self.Id  = Id
        self.name  = name
        self.ProfilePic = ProfilePic
        self.dob = dob
        self.email = email

        
    }
    
}


class friendObserver: ObservableObject {
    
    @Published   var friendlist = [friendlistModal]()
    
    @Published   var showview = false
    
    init() {
        
        let str = UserDefaults.standard.string(forKey: "id") ?? ""
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
                        let  acc  = friendlistModal(i.1["id"].stringValue,i.1["firstName"].stringValue,("https://mapzapp.swadhasoftwares.com/Uploads/ProfilePicture/" + i.1["profilePictureURL"].stringValue),datestr ,i.1["email"].stringValue)
                        
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
