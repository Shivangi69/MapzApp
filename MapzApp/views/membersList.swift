 //
//  membersList.swift
//  MapzApp
//
//  Created by Admin on 30/01/23.
//

import SwiftUI
import Alamofire

struct membersList: View {
    @State var heightplus : CGFloat = 35
    @ObservedObject var obs = groupadduserObserver()
    @State   var selectedarr = [Int]()// NSMutableArray()//
    @State   var podcastID =  NSMutableArray()//

    @State   var selectedarrtoggle = [Int]()// NSMutableArray()//
    @State var searchText =  String()
    @State  var showingAlert = false
    @State  var showingAlert1 = false

    @State  var message = String()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Spacer()
                    .frame(height :heightplus)
                VStack(alignment: .trailing){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroupDG"), object: self)
                        
                    })
                    {
                        Spacer()
                        
                        Image("cross")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                    }
                }
                
                    HStack {
                     
                        TextField("Add a member", text: $searchText,
                                  onCommit: {
                                    print("Search = \(searchText)")
                                    }
                        )
                            .onChange(of: searchText, perform: { value in
                                print(value)
   
                                }
                            
                            )
                            .foregroundColor(Color.black)
                            .font(.custom("Inter-Regular", size: 20))
                     
                        Spacer()
                        
                        Image(systemName: "magnifyingglass")
                        
                        
                    }
                    .frame(width : UIScreen.main.bounds.width - 20)
                    .padding(EdgeInsets(top: 8, leading: 5, bottom: 8, trailing: 5))
                    .foregroundColor(.secondary) // For magnifying glass and placeholder test
                    .background(Color(.white))
                    .overlay(RoundedRectangle(cornerRadius: (5)).stroke(lineWidth: 1.0))
                    
                if (obs.filteredeventlist.count > 0){
                    ScrollView{
                   // ForEach(obs.eventlist, id: \.self) { pokemon in
                        //  List{
                       // ForEach(Array(obs.filteredeventlist.enumerated()).filter{$0.name.contains(searchText) || searchText == ""}, id: \.offset) { index, pokemon in
                        ForEach(Array(((obs.filteredeventlist).filter{$0.name.contains(searchText) || searchText == ""}).enumerated()), id: \.offset) { index, pokemon in

                        HStack(alignment: .center, spacing: 10.0){
                            
                            ZStack{
                                AsyncImage(
                                    url: NSURL(string: pokemon.profilePictureURL)! as URL ,
                                    placeholder: { Image("icons8-male-user-72").foregroundColor(colorGrey1)
                                            .aspectRatio(contentMode: .fit)
                                    },
                                    image: { Image(uiImage: $0).resizable()
                                        
                                    }
                                )
                                .frame(width: 50, height: 50)
                                .cornerRadius(25)
                                .aspectRatio(contentMode: .fit)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .strokeBorder(Color("themecolor-1"), lineWidth: 1, antialiased: true)
                                )
                              
                                Image((self.selectedarr.contains(index) ? "icons8-ok-60" : ""))
                                    .resizable()
                                    .frame(width: 24.0, height: 24.0)
                                    .scaledToFill()
                                    .background((self.selectedarr.contains(index) ? Color.white : Color.clear))
                                    
                                    .cornerRadius(12)
                                    .offset(x : -12
                                            ,y : -12)
                            }
                            Text(pokemon.name)
                                .font(.custom("Inter-Bold", size: 20))
                            
//                                HStack(spacing: 20.0){
//                                    HStack{
//                                        Text(pokemon.name)
//                                            .font(.custom("Inter-Bold", size: 20))
//                                    }
//                                    .onTapGesture {
//
//                                        //                                UserDefaults.standard.set(pokemon.Id, forKey: "fid")
//                                        //                                UserDefaults.standard.set(pokemon.name, forKey: "fname")
//                                        //
//                                        //                                UserDefaults.standard.set(pokemon.ProfilePic, forKey: "fpic")
//                                        //
//                                        //                                showupdateview.toggle()
//                                    }
//                                    //                            .fullScreenCover(isPresented: $showupdateview, content: {
//                                    //                                friendsProfile(selectedTab: "")
//                                    //
//                                    //                                    })
//                                    //
//
//
                            Spacer()
//
//
                            if(self.selectedarr.contains(index)){
                                
                                Image((self.selectedarrtoggle.contains(index) ? "switch_S" : "switch_U"))
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                // .scaledToFill()
                                // .background((self.selectedarr.contains(index) ? Color.white : Color.clear))
                                
                                    .onTapGesture(){
                                        if(self.selectedarr.contains(index)){
                                            if(self.selectedarrtoggle.contains(index)){
                                                //self.selectedarr.re
                                                //  self.selectedarr.re(index)
                                                print(self.selectedarrtoggle)
                                                
                                                //
                                                for i in 0..<selectedarrtoggle.count {
                                                    if (selectedarrtoggle[i] == index){
                                                        self.selectedarrtoggle.remove(at: i)
                                                        
                                                        
                                                        
                                                        break
                                                    }
                                                    print(i)
                                                }
                                            }else{
                                                self.selectedarrtoggle.append(index)
                                                //  self.selectedarr.add(index)
                                                print(self.selectedarrtoggle)
                                                
                                            }
                                            //  self.getfile()
                                        }
                                        
                                    }
                                
                            }
//
//                                }
                            
                        }
                        .frame(width : UIScreen.main.bounds.width-20)
                       .padding(.horizontal , 10.0)
                        .background(Color.white)
                        .cornerRadius(15.0)
                        .onTapGesture(){
                            
                            if(self.selectedarr.contains(index)){
                                //self.selectedarr.re
                              //  self.selectedarr.re(index)
                                print(self.selectedarr)

//
                                for i in 0..<selectedarr.count {
                                    if (selectedarr[i] == index){
                                       
                                        
                                        for j in 0..<selectedarrtoggle.count {
                                            if (selectedarrtoggle[j] == index){
                                                self.selectedarrtoggle.remove(at: j)
                                                
                                            }
                                        }
                                        self.selectedarr.remove(at: i)
                                        break
                                    }
                                print(i)
                            }
                            }
                            else{
                                self.selectedarr.append(index)
                              //  self.selectedarr.add(index)
                                print(self.selectedarr)

                            }
                          //  self.getfile()
                        }
                        
                        //.shadow(color: .gray, radius: 5, x: 1, y: 1)
                    }
                    
                }.frame(width : UIScreen.main.bounds.width)
                        .background(Color.white)
                    
                    
                    
                }else{
                    blankView(imageNAme: "no_found_friend",ErrorMsg : "No Users Found")
                        .offset(y : UIScreen.main.bounds.height/2-120)
                    Spacer()
                
                }
                Spacer()
                
                
                Button("Add"){
                  //  obs.ForgotPwd()

                    if selectedarr.count == 0 {
                        message = "Please Select at least one User!"

                        showingAlert.toggle()

                        return
                    }
                    CreateGroup()

                }
                .font(.custom("Inter-Bold", size: 20))
                .foregroundColor(.white)
                .font(.custom("Inter-Medium", size: 20))
                .frame(width:
                        UIScreen.main.bounds.width-30, height: 60.0)
                
                .background(Color ("themecolor"))
                .cornerRadius(36)

                
                Spacer()
                    .frame(height :heightplus)
            }.edgesIgnoringSafeArea(.all)
        } .onAppear(){

            obs.fetch()
            if UIDevice.current.hasNotch {
                heightplus = 35
            } else {
                //... don't have to consider notch
                heightplus = 20
            }
        }
    }
    func CreateGroup(){
       
        podcastID = []
        for item in selectedarr {
            print(item)
            let art = obs.filteredeventlist[item]
          
            
            var permission = Bool()
            if selectedarrtoggle.contains(item){
                permission = true
            }else{
                permission = false
            }
            var dic = NSDictionary()
            dic = [
                "user_id": art.userID,
                      "permission": permission
           ]
            podcastID.add(dic)
            
            
        }
        
        var logInFormData: Parameters {
            [
                "groupId": UserDefaults.standard.double(forKey: "groupId"),
                "groupmember" : podcastID
                
                  ]
        
        }
                //
        print(logInFormData)

            
                    AccountAPI.signin(servciename: "Group/AddMemberInGroup", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                           
                           
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                                
                                Toast.init(text: json["message"].stringValue).show()
                               // UserDefaults.standard.set("true", forKey: "group")

                                presentationMode.wrappedValue.dismiss()
                                
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroupDG"), object: self)

                            }
                            else{
                                Toast.init(text: json["message"].stringValue).show()

                            }
                        
                            
                        }
                    case let .failure(error):
                      print(error)
                    }
                  }
                
       
    }
}

