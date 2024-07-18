//
//  GroupMemberlist.swift
//  MapzApp
//
//  Created by Admin on 06/01/23.
//

import SwiftUI
import Alamofire

struct GroupMemberlist: View {
    @ObservedObject var obs = GroupMemberObserver()
    @Environment(\.presentationMode) var presentationMode
    @State private var showdocPopUp = false
    @State private var Note = String()
    @State private var showupdateview = false
    @State var heightplus : CGFloat = 35

    var body: some View {
        ZStack{
            VStack(spacing: 20.0) {
                
                
                VStack{
                    
                    Spacer()
                          .frame(height :heightplus)
                    HStack{
                        VStack(alignment: .leading, spacing : 12.0) {
                            // Spacer(minLength: 12)
                            
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroupD"), object: self)

                            }) {
                                Image("back")
                                    .resizable()
                                    .frame(width: 24.0, height: 24.0)
                              
                            }
                            Text("Members")
                                .foregroundColor(Color.black)
                                .font(.custom("Inter-Bold", size: 20))
                            
                        }
                       Spacer()
                    }
                    .padding(.horizontal, 10.0)
                 
                }
             
                HStack{
                    
                }
                .frame(width: UIScreen.main.bounds.width-20, height: 1.0)
                .border(Color.black, width: 1)
                .padding(.bottom,
                         12.0)
                
                if (obs.showview == true){
                    ScrollView{
                   //
                        ForEach(obs.Memberlist, id: \.self) { pokemon in
                        //  List{
                       // ForEach(Array(obs.Memberlist.enumerated()), id: \.offset) { index, pokemon in

                        HStack(alignment: .center, spacing: 10.0){
                            
                                AsyncImage(
                                    url: NSURL(string: pokemon.memberPhoto)! as URL ,
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
                           
                            Text(pokemon.memberName)
                                .font(.custom("Inter-Bold", size: 20))
                            
                            Spacer()
                           
                        }
                        .frame(width : UIScreen.main.bounds.width-20)
                        .padding(.horizontal , 10.0)
                        .background(Color.white)
                        .cornerRadius(15.0)
                        .onTapGesture
                        {
                            UserDefaults.standard.set(pokemon.memberID, forKey: "fid")
                            UserDefaults.standard.set(pokemon.memberName, forKey: "fname")
                            UserDefaults.standard.set(pokemon.memberPhoto, forKey: "fpic")
                            showupdateview.toggle()
                        }
                        .fullScreenCover(isPresented: $showupdateview, content: {
                            //friendsProfile(selectedTab: "")
                            friendsProfileView( selectedTab: "" ,grpD : String(pokemon.groupID) )
                        })
                    }
                    
                }.frame(width : UIScreen.main.bounds.width)
                        .background(Color.white)
                    
                }else{
                    blankView(imageNAme: "no_found_friend",ErrorMsg : "No Users Found")
                        .offset(y : UIScreen.main.bounds.height/2-120)
                    Spacer()
                
                }
               Spacer()
            }.edgesIgnoringSafeArea(.all)
            .onAppear(){//"duration"
                
                if UIDevice.current.hasNotch {
                    heightplus = 35
                } else {
                    //... don't have to consider notch
                    heightplus = 20
                }
                obs.fetch()
            }
        }
    }
  
}

struct GroupMemberlist_Previews: PreviewProvider {
    static var previews: some View {
        GroupMemberlist()
    }
}

//class GroupMemberObserver: ObservableObject {
//   
//    @Published   var Memberlist = [Member]()
//    
//    @Published   var showview = false
//
//    func fetch() {
//        
//        let str = UserDefaults.standard.string(forKey: "groupId") ?? ""
//        let str1  = "Group/MemberListbyGroupId?gid="+str
//        AccountAPI.getsignin(servciename: str1, nil) { res in
//        switch res {
//        case .success:
//            print("resulllll",res)
//            
//            if let json = res.value{
//                self.Memberlist = []
//                print("Josn",json)
//       
//                
//                let events = json["data"]
//                for j in events {
//                    let sss = Member(id: j.1["memberId"].intValue,memberID: j.1["memberId"].intValue, memberName: j.1["memberName"].stringValue, memberPhoto: j.1["memberPhoto"].stringValue, permission: j.1["permission"].boolValue, groupID: j.1["groupId"].intValue)
//                    self.Memberlist.append(sss)
//                }
//                print(self.Memberlist)
//                if self.Memberlist.count > 0 {
//                    self.showview = true
//                }else{
//                    self.showview = false
//                }
//               
//            }
//          
//
//        case let .failure(error):
//          print(error)
//        }
//      }
//    }
//}
