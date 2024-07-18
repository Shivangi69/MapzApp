//
//  CreateGroupView.swift
//  MapzApp
//
//  Created by Misha Infotech on 22/12/2022.
//

import SwiftUI
import CoreData
import Alamofire
import SSSwiftUILoader

struct CreateGroupView: View {
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
@State var currentdate = String()
    
    @ObservedObject var obs = groupuserObserver()

    @Environment(\.presentationMode) var presentationMode
    @State var image = UIImage(named: "istockphoto-1055686622-612x612")

    @State var cmrstr = String()
    let radius: CGFloat = 65
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }
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
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroup"), object: self)
                        
                    })
                    {
                        Spacer()
                        
                        Image("cross")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                    }
                }
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
                
                VStack
                {
                    
                               HStack{
                    Text("Manager:")
                        .font(.custom("Inter-Bold", size: 17))
                    Text(UserDefaults.standard.string(forKey: "name") ?? "")
                        .font(.custom("Inter-Regular", size: 17))
                    Spacer()
                    
                }
                HStack{
                    Text("Date Created:")
                        .font(.custom("Inter-Bold", size: 17))
                    Text(currentdate )
                        .font(.custom("Inter-Regular", size: 17))
                    Spacer()
                    
                }
                
            }
                
//                HStack{
//                    Text("Date Created:")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                    Text("bffgfbdfx")
//                    Spacer()
//
//                }
                
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
            
                HStack {
                 
                    
                    // Search text field
                    TextField("Add a member", text: $searchText,
                              onCommit: {
                                print("Search = \(searchText)")
                              //  self.amount = Double(searchText)!
                                }
                    )
                        .onChange(of: searchText, perform: { value in
                            print(value)
//                                       if someText != oldText {
//                                           someText = editInputNumber(textIn: someText)
//                                           oldText = someText
//                                       }
//                            obs.searchText = value
//                            obs.fetch()
                            }
                        
                        )
                        .foregroundColor(Color.black)
                        .font(.custom("Inter-Regular", size: 20))
                 
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                    
                    
                }
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
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
                
            }  .frame(width: UIScreen.main.bounds.width-30)
                .alert(isPresented: $showingAlert, content: {
                        var alert: Alert {

                            Alert(title: Text("Warning"), message: Text(message), dismissButton: .default(Text("Ok")))
                }
                    return alert
                })
                .edgesIgnoringSafeArea(.all)
            .onAppear(){
                let date = Date()

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                print(dateFormatter.string(from: date))
                currentdate = dateFormatter.string(from: date)
                obs.fetch()
                if UIDevice.current.hasNotch {
                    heightplus = 35
                } else {
                    //... don't have to consider notch
                    heightplus = 20
                }
            }
        }
    }
    
    private func textDidChange(_ textView: UITextView) {
                    if textView.contentSize.height >= 150
                    {
                        textView.contentSize.height = 150
                    }
                self.height = max(textView.contentSize.height, minHeight)

            }
    
    
//    func uploadInBackground(fileInData: Data) {
//
//        
//        let evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""
//        let parameters = [
//              "EventId": evntId,
//            "UserId": UserDefaults.standard.string(forKey: "id") ?? ""
//            
//            ]
//    print(parameters)
//        let headers: HTTPHeaders
//            headers = ["Content-type": "multipart/form-data",
//                       "Content-Disposition" : "form-data"]
//            
////            let headers: [String : String] = [ "Authorization": "key"]
//        let baseURL = URL(string: "https://mapzapp.swadhasoftwares.com/api/Upload/uploadeventdiary")
//        print(baseURL!)
//
//            Networking.sharedInstance.backgroundSessionManager.upload(multipartFormData: { (multipartFormData) in
//               //
//               // multipartFormData.append(fileInData, withName: "file", mimeType: "image/jpg")
//                
//               //
//                //multipartFormData.append(fileInData, withName: "jpg", fileName: "file", mimeType: "image/jpg")
//               //
//              //  multipartFormData.append(fileInData, withName: "file", fileName: "file", mimeType: "image/jpeg")
//                //
//              
//                multipartFormData.append(fileInData, withName: "file", mimeType: "image/jpeg")
//               // multipartFormData.append(fileInData, withName: "file")
//                for (key, value) in parameters {
//                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
//                       }
//            }, usingThreshold: UInt64.init(), to: baseURL!, method: .post, headers: headers)
//            
//            { (result) in
//                switch result {
//                case .success(let upload, _, _):
//                    ///api/Upload/upload
//                    upload.uploadProgress(closure: { (progress) in
//                        //Print progress
//                        let value =  Int(progress.fractionCompleted * 100)
//                        print("\(value) %")
//                    })
//                    
//                    upload.responseJSON { response in
//                        //print response.result
//                        print(response.description)
//                        let res = response.response?.statusCode
//                        print(res!)
//                        Toast(text: "Upload Successfully").show()
//
//                    }
//                    
//                case .failure(let encodingError):
//                    //print encodingError.description
//                    print(encodingError.localizedDescription)
//                }
//            }
//        }
    
    
    func CreateGroup(){
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
            let art = obs.filteredeventlist[item]
          
            
            var permission = Bool()
            if selectedarrtoggle.contains(item){
                permission = true
            }else{
                permission = false
            }
            var dic = NSDictionary()
            dic = [
                "member_id": art.userID,
                      "permission": permission
           ]
            podcastID.add(dic)
            
            
        }
        
        var logInFormData: Parameters {
            [
                "name": groupname
                ,
                  "file": strBase64,
                "discription": desc,
                "user_id": UserDefaults.standard.string(forKey: "id") ?? "",
                "userss" : podcastID,
                "group": true
                
                
                
                  ]
        
        }
                //
        print(logInFormData)

            
                    AccountAPI.signin(servciename: "Group/AddGroup", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                           
                           
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                                
                                Toast.init(text: json["message"].stringValue).show()
                                UserDefaults.standard.set("true", forKey: "group")

                                presentationMode.wrappedValue.dismiss()
                                
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshGroup"), object: self)

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
    


struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
    }
}

struct SearchBarView2: View {

    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    var onCommit: () ->Void = {print("onCommit")}

    var body: some View {
        HStack {
            HStack {

                // Search text field
                ZStack (alignment: .leading) {
                    if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                        Text("")
                    }
                    TextField("", text: $searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: onCommit).foregroundColor(.primary)
                }
                Image(systemName: "magnifyingglass")

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
//            .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//
//            .cornerRadius(10.0)

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
class groupuserObserver: ObservableObject {
   
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
   
