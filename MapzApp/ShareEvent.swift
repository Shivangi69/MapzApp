//
//  ShareEvent.swift
//  MapzApp
//
//  Created by Admin on 13/12/22.
//

import SwiftUI

//struct ShareEvent: View {
//    @Environment(\.presentationMode) var presentationMode
//    var body: some View {
//        ZStack{
//            VStack{
//
//            }.edgesIgnoringSafeArea(.all)
//        }    }
//}
//
//struct ShareEvent_Previews: PreviewProvider {
//    static var previews: some View {
//        ShareEvent()
//    }
//}
import SwiftUI
import Alamofire
struct ShareEvent: View {
    @ObservedObject var obs = ShareEventObserver()
    @Environment(\.presentationMode) var presentationMode

    @State var searchText =  String()
    @State private var showCancelButton: Bool = false
    @State  var comment = "Comment"

    @State private var height: CGFloat?

    @State var heightplus : CGFloat = 35
    @State   var selectedarr = [Int]()// NSMutableArray()//
    @State   var podcastID =  NSMutableArray()//

    
    func chngevalues(){
        if searchText == "" {
            obs.filteredeventlist = []
            obs.filteredeventlist = obs.eventlist

        }
        else {
            obs.filteredeventlist = []
            obs.filteredeventlist  = obs.eventlist.filter { $0.name.contains(searchText) }
           // obs.filteredeventlist = obs.eventlist.filter($0.name.contains(searchText))

        }
    }
    var onCommit: () ->Void = {
        print("onCommit")
       
      // chngevalues()
    }
    let minHeight: CGFloat = 40

    var body: some View {
        ZStack{
            VStack{
                Spacer()
                    .frame(height :heightplus)
                
                HStack{

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                       
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
                .frame(height: 50)
                
                
                VStack (spacing: 10.0) {
                   
                    HStack(spacing : 10.0) {
                        Text("Share")
                            .foregroundColor(Color.black)
                            .font(.custom("Inter-Bold", size: 20))
                           
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
                                    print("searchTexteee")
                                }, onCommit: {
                                    print("searchText")
                                    print(searchText)

                                }).foregroundColor(.primary)
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
                        
                    }.frame(width: UIScreen.main.bounds.width-16)
                    HStack{
                        
                    }
                    .frame(width: UIScreen.main.bounds.width-16, height: 1.0)
                    .border(Color.black, width: 1)
                    .padding(.bottom,
                             5.0)
                  
                    if (obs.eventlist.count > 0){
                        ScrollView{
                       // ForEach(obs.eventlist, id: \.self) { pokemon in
                            //  List{
                            ForEach(Array(obs.filteredeventlist.enumerated()), id: \.offset) { index, pokemon in

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
//
//                                }
                                
                            }
                            .frame(width : UIScreen.main.bounds.width-20)
                           .padding(.horizontal,    10.0)
                            .background(Color.white)
                            .cornerRadius(15.0)
                            .onTapGesture(){
                                
                                if(self.selectedarr.contains(index)){
                                    //self.selectedarr.re
                                  //  self.selectedarr.re(index)
                                    print(self.selectedarr)

                                    for i in 0..<selectedarr.count {
                                        if (selectedarr[i] == index){
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
                    HStack {
                        WrappedTextView(text: $comment, textDidChange: self.textDidChange)
                                    .frame(height: height ?? minHeight)
                                    .padding(.horizontal, 8.0)

                                .foregroundColor(self.comment == "Comment" ? .gray : .black)
                                    .font(.custom("Inter-Regular", size: 17))

                                    .onAppear {
                                        // remove the placeholder text when keyboard appears
                                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                                            withAnimation {
                                                if self.comment == "Comment" {
                                                    self.comment = ""
                                                }
                                            }
                                        }

                                        // put back the placeholder text if the user dismisses the keyboard without adding any text
                                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                                            withAnimation {
                                                if self.comment == "" {
                                                    self.comment = "Comment"
                                                }
                                            }
                                        }
                                    }
                    }

                     
                    .frame(width: UIScreen.main.bounds.width-30)
                    .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 1))
                    
                }
                
                Button(action: {
                     //
                    shareEvent()
                    //  self.AddDairy()
                }, label: {
                    Text("Share Event")
                        .font(.custom("Inter-Bold", size: 18))
                })
                .frame(width: 250 , height: 50)
                .background((Color("themecolor-1")))
                .foregroundColor(.white)
                .cornerRadius(25)
               
                Spacer()
                                     .frame(height :heightplus)
                
            }.edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
        }.onAppear(){
            if UIDevice.current.hasNotch {
                              heightplus = 35
                          } else {
                              //... don't have to consider notch
                              heightplus = 20
                          }
            obs.fetch()
        }
    }
    private func textDidChange(_ textView: UITextView) {
                if textView.contentSize.height >= 150
                {
                    textView.contentSize.height = 150
                }
            self.height = max(textView.contentSize.height, minHeight)

        }
    
    func shareEvent()  {
        
        podcastID = []
        for item in selectedarr {
            print(item)
            let art = obs.filteredeventlist[item]
            podcastID.add(art.userID)
        }
        
        
        var logInFormData: Parameters {
            
            [
                "eventId": Int(UserDefaults.standard.string(forKey: "eventID") ?? "0") ?? 0,
                "UserId": Int(UserDefaults.standard.string(forKey: "id") ?? "0") ?? 0 ,
                "friendId" :podcastID,
                    "comment" : comment
                 ]
        
        }
        print(logInFormData)
                    AccountAPI.signin(servciename: "EventDiary/EventShareApi", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                           
                           
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                                     let userdic = json["data"]

//                                let fullName : String = userdic["dateOfBirth"].stringValue
//                                let fullNameArr : [String] = fullName.components(separatedBy: "T")
//                                let datestr: String = fullNameArr[0]
//
//
//                                     UserDefaults.standard.set(userdic["id"].int, forKey: "id")
//
//                                     UserDefaults.standard.set(userdic["email"].string, forKey: "email")
//                                     UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")//firstName
//                                     UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
//                                     UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
//                                     UserDefaults.standard.set(datestr, forKey: "dateOfBirth")
//                                     UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
//                                UserDefaults.standard.set(userdic["tagLine"].string, forKey: "phoneNumber")
//                                UserDefaults.standard.set(userdic["totalFriend"].int, forKey: "totalFriend")
//                                UserDefaults.standard.set(userdic["totalEvent"].int, forKey: "totalEvent")
//
//
//                                UserDefaults.standard.set(fullName, forKey: "DateOfBirth")
//
////
//                                self.showingAlert1.toggle()
//
                              
                                
                                //   self.message = json["message"].stringValue
                                Toast(text: json["message"].stringValue).show()
                                presentationMode.wrappedValue.dismiss()
                                //
//
                     //                self.logindetails.append(acc)
                     //                print(self.logindetails)
                           
                               
                            }
                            else{
                                Toast(text: json["message"].stringValue).show()

                          //   self.showingAlert.toggle()
                            // self.message = json["message"].stringValue
                           //  @Published  var showingAlert = false

                     //        AlertToast(displayMode: .alert, type: .regular, title: json["ResponseMsg"].stringValue )
                     //        AlertToast(displayMode: .alert, type: .regular, title:json["ResponseMsg"].stringValue )

                            }
                        
                            
                        }
                    case let .failure(error):
                      print(error)
                    }
                  }
                
        }
    
}

