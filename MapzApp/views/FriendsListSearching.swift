//
//  FriendsListSearching.swift
//  MapzApp
//
//  Created by Misha Infotech on 25/11/2022.

import SwiftUI
import Alamofire

    struct FriendsListSearching: View {
    @ObservedObject var obs = friendObserver1()
    @Environment(\.presentationMode) var presentationMode
    @State private var showdocPopUp = false
    @State private var Note = String()
    @State private var showupdateview = false
  //  @State private var searchText = ""
    @State var searchText =  String()
        @State var groupID =  String()

    var onCommit: () ->Void = {
           print("onCommit")
           
       }
    @State private var showCancelButton: Bool = false
        @State var heightplus : CGFloat = 35

    var body: some View {
                ZStack{
                    VStack(spacing : 10.0){

                        Spacer()
                              .frame(height :heightplus)
                       
                        HStack(alignment: .center) {
                           // Spacer(minLength: 12)
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
                    
                    
                        VStack(spacing: 20.0){
                            
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
                            //       }
                            
                            
                            
                            HStack{
                                
                            }
                            .frame(width: UIScreen.main.bounds.width-30, height: 1.0)
                            .border(Color.black, width: 1)
                            .padding(.bottom, 3.0)
                            
                        }
                        
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
                                            .aspectRatio(contentMode: .fill)
                                        
                                    },
                                    image: { Image(uiImage: $0).resizable()
                                        
                                    }
                                )
                                .frame(width: 60, height: 60)
                                .cornerRadius(30)
                                .aspectRatio(contentMode: .fit)
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 2) // You can customize the color and lineWidth
                                )
                                .clipShape(Circle())
                             
                                
                                HStack(spacing: 20.0){
                                    VStack{
                                        Text(pokemon.name)
                                            .font(.custom("Inter-Bold", size: 16))
                                        
                                    }
                                    .onTapGesture {
                                        
                                        UserDefaults.standard.set(pokemon.Id, forKey: "fid")
                                        UserDefaults.standard.set(pokemon.name, forKey: "fname")
                                        
                                        UserDefaults.standard.set(pokemon.ProfilePic, forKey: "fpic")
                                        
                                        showupdateview.toggle()
                                    }
                                    .fullScreenCover(isPresented: $showupdateview, content: {
                                        //friendsProfile(selectedTab: "")
                                        friendsProfileView( selectedTab: "" ,grpD: "")
                                    })
                                    
                                    Spacer()
                                    
                                    HStack{
                                        Image("cross")
                                            .padding(.trailing, 5.0)
                                    }
                                }
                            }
                 
                    .padding(6.0)
                    //.padding(.vertical, 4.0)
                    .background(Color.white)
                    .cornerRadius(15.0)

                    //.shadow(color: .gray, radius: 5, x: 1, y: 1)
                }
                        }   }else{
                        blankView(imageNAme: "no_found_friend",ErrorMsg : "No Friends Found")
                            .offset(y : UIScreen.main.bounds.height/2-120)
                        Spacer()
                    
                    }
                    
                    }.frame(width: UIScreen.main.bounds.width-15)
                            .padding(10.0)
                    
                    }.edgesIgnoringSafeArea(.all)
                        .onAppear(){
                            if UIDevice.current.hasNotch {
                                heightplus = 35
                            } else {
                                //... don't have to consider notch
                                heightplus = 20
                            }
                        }
                    
//                    Button(action: {
//                        showdocPopUp = true
//                    }) {
//                       Image("icons8-plus-+-24 (1)")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//
//                    }
//                    .background(Color("themecolor"))
//                        .frame(width: 70, height: 70)
//                        .cornerRadius(35)
//                    .offset(x :UIScreen.main.bounds.width/2 - 60, y : UIScreen.main.bounds.height/2 - 60)
                    
                    Button(action: {
                        showdocPopUp = true
                    }, label: {
                        Text("Send Invite")
                            .font(.custom("Inter-Bold", size: 18))
                    })
                    .frame(width: UIScreen.main.bounds.width-30, height: 60)
                    .background((Color("themecolor")))
                    .foregroundColor(.white)
                    .cornerRadius(36)
                    .offset( y : UIScreen.main.bounds.height/2 - 60)
             


                    if $showdocPopUp.wrappedValue {
                        ZStack {
                          
                            Color.white
                            VStack(alignment: .center, spacing: 20.0) {
                                Spacer(minLength: 10)
                                Button(action: {
                                    showdocPopUp = false
                                }) {
                                   Image("icons8-macos-close-24 (1)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)

                                    }
                                    .frame(width: 24, height: 24)
                                .offset(x :UIScreen.main.bounds.width/2 - 60 )

                                TextField("Enter E-mail", text: $Note)
                                    .padding(.horizontal, 10.0)
                                    .font(.custom("Inter-Regular", size: 17))
                                    .frame(width: UIScreen.main.bounds.width-100, height: 60)
                                    .border(Color.gray, width: 0.5)

                                Button(action: {
                                     self.showdocPopUp = false
                                    self.sendInvite()

                                }, label: {
                                    Text("Send Invite")
                                        .font(.custom("Inter-Bold", size: 18))
                                })
                                .frame(width: UIScreen.main.bounds.width-100, height: 60)
                                .background((Color("themecolor")))
                                .foregroundColor(.white)
                                .cornerRadius(36)
                                
                                                       Spacer()
                            }.padding()

                        }
                        .frame(width: UIScreen.main.bounds.width-60, height: 240)
                        .cornerRadius(20)
                        .shadow(color: .gray, radius: 5, x: 1, y: 1)
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


struct SearchBarView: View {
    
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    var onCommit: () ->Void = {print("onCommit")}
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                // Search text field
                ZStack (alignment: .leading) {
                    if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                        Text("Search")
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
            .background(Color(.tertiarySystemFill))
            .cornerRadius(10.0)
            
            if showCancelButton  {
                // Cancel button
                Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
    }
}

struct FriendsListSearching_Previews: PreviewProvider {
    static var previews: some View {
        FriendsListSearching()
    }
}
struct friendlistModal1 :Hashable {
    var  Id : String

    var  name : String
    var    ProfilePic : String
   
    var  dob : String

    init(_ Id :String,_ name:String,_ ProfilePic:String,_ dob:String){
        self.Id  = Id

       self.name  = name
       self.ProfilePic = ProfilePic
        self.dob = dob

      
    }
    
}
class friendObserver1: ObservableObject {
   
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
                
                    let  acc  = friendlistModal(i.1["id"].stringValue,i.1["firstName"].stringValue,("https://mapzapp.swadhasoftwares.com/Uploads/ProfilePicture/" + i.1["profilePictureURL"].stringValue),datestr)
                   
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

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
