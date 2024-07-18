//
//  UpdateGroup.swift
//  MapzApp
//
//  Created by Admin on 28/12/22.
//

import SwiftUI
import Alamofire
struct UpdateGroup: View {
    @ObservedObject var obs = updateuserObserver()

    @State  var groupname: String = ""
    @State  var descriptionName: String = "Description"
  
    @State var showImagePicker: Bool = false
    @State  var desc = "Description"
    let minHeight: CGFloat = 60
    @State private var height: CGFloat?
    @State private var showingActionSheet = false
    let textLimit = 10
    @State var searchText =  String()
    @State var heightplus : CGFloat = 35
    @State private var showCancelButton: Bool = false
    var onCommit: () ->Void = {
        print("onCommit")
    }
    @State   var selectedarr = [Int]()// NSMutableArray()//
    @State   var podcastID =  NSMutableArray()//

    @State   var selectedarrtoggle = [Int]()// NSMutableArray()//
   // @State  var groupDetail : GroupViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var image = UIImage(named: "istockphoto-1055686622-612x612")
    @State var mmbrID = Int()

    @State var cmrstr = String()
    let radius: CGFloat = 65
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }
    @State var showfriendlist: Bool = false

    @State  var showingAlert = false
    @State  var showingAlert1 = false
    @State  var message = String()
    var body: some View {
        
        ZStack{
            VStack(spacing: 10){
                Spacer()
                    .frame(height :heightplus)
                VStack(alignment: .trailing){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroupD"), object: self)
                        
                    })
                    {
                        Spacer()
                        
                        Image("cross")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                    }
                }
                
                if obs.showview == true{
                    VStack{
                        HStack {
                            
                            Image(uiImage: image!)
                                .resizable()
                            
                                .frame(width: 70, height: 70)
                                .cornerRadius(35.0)
                                .aspectRatio(contentMode: .fit)
                            
                                .onTapGesture {
                                    
                                    self.showingActionSheet = true
                                    
                                }
                                .actionSheet(isPresented: $showingActionSheet) {
                                    ActionSheet(title: Text("Choose"), message: Text(""), buttons: [
                                        .default(Text("Camera")) {
                                            self.showImagePicker.toggle()
                                            cmrstr = "Camera"  },
                                        .default(Text("Gallery")) {
                                            self.showImagePicker.toggle()
                                            cmrstr = "Gallery" },
                                        
                                            .cancel()
                                    ])
                                }
                                .sheet(isPresented: $showImagePicker) {
                                    
                                    if (cmrstr == "Camera"){
                                        ImagePickerView(sourceType: .camera) { image in
                                            self.image = image
                                        }
                                    }
                                    else  if (cmrstr == "Gallery"){
                                        ImagePickerView(sourceType: .photoLibrary) { image in
                                            self.image = image
                                            
                                            //  self.uploadInBackground()
                                        }
                                    }
                                }
                            //                    Spacer()
                            //                        .frame(height :heightplus)
                            
                            
                            
                            HStack {
                                
                                TextField("", text: $groupname)
                                    .foregroundColor(.black)
                                    .font(.custom("Inter-Regular", size: 17))
                                    .placeholder(when: groupname.isEmpty) {
                                        Text("Group name")
                                            .foregroundColor(.gray)
                                        
                                }
                            }
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 1).foregroundColor(.black))
                            
                            Spacer()
                        }.frame( height: 70)
                        
                        VStack(spacing: 5){
                            
                            HStack{
                                Text("Manager:")
                                    .font(.custom("Inter-Bold", size: 14))
                                Text(UserDefaults.standard.string(forKey: "name") ?? "")
                                    .font(.custom("Inter-Regular", size: 14))
                                Spacer()
                                
                            }
                            
                            HStack{
                                Text("Date Created:")
                                    .font(.custom("Inter-Bold", size: 14))
                                
                                Text(obs.groupcretedDate)
                                    .font(.custom("Inter-Regular", size: 14))
                                Spacer()
                                
                            }
                            
                            
                            HStack(alignment: .top){
                                
                                WrappedTextView(text: $desc, textDidChange: self.textDidChange)
                                    .frame(height: height ?? minHeight)
                                    .padding(.all, 8.0)
                                
                                    .font(.custom("Inter-Regular", size: 20))
                                    
                                    .onAppear {
                                        // remove the placeholder text when keyboard appears
                                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                                            withAnimation {
                                                if self.desc == "Description" {
                                                    self.desc = ""
                                                }
                                            }
                                        }
                                        
                                        // put back the placeholder text if the user dismisses the keyboard without adding any text
                                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                                            withAnimation {
                                                if self.desc == "" {
                                                    self.desc = "Description"
                                                }
                                            }
                                        }
                                    }
                                
                            }//.padding(.horizontal, 12.0)
                            .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 1))
                            
                        }
                        HStack{
                            Text("Members")
                                .font(.custom("Inter-Regular", size: 14))
                            Spacer()
                            Text("View All Permission")
                                .font(.custom("Inter-Regular", size: 14))
                                .onTapGesture(){
                                    
                                }

                        }
                        
                        
                        
                        
                        //                HStack {
                        //
                        //                    // Search text field
                        //                    ZStack (alignment: .leading) {
                        //                        if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                        //                            Text("")
                        //                        }
                        //                        TextField("Add a member", text: $searchText, onEditingChanged: { isEditing in
                        //                            self.showCancelButton = true
                        //                        }, onCommit: onCommit).foregroundColor(.primary)
                        //                    }
                        //                  //  Image(systemName: "magnifyingglass")
                        //
                        //                    // Clear button
                        //                    Button(action: {
                        //                        self.searchText = ""
                        //                    }) {
                        //                        Image(systemName: "magnifyingglass")//.opacity(searchText == "" ? 0 : 1)
                        //                    }
                        //                }.padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        //                .foregroundColor(.black)
                        //                // For magnifying glass and placeholder test
                        //                .background(Color(.white))
                        //                .overlay(RoundedRectangle(cornerRadius: (6)).stroke(lineWidth: 1.0))
                        //
                        
                        //                HStack {
                        //
                        //
                        //                    // Search text field
                        //                    TextField("Add a member", text: $searchText,
                        //                              onCommit: {
                        //                                print("Search = \(searchText)")
                        //                              //  self.amount = Double(searchText)!
                        //                                }
                        //                    )
                        //                        .onChange(of: searchText, perform: { value in
                        //                            print(value)
                        ////                                       if someText != oldText {
                        ////                                           someText = editInputNumber(textIn: someText)
                        ////                                           oldText = someText
                        ////                                       }
                        ////                            obs.searchText = value
                        ////                            obs.fetch()
                        //                            }
                        //
                        //                        )
                        //                        .foregroundColor(Color.black)
                        //                        .font(.custom("Inter-Regular", size: 20))
                        //
                        //                    Spacer()
                        //
                        //                    Image(systemName: "magnifyingglass")
                        //
                        //
                        //                }
                        //                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        //                .foregroundColor(.secondary) // For magnifying glass and placeholder test
                        //                .background(Color(.white))
                        //                .overlay(RoundedRectangle(cornerRadius: (5)).stroke(lineWidth: 1.0))
                        //
                        //
                        
                        
                            HStack {
                             
                                
                                // Search text field
                                Text("Add a Member")
                                    .foregroundColor(Color.black)
                                    .font(.custom("Inter-Regular", size: 16))
                             
                                Spacer()
                                
                                Image(systemName: "magnifyingglass")
                                
                                
                            }
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .foregroundColor(.secondary) // For magnifying glass and placeholder test
                            .background(Color(.white))
                            .overlay(RoundedRectangle(cornerRadius: (5)).stroke(lineWidth: 1.0))
                           
                            .onTapGesture {
                                showfriendlist.toggle()
                            }
                            .fullScreenCover(isPresented: $showfriendlist, content: {
                                membersList()
                            })
                        if (obs.eventlist.count > 0){
                            ScrollView{
                               
                                ForEach(Array(obs.eventlist.enumerated()), id: \.offset) { index, pokemon in
                                    
                                    HStack(alignment: .center, spacing: 10.0){
                                        
                                            AsyncImage(
                                                url: NSURL(string: pokemon.profilePictureURL)! as URL ,
                                                placeholder: { Image("icons8-male-user-72")
                                                        .resizable()
                                                        .foregroundColor(colorGrey1)
                                                        .aspectRatio(contentMode: .fill)
                                                    
                                                    
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
//
//                                            Image((self.selectedarr.contains(index) ? "icons8-ok-60" : ""))
//                                                .resizable()
//                                                .frame(width: 24.0, height: 24.0)
//                                                .scaledToFill()
//                                                .background((self.selectedarr.contains(index) ? Color.white : Color.clear))
//
//                                                .cornerRadius(12)
//                                                .offset(x : -12
//                                                        ,y : -12)
                                        VStack(alignment: .leading, spacing: 5){
                                            Text(pokemon.firstName + pokemon.lastName)
                                                .font(.custom("Inter-Bold", size: 16))
                                            
                                            Text("Remove")
                                                .font(.custom("Inter-Regular", size: 12))
                                                .onTapGesture(){
                                                    mmbrID = pokemon.id
                                                    message  = "Do you want to remove this member from group? "
                                                    showingAlert1.toggle()
                                                    
                                                }
                                            
                                        }
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
                                        //  if(self.selectedarr.contains(index)){
                                        
                                        Image((self.selectedarrtoggle.contains(index) ? "switch_S" : "switch_U"))
                                            .resizable()
                                            .frame(width: 50.0, height: 50.0)
                                        // .scaledToFill()
                                        // .background((self.selectedarr.contains(index) ? Color.white : Color.clear))
                                        
                                            .onTapGesture(){
                                                //   if(self.selectedarr.contains(index)){
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
                                                //  }
                                                
                                            }
                                        
                                        //     }
                                        //
                                        //                                }
                                        
                                    }
                                    .frame(width : UIScreen.main.bounds.width-20)
                                    .padding(.horizontal , 10.0)
                                    .background(Color.white)
                                    .cornerRadius(15.0)
                                    //                        .onTapGesture(){
                                    //
                                    //                            if(self.selectedarr.contains(index)){
                                    //                                //self.selectedarr.re
                                    //                              //  self.selectedarr.re(index)
                                    //                                print(self.selectedarr)
                                    //
                                    ////
                                    //                                for i in 0..<selectedarr.count {
                                    //                                    if (selectedarr[i] == index){
                                    //
                                    //
                                    //                                        for j in 0..<selectedarrtoggle.count {
                                    //                                            if (selectedarrtoggle[j] == index){
                                    //                                                self.selectedarrtoggle.remove(at: j)
                                    //
                                    //                                            }
                                    //                                        }
                                    //                                        self.selectedarr.remove(at: i)
                                    //                                        break
                                    //                                    }
                                    //                                print(i)
                                    //                            }
                                    //                            }
                                    //                            else{
                                    //                                self.selectedarr.append(index)
                                    //                              //  self.selectedarr.add(index)
                                    //                                print(self.selectedarr)
                                    //
                                    //                            }
                                    //                          //  self.getfile()
                                    //                        }
                                    
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
                        
                        Button("Save"){
                            //  obs.ForgotPwd()
                            //
                            
                            if (groupname == "")
                            {
                                
                                message = "Please Enter Group Name!"
                                
                                showingAlert.toggle()
                                
                                return
                                
                            }
                            if (desc == "Description")
                            {
                                
                                message = "Please Enter Description!"
                                
                                showingAlert.toggle()
                                
                                return
                                
                            }
                            
                            if selectedarr.count == 0 {
                                message = "Please Select at least one User!"
                                
                                showingAlert.toggle()
                                
                                return
                            }
                            CreateGroup()
                            
                        }  .font(.custom("Inter-Bold", size: 20))
                            .foregroundColor(.white)
                            .font(.custom("Inter-Medium", size: 20))
                            .frame(width:
                                    UIScreen.main.bounds.width-30, height: 60.0)
                        
                            .background(Color ("themecolor"))
                            .cornerRadius(36)
                        
                        
                        Spacer()
                            .frame(height :heightplus)
                        
                    }.onAppear(){
                        groupname = obs.groupsName
                        desc = obs.groupdiscription
                        selectedarr = []
                        selectedarrtoggle = []
                        for i in 0..<obs.eventlist.count {
                            let mmb = obs.eventlist[i]
                            selectedarr.append(i)
                            if mmb.permission == true {
                                selectedarrtoggle.append(i)
                            }
                        }
                        var imageurl  = String()
                        imageurl = obs.gImage
                          if (imageurl != "http://eventsapp.biz/Uploads/ProfilePicture/") || (imageurl != "")
                          {  if let url = URL(string: imageurl) {
                              let task = URLSession.shared.dataTask(with: url) { data, response, error in
                                  guard let data = data, error == nil else { return }
                                  if (data.count != 0){
                                      DispatchQueue.main.async { /// execute on main thread
                                          image = UIImage(data: data)
                                      }
                                  }
                                 
                              }
                              
                              task.resume()
                          }
                        }
                    }
                }
                
            }  .frame(width: UIScreen.main.bounds.width-30)
                .alert(isPresented: $showingAlert, content: {
                        var alert: Alert {

                            Alert(title: Text("Warning"), message: Text(message), dismissButton: .default(Text("Ok")))
                }
                    return alert
                })
                .edgesIgnoringSafeArea(.all)
            .onAppear(){
                //obs.fetch()
                if UIDevice.current.hasNotch {
                    heightplus = 35
                } else {
                    //... don't have to consider notch
                    heightplus = 20
                }
            }
        }.onAppear(){
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "refreshGroupDG"), object: nil, queue: OperationQueue.main) {
                            pNotification in
              
                obs.fetchEvent()
            }
            
            
            obs.fetchEvent()
        }
        .alert(isPresented:$showingAlert1) {
                    Alert(
                        title: Text("Warning!"),
                        message: Text(message),
                        primaryButton: .destructive(Text("Ok")) {
                            print("Deleting...")
                           
                            deleteUser()

                        },
                        secondaryButton: .cancel()
                    )
                }
    }
    
    private func textDidChange(_ textView: UITextView) {
                    if textView.contentSize.height >= 150
                    {
                        textView.contentSize.height = 150
                    }
                self.height = max(textView.contentSize.height, minHeight)

            }
    
    
    
    
    func CreateGroup(){
        UIApplication.dismissKeyboard()
        var strBase64  = String()
        if image == UIImage(named: "istockphoto-1055686622-612x612"){
            strBase64 = ""
        }else{
            let imgData = image!.pngData()
            
            strBase64 = imgData!.base64EncodedString(options: .lineLength64Characters)

        }
        podcastID = []
        for item in selectedarr {
            print(item)
            let art = obs.eventlist[item]
          
            
            var permission = Bool()
            if selectedarrtoggle.contains(item){
                permission = true
            }else{
                permission = false
            }
            var dic = NSDictionary()
            dic = [
                "member_id": art.id,
                      "permission": permission
           ]
            podcastID.add(dic)
            
            
        }
        
        var logInFormData: Parameters {
            [
                "groupId": String(obs.groupsID),
                "name": groupname,
                  "file": strBase64,
                "discription": desc,
                "user_id": UserDefaults.standard.string(forKey: "id") ?? "",
                "userss" : podcastID
                
                
                
                
                  ]
        
        }
                //   print(logInFormData)

            
                    AccountAPI.signin(servciename: "Group/UpdateGroup", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                            
                            
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                                
                                Toast.init(text: json["message"].stringValue).show()
                                presentationMode.wrappedValue.dismiss()
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroupD"), object: self)

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
    func deleteUser(){
        UIApplication.dismissKeyboard()

        
        var logInFormData: Parameters {
            [
                  
                "groupId": obs.groupsID,
                  "user_id": mmbrID
                
                
                  ]
        
        }
                //   print(logInFormData)

            
                    AccountAPI.signin(servciename: "Group/RemoveUserFromGroup", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                           
                           
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                                obs.fetchEvent()
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

struct UpdateGroup_Previews: PreviewProvider {
    static var previews: some View {
        UpdateGroup()//( groupDetail: GroupViewModel(id: 0, groupsID: 0, groupsName: "", discription: "", gImage: "", cretedDate: "", insertedBy: 0, status: true, message: "", members: []))
    }
}
class updateuserObserver: ObservableObject
{
   
  
    @Published   var eventlist = [Memberlistt]()
    @Published   var groupsID  = Int()
    @Published   var groupsName  = String()
    @Published   var groupdiscription  = String()
    @Published   var gImage  = String()
    @Published   var groupcretedDate  = String()
  @Published var showview = Bool()
       
    func fetchEvent(){

        
        let stt = UserDefaults.standard.string(forKey: "groupId") ?? ""
        
      
        
        var logInFormData: Parameters {
            [
                "groupId": stt,
                 
                  ]
        
        }
        
        print(logInFormData)
            AccountAPI.signin(servciename: "Group/GroupDetails", logInFormData) { res in

            switch res {
        case .success:
            print("resulllll",res)
            
            if let json = res.value{
                print("Josn",json)
        let userdic = json["data"]
                
               // let profile = userdic["groupDetails"]
                let events = userdic["groupDetails"]
                self.eventlist = []
                
                self.groupsID = userdic["groupId"].intValue
                self.groupsName = userdic["groupName"].stringValue
                self.groupdiscription = userdic["description"].stringValue
                self.gImage = userdic["groupImage"].stringValue
                self.groupcretedDate = userdic["createdAt"].stringValue
                let components = self.groupcretedDate.components(separatedBy: " ")
                self.groupcretedDate = components[0]
               
                
                
                
                
                for j in events {
                    let scc = Memberlistt(id: j.1["id"].intValue, createdate: j.1["createdate"].stringValue, permission: j.1["permission"].boolValue, userName: j.1["userName"].stringValue, firstName: j.1["firstName"].stringValue, lastName: j.1["lastName"].stringValue, userEmail: j.1["userEmail"].stringValue, passwordHash: j.1["passwordHash"].stringValue, phoneNumber: j.1["phoneNumber"].stringValue, dateOfBirth: j.1["dateOfBirth"].stringValue, profilePictureURL: j.1["profilePictureURL"].stringValue)
                    self.eventlist.append(scc)
                }
               
               //
                self.showview  = true
            }
          

        case let .failure(error):
          print(error)
        }
      }
    }
    
}


struct Memberlistt: Codable {
    let id: Int
    let createdate: String
    let permission: Bool
    let userName, firstName, lastName, userEmail: String
    let passwordHash: String
    let phoneNumber: String
    let dateOfBirth, profilePictureURL: String

    init(id: Int, createdate: String, permission: Bool, userName: String, firstName: String, lastName: String, userEmail: String, passwordHash: String, phoneNumber: String, dateOfBirth: String, profilePictureURL: String) {
        self.id = id
        self.createdate = createdate
        self.permission = permission
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
        self.userEmail = userEmail
        self.passwordHash = passwordHash
        self.phoneNumber = phoneNumber
        self.dateOfBirth = dateOfBirth
        self.profilePictureURL = profilePictureURL
    }
}