struct ShareEvent_Previews: PreviewProvider {
    static var previews: some View {
        ShareEvent()
    }
}


class ShareEventObserver: ObservableObject {
   
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
   

struct ShareSearchResultModel:Hashable {
    let userID: Int
        let name, dob: String
        let profilePictureURL: String
        let email, phoneNumber, tagLine: String
        let diaryCount, friendCount: Int
        let deviceType, deviceToken: String

}
    
//struct SearchBarView1: View {
//
//    @Binding var searchText: String
//    @State private var showCancelButton: Bool = false
//    var onCommit: () ->Void = {print("onCommit")}
//
//    var body: some View {
//        HStack {
//            HStack {
//                Image(systemName: "magnifyingglass")
//
//                // Search text field
//                ZStack (alignment: .leading) {
//                    if searchText.isEmpty { // Separate text for placeholder to give it the proper color
//                        Text("")
//                    }
//                    TextField("", text: $searchText, onEditingChanged: { isEditing in
//                        self.showCancelButton = true
//                    }, onCommit: onCommit).foregroundColor(.primary)
//                }
//                // Clear button
//                Button(action: {
//                    self.searchText = ""
//                }) {
//                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
//                }
//            }
//            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
//            .foregroundColor(.secondary) // For magnifying glass and placeholder test
//            .background(Color(.white))
//            .overlay(RoundedRectangle(cornerRadius: (16)).stroke(lineWidth: 1.0))
////            .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
////
////            .cornerRadius(10.0)
//
//            if showCancelButton  {
//                // Cancel button
//                Button("Cancel") {
//                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
//                    self.searchText = ""
//                    self.showCancelButton = false
//                }
//                .foregroundColor(Color(.systemBlue))
//            }
//        }
//        .padding(.horizontal)
//        .navigationBarHidden(showCancelButton)
//    }
//}
