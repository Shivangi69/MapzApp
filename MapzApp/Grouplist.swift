//
//  Grouplist.swift
//  MapzApp
//
//  Created by Admin on 28/12/22.
//

import SwiftUI

struct Grouplist: View {
    @Environment(\.presentationMode) var presentationMode
    @State var heightplus : CGFloat = 35
    @ObservedObject var obs = GroupstObservable()
    @State var showCreategroup: Bool = false
    
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Spacer()
                    .frame(height :heightplus)
                
                VStack(alignment: .trailing){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    })
                    {
                        Spacer()
                        Image("cross")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                    }
                }.padding(.horizontal , 10)
                HStack(spacing : 10) {
                    
                    Image("contacts")
                        .resizable()
                        .frame(width: 30.0, height: 30.0)
                    
                    Text("Groups")
                        .foregroundColor(Color.black)
                        .font(.custom("Inter-Bold", size: 20))
                        .padding(.leading, 16.0)
                    
                    Spacer()
                }.padding(.horizontal , 10)
                HStack{
                    
                }
                .frame(width: UIScreen.main.bounds.width-30, height: 1.0)
                .border(Color.black, width: 1)
                .padding(.bottom,  3.0)
                
                if obs.showlist == true    {
                    QGrid(obs.GroupList,
                          columns: 3,
                          columnsInLandscape: 4,
                          vSpacing: 10,
                          hSpacing: 10,
                          vPadding: 10,
                          hPadding: 10) { person in
                        GridCellforgroups(person: person)
                        
                    }
                    
                }
                //                QGrid(obs.GroupList, columns: 3) {
                //
                //
                //                    GridCellforgroups(person: $0)
                //
                //                }
                
                
                //   if obs.showview{
                //                ScrollView{
                //                    VStack{
                //                          ForEach(obs.GroupList, id: \.self) { pokemon in
                //                           // FeedViewCell(GroupList : pokemon)
                //                        }
                //                    }
                //                }
                Spacer()
                
                Button("Create a group"){
                    //  obs.ForgotPwd()
                    
                    showCreategroup.toggle()
               
                }   .font(.custom("Inter-Bold", size: 20))
                    .foregroundColor(.white)
                    .font(.custom("Inter-Medium", size: 20))
                    .frame(width:
                            UIScreen.main.bounds.width-30, height: 60.0)
                
                    .background(Color ("themecolor"))
                    .cornerRadius(36)
                    .onTapGesture {
                        showCreategroup.toggle()
                    }
                    .fullScreenCover(isPresented: $showCreategroup, content: {
                        
                        if (UserDefaults.standard.string(forKey: "paymentStatus") == "True" || UserDefaults.standard.string(forKey: "paymentStatus") == "true"){
                            CreateGroupView()
                            //                                                                                       if UserDefaults.standard.string(forKey: "group") == "true"{
                            //                                                                                           Grouplist()
                            //                                                                                       }
                            //                                                                                      else if UserDefaults.standard.string(forKey: "group") == "false"{
                            //                                                                                           CreateGroupView()
                            //                                                                                      }else{
                            //                                                                                          CreateGroupView()
                            //
                            // }
                            
                        }
                        else if (UserDefaults.standard.string(forKey: "paymentStatus") == "False" || UserDefaults.standard.string(forKey: "paymentStatus") == "false")
                        {
                            PackageSelection()
                        }
                      
                        else {
                            PackageSelection()
                        }
                        
                    })
                //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroup"), object: self)
                
                Spacer()
                    .frame(height :heightplus)
                //  }
            }.edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
                .onAppear(){
                    
                    if UIDevice.current.hasNotch {
                        heightplus = 35
                    } else {
                        //... don't have to consider notch
                        heightplus = 20
                    }
                    
                    obs.Fetch()
                    NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "refreshGroup"), object: nil, queue: OperationQueue.main) {
                        pNotification in
                        obs.Fetch()
                }
            }
        }
    }
}

struct GridCellforgroups: View {
    var person: GroupViewModel
    @State var showfriendlist: Bool = false
    
