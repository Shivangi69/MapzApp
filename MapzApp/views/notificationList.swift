//
//  notificationList.swift
//  MapzApp
//
//  Created by Misha Infotech on 16/08/2021.
//

import SwiftUI
import Alamofire

struct notificationList: View {
  
    @ObservedObject var obs = notiListObserver()
    @Environment(\.presentationMode) var presentationMode
    @State var heightplus : CGFloat = 35
    @State private var showingAlert = false
    @State private var showingAlert1 = false
    @State private var showingAlert2 = false
    @State var toemailStr : String = ""
    @State var searchText =  String()
    @State private var showCancelButton: Bool = false

    var onCommit: () ->Void = {
           print("onCommit")
           
       }
    var body: some View {
        ZStack{
            VStack(spacing: 20.0) {
                
                Spacer()
                      .frame(height :heightplus)
                
                
                HStack(spacing : 10.0) {
                    Text("Notification")
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
        
                HStack{

                }
                .frame(width: UIScreen.main.bounds.width-20, height: 1.0)
                .border(Color.black, width: 1)
                .padding(.bottom,
                         3.0)

                
//                if (UserDefaults.standard.string(forKey: "not") == "sm"){
//
//             HStack(spacing: 20.0) {
//                 Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                 }) {
//                    Image("menu")
//                         .resizable()
//
//                         .aspectRatio(contentMode: .fit)
//                 }
//
//                Spacer()
//
//                Text("Notification")
//                    .foregroundColor(Color.white)
//                    .font(.custom("Inter-Bold", size: 22))
//                Spacer()
//                Image("")
//                     .resizable()
//
//                     .aspectRatio(contentMode: .fit)
//             }
//             .padding()
//             .padding(.top,10)
//             .frame(height: 50.0)
//             .background(Color("themecolor"))
//
//                }
               
                
                
                if (obs.showlist){
                    ScrollView{
                        ForEach(obs.eventlist, id: \.self) { pokemon in
                            HStack(alignment: .center, spacing: 10.0){
                                
                                AsyncImage(
                                    url: NSURL(string: pokemon.profilePhoto)! as URL ,
                                    placeholder: { Image("icons8-male-user-72").foregroundColor(colorGrey1)
                                            .aspectRatio(contentMode: .fit)
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
                                
                                VStack(alignment: .leading, spacing: 5.0){
                                    
                                    Text(pokemon.userName )
                                        .font(.custom("Inter-Bold", size: 16))
                                    
                                    Text(pokemon.notificationText)
                                        .font(.custom("Inter-Regular", size: 14))
                                }
                              
                                Spacer()
                                if (pokemon.notificationType == "FriendRequestSend"){
                                    HStack{
                                        Image("icons8-done-100")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .onTapGesture(){
                                                /// toemailStr = pokemon.emailstr
                                                showingAlert = true
                                                
                                            }
                                            .alert(isPresented:$showingAlert) {
                                                Alert(
                                                    title: Text("Alert"),
                                                    message: Text("Do you want to Accept Friend Request?"),
                                                    primaryButton: .default(Text("YES")) {
                                                        //
                                                        //
                                                        // self.aceptrejct(reason: "Accept", fromemail: UserDefaults.standard.string(forKey: "email") ?? "", toemail:toemailStr)
                                                    },
                                                    secondaryButton: .cancel()
                                                )
                                            }
                                        
                                        Image("cross")
                                            .resizable()
                                            .frame(width: 30.0, height: 30.0)
                                            .onTapGesture(){
                                                showingAlert1 = true
                                            }
                                            .alert(isPresented:$showingAlert1) {
                                                Alert(
                                                    title: Text("Alert"),
                                                    message: Text("Do you want to Reject Friend Request?"),
                                                    primaryButton: .default(Text("YES")) {
                                                        //  self.aceptrejct(reason: "Reject", fromemail: UserDefaults.standard.string(forKey: "email") ?? "", toemail: pokemon.email)
                                                    },
                                                secondaryButton: .cancel()
                                            )
                                        }
                                    }
                                }
                                else{
                                    Image("cross1")
                                        .resizable()
                                    .frame(width: 30.0, height: 30.0)
                                    .onTapGesture(){
                                        showingAlert2 = true
                                    }
                                    .alert(isPresented:$showingAlert2) {
                                                Alert(
                                                    title: Text("Alert"),
                                                    message: Text("Do you want to delete this Notification ?"),
                                                    primaryButton: .default(Text("YES")) {
//                                                        self.aceptrejct(reason: "Reject", fromemail: UserDefaults.standard.string(forKey: "email") ?? "", toemail: pokemon.email)
                                                     
                                                        self.DeleteNotification(id: pokemon.Id)
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                }
                               
                            }
//                            .onTapGesture(){
//                                self.ReadNotification(id: pokemon.Id)
//
//                            }
                            
                            .padding(.all, 10.0)

                         //   .background(pokemon.status == 0 ? Color("lightBluee") : Color.white)
                            
                            //.shadow(color: .gray, radius: 5, x: 1, y: 1)
                        }
                        
                    }
                
                }else{
                   
                        
                            blankView(imageNAme: "no_found_notification",ErrorMsg : "Notifications not Found")
                                .offset(y : UIScreen.main.bounds.height/2-120)
                       Spacer()
                    
                }
        
            }
            .frame(width: UIScreen.main.bounds.width)
    
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
    func aceptrejct(reason : String , fromemail : String , toemail : String){
        
       
        var logInFormData: Parameters {
            
            [
                "fromEmail": fromemail,
                "toEmail": toemail,
                "status": reason
            ]
        
        }
        print(logInFormData)
                    AccountAPI.signin(servciename: "FriendInvite/AcceptFriendRequest", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                           
                           
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                                     let userdic = json["data"]

//
                                Toast(text: json["message"].stringValue).show()
                                obs.fetch()
                                
                           
                               
                            }
                            else{
                                Toast(text: json["message"].stringValue).show()

                            }
                        
                            
                        }
                    case let .failure(error):
                      print(error)
                    }
                  }
                
        }

    func DeleteNotification(id : Int){
        
        let str =  String(id)
        let str1  = "Notification/DeleteNotificationAsync?id=" + str
        AccountAPI.getsignin(servciename: str1, nil) { res in
        switch res {
        case .success:
            print("resulllll",res)
            
            if let json = res.value{
                
                
                print("Josn",json)
                if (json["status"] == "true")
                {
                         let userdic = json["data"]


                    Toast(text: json["message"].stringValue).show()
                    obs.fetch()
                 
                }
                else{
                    Toast(text: json["message"].stringValue).show()

            
                }
            }
             
        case let .failure(error):
          print(error)
        }
      }
    }
    
    func ReadNotification(id : Int){
        
        let str =  String(id)
        let str1  = "Notification/ReadNotification?id=" + str
        AccountAPI.getsignin(servciename: str1, nil) { res in
        switch res {
        case .success:
            print("resulllll",res)
            
            if let json = res.value{
                
                
                print("Josn",json)
                if (json["status"] == "true")
                {
                         let userdic = json["data"]


                    Toast(text: json["message"].stringValue).show()
                    obs.fetch()
                 
                }
                
                else {
                    
                    Toast(text: json["message"].stringValue).show()
                }
            }
             
        case let .failure(error):
          print(error)
        }
      }
   }
}
struct notificationList_Previews: PreviewProvider {
    static var previews: some View {
        notificationList()
    }
}
class notiListObserver: ObservableObject {
   
    @Published   var eventlist = [notimodalclassss]()
    
    @Published   var showlist = false
    @Published   var addrsStr = String()

    func fetch() {
        
        let str = UserDefaults.standard.string(forKey: "id") ?? ""
        let str1  = "Notification/GetAllNotificationsById/?id="+str
        AccountAPI.getsignin(servciename: str1, nil) { res in
        switch res {
        case .success:
            print("resulllll",res)
            
            if let json = res.value{
                self.eventlist = []
                print("Josn",json)
      //  let userdic = json["data"]
                
                let events = json["data"]
                for i in events {

                     
                    let scc = notimodalclassss(i.1["userId"].stringValue,  i.1["userName"].stringValue, i.1["profilePhoto"].stringValue, i.1["notificationText"].stringValue,i.1["date"].stringValue,i.1["EventId"].intValue,i.1["id"].intValue,i.1["email"].stringValue,i.1["friendEmail"].stringValue,i.1["status"].intValue,i.1["friendName"].stringValue,i.1["notificationType"].stringValue)
                self.eventlist.append(scc)

//                    var  EventId : Int
//                    var  Id : Int
//                    var  email : String
//                    var  friendEmail : String
//                    var  status : Int
//                    var  friendName : String
//                    var  notificationType : String

                }
                if  (self.eventlist.count > 0){
                    self.showlist = true
                    
                }
                }
                print(self.eventlist)
        case let .failure(error):
          print(error)
        }
      }
    }
}


struct notimodalclassss:Hashable {
    var  userId : String
    var  userName : String
    var  profilePhoto  : String
    var  notificationText : String
    var  date : String
    var  EventId : Int
    var  Id : Int
    var  emailstr : String
    var  friendEmail : String
    var  status : Int
    var  friendName : String
    var  notificationType : String

   
    init(_ userId:String,_ userName:String,_ profilePhoto:String,_ notificationText:String,_ date:String,_ EventId:Int,_ Id:Int,_ emailstr:String,_ friendEmail:String,_ status:Int,_ friendName:String,_ notificationType:String){
       self.userId = userId
       
        self.userName = userName
        self.profilePhoto = profilePhoto
        self.notificationText = notificationText
        self.date = date
        self.EventId = EventId
        self.Id = Id
        self.emailstr = emailstr
        self.friendEmail = friendEmail
        self.status = status
        self.friendName = friendName
        self.notificationType = notificationType

    }
}