struct membersList_Previews: PreviewProvider {
    static var previews: some View {
        membersList()
    }
}      
class groupadduserObserver: ObservableObject {
   
    @Published   var eventlist = [ShareSearchResultModel]()
    @Published   var showlist = false
    @Published   var addrsStr = String()
    @Published   var searchText = String()
    @Published   var filteredeventlist = [ShareSearchResultModel]()


   func fetch() {
     //   "http://167.86.105.98:7723/api/Users/SearchUser?Id=1084

        let str = UserDefaults.standard.string(forKey: "id") ?? ""
        let str1  = "Users/SearchUser?Id=" + str
        AccountAPI.getsignin(servciename: str1, nil) { res in
        switch res {
        case .success:
            print("resulllll",res)
            
            if let json = res.value{
                self.eventlist = []
                self.filteredeventlist = []

                print("Josn",json)
      //  let userdic = json["data"]
                
                let events = json["data"]
                for i in events {

                     
                   let scc = ShareSearchResultModel(userID: i.1["userId"].intValue, name: i.1["name"].stringValue, dob: i.1["dob"].stringValue, profilePictureURL: i.1["profilePictureURL"].stringValue, email: i.1["email"].stringValue, phoneNumber: i.1["phoneNumber"].stringValue, tagLine: i.1["tagLine"].stringValue, diaryCount: i.1["diary_Count"].intValue, friendCount: i.1["friend_Count"].intValue, deviceType: i.1["deviceType"].stringValue, deviceToken: i.1["deviceToken"].stringValue)
                    
                    
                  
                self.eventlist.append(scc)
                    self.filteredeventlist.append(scc)

                   
                }
               
                }
                print(self.filteredeventlist)
            case let .failure(error):
          print(error)
        }
      }
    }
}
   