    var body: some View {
        VStack() {
            //        Image(person.gImage)
            //        .resizable()
            //        .scaledToFit()
            
            
            
            AsyncImage(
                
                url: NSURL(string: person.gImage)! as URL,
                placeholder: {  Image("user")
                    
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                },
                image: { Image(uiImage: $0).resizable()
                    
                }
            )
            
            .clipShape(Circle())
            //        .shadow(color: .primary, radius: 5)
            //  .padding([.horizontal, .top], 7)
            .frame(width: 80, height: 80)
            
            Text(person.groupsName).lineLimit(2)
        }  .onTapGesture {
            showfriendlist.toggle()
            UserDefaults.standard.set(String(person.groupsID), forKey: "groupId")
        }
        .fullScreenCover(isPresented: $showfriendlist, content: {
            // UpdateGroup( groupDetail: person)
            GroupsEventView(selectedTab: "",groupDetail: person)
            
        })
    }
}
struct Grouplist_Previews: PreviewProvider {
    static var previews: some View {
        Grouplist()
    }
}
class GroupstObservable: ObservableObject {
    
    @Published   var GroupList = [GroupViewModel]()
    @Published   var showlist = false
    @Published   var addrsStr = String()
    @Published   var memberslist = [Member]()
    
    func Fetch() {
        
        let str = UserDefaults.standard.string(forKey: "id") ?? ""
        let str1  = "Group/GroupListbyUserId?uid=" + str
        AccountAPI.getsignin(servciename: str1, nil) { res in
            switch res {
            case .success:
                print("resulllll",res)
                
                if let json = res.value{
                    self.GroupList = []
                    print("Josn",json)
                    //  let userdic = json["data"]
                    var ival = Int()
                    ival = 1
                    let events = json["data"]
                    for i in events {
                        self.memberslist = []
                        let members = i.1["members"]
                        for j in members {
                            let sss = Member(id: j.1["memberId"].intValue,memberID: j.1["memberId"].intValue, memberName: j.1["memberName"].stringValue, memberPhoto: j.1["memberPhoto"].stringValue, permission: j.1["permission"].boolValue, groupID: j.1["groupId"].intValue)
                            self.memberslist.append(sss)
                        }
                            let scc = GroupViewModel(id: ival,groupsID: i.1["groupsId"].intValue, groupsName: i.1["groupsName"].stringValue, discription: i.1["discription"].stringValue, gImage: i.1["gImage"].stringValue, cretedDate: i.1["cretedDate"].stringValue, insertedBy: i.1["insertedBy"].intValue, status: i.1["status"].boolValue, message: i.1["message"].stringValue, members: self.memberslist)
                        
                        
                        self.GroupList.append(scc)
                        ival = ival + 1
                        
                    }
                    self.showlist = true
                }
                print(self.GroupList)
            case let .failure(error):
                print(error)
            }
        }
    }
}

struct GroupViewModel: Identifiable, Hashable {
    var id: Int
    
    let groupsID: Int
    let groupsName, discription, gImage, cretedDate: String
    let insertedBy: Int
    let status: Bool
    let message: String
    let members: [Member]
    
    
    init(id: Int,groupsID: Int, groupsName: String, discription: String, gImage: String, cretedDate: String, insertedBy: Int, status: Bool, message: String, members: [Member]) {
        self.id = groupsID
        
        self.groupsID = groupsID
        self.groupsName = groupsName
        self.discription = discription
        self.gImage = gImage
        self.cretedDate = cretedDate
        self.insertedBy = insertedBy
        self.status = status
        self.message = message
        self.members = members
    }
    
    
}
struct Member:  Identifiable, Hashable {
    var id: Int
    
    let memberID: Int
    let memberName: String
    let memberPhoto: String
    let permission: Bool
    let groupID: Int
    
    
    
    init(id: Int,memberID: Int, memberName: String, memberPhoto: String, permission: Bool, groupID: Int) {
        self.id = id
        self.memberID = memberID
        self.memberName = memberName
        self.memberPhoto = memberPhoto
        self.permission = permission
        self.groupID = groupID
    }
}

