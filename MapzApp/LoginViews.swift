//
//  LoginViews.swift
//  Indemart
//
//  Created by Misha Infotech on 29/06/2021.
//


import SwiftUI
import Alamofire
import SwiftyJSON
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import SimpleToast
import FirebaseAuth

struct LoginViews: View {
    //
    @StateObject var twitterAPI = TwitterAPI() //1
    @StateObject var viewModel = AuthenticationViewModel()

    @Environment(\.presentationMode) private var presentation: Binding<PresentationMode>
    @ObservedObject var obs = loginObserver()
    @State var showsignupView = false
    @State var showforgotView = false
    @State var showsignupViewafterFB = false
    @State  var statusfb = String()
    let googleSignIn = GIDSignIn.sharedInstance
    @State var showSnackBar = false
    @State private var showdocPopUp = false
    @State  var message = String()
    @State  var showverifyScreen = false
    @Environment(\.presentationMode) var presentationMode

    @State var showToast: Bool = false

        private let toastOptions = SimpleToastOptions(
            alignment: .bottom, hideAfter: 5, showBackdrop: false
            
        )
    
   //     @ObservedObject var myGoogle = GoogleStuff()
    @State private var forgtmail = String()

    @State  var showingAlert = false
    @State  var showingAlert1 = false

        @State private var signedIn = false
    private let premission = ["public_profile", "email"] //added
    @State   var emailstr : String = ""
   //
    @State   var existornot : String = ""

    
    func showAlertView(withMesage:String){
        var alert: Alert {
            
            Alert(title: Text("Warning"), message: Text("Hello SwiftUI Alert"), dismissButton: .default(Text("Dismiss")))
            
        }
    }

    public func initialActions() {
            self.obs.shouldRedirectToMAINView = true
        }

    var body: some View {
        ZStack{
            NavigationView {
               // ScrollView{
                    VStack(spacing: 15.0 ) {
                        
                     
                        
                        
                        
                        Image("logo")
                            .resizable()
                        //
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60, alignment: .center)
                        
                        
                        Text("Please Login to Your Account")
                            .foregroundColor(Color.white)
                            .font(.custom("Inter-Bold", size: 20))
                            .frame(height: 60, alignment: .center)
                        
                        HStack {
                            
                            TextField("", text: $obs.email).foregroundColor(Color.white)
                                .font(.custom("Inter-Regular", size: 17))
                                .placeholder(when: obs.email.isEmpty) {
                                    Text("Email Address")
                                        .foregroundColor(.white)
                                }
                            Spacer()
                            Image("mail")
                                .foregroundColor(.white)
                            
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: (25.0)).stroke(lineWidth: 1).foregroundColor(.white))
                            
                            HStack {
                                
                                SecureField("", text: $obs.password)
                                    .foregroundColor(.white)
                                    .font(.custom("Inter-Regular", size: 17))
                                    .placeholder(when: obs.password.isEmpty) {
                                        Text("Password").foregroundColor(.white)
                                        
                                    }
                                Spacer()
                                
                                Image("pwd")
                                    .foregroundColor(.white)
                                
                            }
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: (25.0)).stroke(lineWidth: 1).foregroundColor(.white))
                            
                        VStack(alignment: .trailing) {
                            HStack {
                                Spacer()
                                
                                Button("Forgot Password?") {
                                    UIApplication.dismissKeyboard()
                                    showdocPopUp.toggle()
                                }
                                .font(.custom("Inter-SemiBold", size: 20))
                                .foregroundColor(.white)
                                .frame(height: 45)
                                .cornerRadius(15)
                            }
                        }

                        
                        Button("LOGIN"){
                            UIApplication.dismissKeyboard()
                            //
                            // obs.showNextView.toggle()
                            if (obs.email == "")
                            {
                                //
                                obs.message = "Please Enter Email!"
                                //
                                //   obs.showingAlert.toggle()
                                //
                                obs.showingAlert = true
                                return
                                
                            }
                            if (obs.password == "")
                            {
                                //
                                obs.message = "Please Enter Password!"
                                //
                                obs.showingAlert = true
                                //
                                return
                                
                            }
                            
                            obs.login()
                            
                        }
                        .font(.custom("Inter-Bold", size: 20))
                        .foregroundColor(Color.white)
                        .frame(width:UIScreen.main.bounds.width - 30 ,height: 60)
                        .background(Color("buttoncolor"))
                        .cornerRadius(30)
                        .onTapGesture(){
                            UIApplication.dismissKeyboard()
                            //
                            // obs.showNextView.toggle()
                            if (obs.email == "")
                            {
                                //
                                obs.message = "Please Enter Email!"
                                //
                                //   obs.showingAlert.toggle()
                                //
                                obs.showingAlert = true
                                return
                                
                            }
                            if (obs.password == "")
                            {
                                //
                                obs.message = "Please Enter Password!"
                                //
                                obs.showingAlert = true
                                //
                                return
                                
                            }
                            
                            obs.login()
                        }
                        .fullScreenCover(isPresented: $obs.showNextView, content: MainView.init)
    
                        Spacer()
                        
                        Text("Or Login With")
                            .foregroundColor(Color.white)
                            .font(.custom("Inter-Regular", size: 19))
                            .frame(width: 300, height: 35, alignment: .center)
                        
                        
                        HStack{
                            Button(action: {
                              
                                UIApplication.dismissKeyboard()
                                viewModel.signOut()
                            //    viewModel.signIn()
                                
                            }, label: {
                                HStack {
                                    Image( "gmail")
                                        .aspectRatio(contentMode: .fill)
                                    
                                    
                                }
                            })
                            .frame(width: 70 , height: 70)
                            .fullScreenCover(isPresented: $viewModel.showsignupViewaftergoogle, content: {
                                    
                                    if ( UserDefaults.standard.string(forKey: "StatusGmail") == "yes"){
                                        MainView()
                                        
                                    }
                                    else if ( UserDefaults.standard.string(forKey: "StatusGmail") == "No"){
                                        MainView()
                                    }
                                    
                                })
                            Button(action: {
                                UIApplication.dismissKeyboard()
                                //
                                self.FacebookLogin()
                                
                            }, label: {
                                HStack {
                                    Image( "facebook")
                                    
                                }.frame(width: 70
                                        , height: 70)
                                
                                
                            })
                            .fullScreenCover(isPresented: $showsignupViewafterFB , content: {
                                
                                if ( UserDefaults.standard.string(forKey: "StatusFb") == "yes"){
                                    MainView()
                                    
                                }
                                else if ( UserDefaults.standard.string(forKey: "StatusFb") == "No"){
                                    signuppage()
                                    
                                }
                                
                            })
                            Button(action: {
                                UIApplication.dismissKeyboard()
                                twitterAPI.authorize()
                                
                                
                            }, label: {
                                HStack {
                                    Image( "twitter")
                                    
                                }
                                .frame(width: 70
                                       , height: 70)
                            })
                            .sheet(isPresented: $twitterAPI.authorizationSheetIsPresented) {
                                SafariView(url: $twitterAPI.authorizationURL)
                            }
                        }
                        // Spacer()
                        HStack(alignment: .center , spacing : 0 ){
                            Text("Don't have an account? ")
                                .foregroundColor(.white)
                                .font(.custom("Inter-Regular", size: 17))
                                .frame(height: 35, alignment: .trailing)
                            
                            Button(action: {
                                UIApplication.dismissKeyboard()
                                showsignupView.toggle()
                            }){ Text("Create new now!").underline()
                                    .foregroundColor(.white)
                                    .font(.custom("Inter-Regular", size: 17))
                                
                            }
                            .fullScreenCover(isPresented: $showsignupView, content: signuppage.init)
                            
                       
                        }
                        .padding(.horizontal, 5.0)
                        .onAppear(){
                            UserDefaults.standard.set("done", forKey: "launchfirst")
                        }
                        
                    }
                    .padding()
                    .navigationBarHidden(true)
                    
            //    }//.background((Color("themecolor")))
                .background(Color("themecolor") .ignoresSafeArea(.all, edges: .all))
                .simpleToast(isPresented: $obs.showingAlert, options: toastOptions) {
                    HStack {
                        Text(obs.message)
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .foregroundColor(Color.black)
                    .cornerRadius(10)
                }
                
            }
            if $showdocPopUp.wrappedValue {
                ZStack {
                    //
                    Color.white
                    
                    
                    HStack {
                         Spacer()

                         Button(action: {
                             // Close button action to dismiss the popup
                             showdocPopUp.toggle()
                         }) {
                             Image(systemName: "xmark.circle.fill")
                                 .foregroundColor(.white)
                                 .font(.system(size: 20))
                         }
                         .padding(10)
                         .background(Color.clear)
                     }
                    VStack(alignment: .center, spacing: 20.0) {
             
                        Spacer()
                        Text("Forgot Password")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("bgColor"))
                        
                        
                        HStack{
                            
                            TextField("", text: $forgtmail)
                                .padding(.leading, 10.0)
                                .font(.custom("Inter-Regular", size: 17))
                                .frame(width: UIScreen.main.bounds.width-100, height: 60)
                                .foregroundColor(Color("bgColor"))
                                .placeholder(when: forgtmail.isEmpty) {
                                    Text("Email Address")
                                        .foregroundColor(Color("bgColor"))
                                        .padding(.leading, 10.0)
                                    
                                }
                        }
                        .overlay(RoundedRectangle(cornerRadius: (25.0)).stroke(lineWidth: 1)
                            .foregroundColor(Color("bgColor")))
                        Button(action: {
                            
                            if (forgtmail == "")
                            {
                                //
                                obs.message = "Please Enter Email!"
                                //
                                //   obs.showingAlert.toggle()
                                //
                                obs.showingAlert = true
                                return
                                
                            }
                            
                            UIApplication.dismissKeyboard()
                            self.forgotPwd()
                            // self.showdocPopUp = false
                        }, label: {
                            Text("Submit")
                                .font(.custom("Inter-Bold", size: 18))
                        })//bgColor
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("bgColor")))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .alert(isPresented: $showingAlert, content: {
                            var alert: Alert {
                                
                                Alert(title: Text("Warning"), message: Text(message), dismissButton: .default(Text("Ok")))
                            }
                            return alert
                        })
                        .fullScreenCover(isPresented: $showverifyScreen, content: {
                            Verification(emailstring:forgtmail)
                        })
                        .alert(isPresented:$showingAlert1) {
                            Alert(
                                title: Text("Warning"),
                                message: Text(message),
                                primaryButton: .destructive(Text("Ok")) {
                                    print("Deleting...")
                                    //  self.showNextView.toggle()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                        
                    }.padding()
                    
                }
                .frame(width: UIScreen.main.bounds.width-60, height: 260)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
        }
    }
    
    func forgotPwd() {
        
        var logInFormData: Parameters {
            [
                "email": forgtmail
            ]
            
        }
        
        print(logInFormData)
        
        
        AccountAPI.signin(servciename: "Accounts/ForgotPassword", logInFormData) { res in
            switch res {
            case .success:
                print("resulllll",res)
                if let json = res.value{
                    
                    
                    print("Josn",json)
                    if (json["status"] == "true")
                    {
                        let userdic = json["data"]
                        UserDefaults.standard.set(forgtmail, forKey: "emailf")
                        
                        self.showverifyScreen.toggle()
                       
                        
                    }
                    else{
                        //
                        
                        self.message = json["message"].stringValue
                        self.showingAlert = true
                   
                    }
                    
                    
                }
            case let .failure(error):
                print(error)
            }
        }
        
    }
        
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {    return GIDSignIn.sharedInstance.handle(url)
    }

//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//        // ...
//        if let error = error {
//            // ...
//            print(error.localizedDescription)
//            return
//        }
//
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//        Auth.auth().signIn(with: credential){(res, err) in
//            if err != nil {
//                print((err?.localizedDescription)!)
//                return
//            }
//            print("user=" + (res!.user.email)!)
//        }
//    }
    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//        if let error = error {
//            print(error.localizedDescription)
//            return
//        }
//
//        // Access the authentication data directly from 'user' parameter.
//        let authentication = user.authentication
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//
//        Auth.auth().signIn(with: credential) { (res, err) in
//            if let err = err {
//                print(err.localizedDescription)
//                return
//            }
//            print("user=" + (res?.user.email ?? "Unknown"))
//        }
//    }

    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func FacebookLogin() {
        let fbLoginManager = LoginManager()
        fbLoginManager.logOut()
        fbLoginManager.logIn(permissions: premission, from: UIHostingController(rootView: LoginViews())) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                return
            }
            
            guard let _ = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            if result?.isCancelled == true {
                print("User canceled")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    print("asd")
                    return
                }else{
                    print("userdetails",user!)
                    
                    GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email,age_range"]).start(completion: { (connection, result, error) -> Void in
                        if (error == nil){
                            let dict = result as! [String : AnyObject]
                            print(dict)
                            emailstr = dict["email"] as! String
                            print(emailstr)
                            UserDefaults.standard.set(emailstr, forKey: "Smail")
                            UserDefaults.standard.set(dict["name"] as! String, forKey: "Sname")
                            
                            //
                            self.checkuser()
                            
                            if let dict = result as? [String : AnyObject]{
                                if(dict["email"] as? String == nil || dict["id"] as? String == nil || dict["email"] as? String == "" || dict["id"] as? String == "" ){
                                    
                                }
                                else{
                                    
                                }
                            }
                            
                        }else{
                            
                        }
                    })
                }
                
                return
                
            })
        }
    }
    
    
    
   // http://grocery.swadhasoftwares.com/api/home.php
    func checkuser(){
       //{"userid":"sweta.g@mishainfotech.com"}

        var checData: Parameters {
            [
                    "email": emailstr,

                  ]

        }

        print(checData)

        AccountAPI.signin(servciename: "Accounts/CheckUserExist", checData) { res in
               switch res {
               case .success:
                   print("resulllll",res)
                   if let json = res.value{


                       print("Josn",json)
//
                    if(json["message"] == "user doesn't exists")
                    {
                        
                        self.signup()
                       
                    }
                   else if (json["message"] == "User exist!") {
                    UserDefaults.standard.set("yes", forKey: "StatusFb")
                    existornot = "Yes"

                    let userdic = json["data"]
                    let fullName : String = userdic["dateOfBirth"].stringValue
                    let fullNameArr : [String] = fullName.components(separatedBy: "T")
                    let datestr: String = fullNameArr[0]
                
                    UserDefaults.standard.set(userdic["id"].int, forKey: "id")

                    UserDefaults.standard.set(userdic["email"].string, forKey: "email")
                    UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")
                    UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
                    UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
                    UserDefaults.standard.set(datestr, forKey: "dateOfBirth")
                    UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
   
            UserDefaults.standard.set("yes", forKey: "login")
                    showsignupViewafterFB.toggle()

                   } else {

                    }
                    
                   }
               case let .failure(error):
                 print(error)
               }
             }
           }
    func signup() {
       
        var logInFormData: Parameters {
            [
                "userName": "self.googleFirstName",
                "email": "",
                "password": "123456",
                "dateOfBirth": "",
                "profilePictureURL": "",
                "deviceToken":UserDefaults.standard.string(forKey: "devicetoken")!,
                "deviceType": "I",
                "flag" : "F"
                  ]
        
        }
       
            print(logInFormData)

            
                    AccountAPI.signin(servciename: "Accounts/Register", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                           
                           
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                                 
                                let userdic = json["data"]
                                 let fullName : String = userdic["dateOfBirth"].stringValue
                                 let fullNameArr : [String] = fullName.components(separatedBy: "T")
                                 let datestr: String = fullNameArr[0]
                             
                                 UserDefaults.standard.set(userdic["id"].int, forKey: "id")

                                         UserDefaults.standard.set(userdic["email"].string, forKey: "email")
                                        UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")
                                         UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
                                         UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
                                         UserDefaults.standard.set(datestr, forKey: "dateOfBirth")
                                         UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
                         //                UserDefaults.standard.set(userdic["status"].string, forKey: "status")
                         //                UserDefaults.standard.set(userdic["pin"].string, forKey: "pin")
                         //                UserDefaults.standard.set(userdic["wallet"].string, forKey: "wallet")
                                 UserDefaults.standard.set("yes", forKey: "login")
                                UserDefaults.standard.set("No", forKey: "StatusFb")
                                existornot = "No"
                                showsignupViewafterFB.toggle()
                               
                                
                     //                self.logindetails.append(acc)
                     //                print(self.logindetails)
                           
                               
                            }
                            else{
                            //
                             
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
//struct Account1{
//    var id: Int
//    var email: String
//    var name: String
//    var imei: String
//    var ccode: String
//    var mobile: String
//    var rdate: String
//    var password: String
//    var status: String
//    var pin: String
//    var wallet: String
//
//}
    
struct LoginViews_Previews: PreviewProvider {
    static var previews: some View {
        
        LoginViews()
    }
}
class loginObserver: ObservableObject {
    
    var description: String = ""
    
    @Published  var logindetails = [Account]()
  //  @Published  var email =  String()
 //    @Published  var password =  String()
//    @Published  var password =  String()
    
//    @Published  var password = "Temp$123"
    @Published  var email =  "mipl.student@yopmail.com"

//    @Published  var email =  ""
    @Published  var password = ""
//  
    @Published var shouldRedirectToMAINView = false
    @Environment(\.presentationMode) private var presentationmode
    @Published var showNextView = false
    @State var showLoadingAnimation = false
    @Published  var showToast = false
    @Published  var showingAlert = false
    @Published  var message = String()
    var isLoggedin = false

    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return GIDSignIn.sharedInstance.handle(url)
            }

//            func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//              // ...
//              if let error = error {
//                // ...
//                print(error.localizedDescription)
//                return
//              }
//
//              guard let authentication = user.authentication else { return }
//              let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                                accessToken: authentication.accessToken)
//                Auth.auth().signIn(with: credential){(res, err) in
//                    if err != nil {
//                        print((err?.localizedDescription)!)
//                        return
//                    }
//                    print("user=" + (res!.user.email)!)
//                }
//            }
    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//        if let error = error {
//            print(error.localizedDescription)
//            return
//        }
//
//        // Access the authentication data directly from 'user' parameter.
//        let authentication = user.authentication
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//
//        Auth.auth().signIn(with: credential) { (res, err) in
//            if let err = err {
//                print(err.localizedDescription)
//                return
//            }
//            print("user=" + (res?.user.email ?? "Unknown"))
//        }
//    }

            func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
                // Perform any operations when the user disconnects from app here.
                // ...
            }
    
    func login() {

        var logInFormData: Parameters {
            [
                "email": email,
                "password": password,
                "deviceToken":UserDefaults.standard.string(forKey: "devicetoken") ?? "",
                "deviceType": "I"
                
            ]

        }
        print(logInFormData)
 //http://grocery.swadhasoftwares.com/api/profile.php
       
        AccountAPI.signin(servciename: "Authenticate/Login", logInFormData) { res in
        switch res {
        case .success:
            print("resulllll",res)
            if let json = res.value{


                print("Josn",json)
       if (json["status"] == "true")
       {
                let userdic = json["data"]

        
        
        let fullName : String = userdic["dateOfBirth"].stringValue
        let fullNameArr : [String] = fullName.components(separatedBy: "T")
        let datestr: String = fullNameArr[0]
    
           UserDefaults.standard.set(userdic["id"].int, forKey: "id")
           
           UserDefaults.standard.set(userdic["email"].string, forKey: "email")
           UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")
           UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
           UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
           UserDefaults.standard.set(datestr, forKey: "dateOfBirth")
           UserDefaults.standard.set(fullName, forKey: "DateOfBirth")
           UserDefaults.standard.set(userdic["tagLine"].string, forKey: "phoneNumber")
           UserDefaults.standard.set(userdic["totalFriend"].int, forKey: "totalFriend")
           UserDefaults.standard.set(userdic["totalEvent"].int, forKey: "totalEvent")
           
           UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
           UserDefaults.standard.set(userdic["paymentStatus"].string, forKey: "paymentStatus")
           UserDefaults.standard.set(userdic["group"].string, forKey: "group")
           UserDefaults.standard.set(userdic["isanygroup"].string, forKey: "isanygroup")
           
           UserDefaults.standard.set(userdic["packageId"].string, forKey: "packageId")
           UserDefaults.standard.set("yes", forKey: "login")

//                self.logindetails.append(acc)
//                print(self.logindetails)
        self.showNextView.toggle()
       }
       else{
       //
        self.message = json["message"].stringValue
        self.showingAlert = true

      //  @Published  var showingAlert = false

//        AlertToast(displayMode: .alert, type: .regular, title: json["ResponseMsg"].stringValue )
//        AlertToast(displayMode: .alert, type: .regular, title:json["ResponseMsg"].stringValue )

       }
              //  presentationmode(MainView().ondis)


////                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                           self.shouldRedirectToMAINView = true
//                       }

            }
        case let .failure(error):
          print(error)
        }
      }
    }
}

//class GoogleStuff: UIViewController, GIDSignInDelegate, ObservableObject {
//    @Published var showsignupViewaftergoogle : Bool = false //UserDefaults.standard.bool(forKey: "showsignup")
//
//    var googleSignIn = GIDSignIn.sharedInstance
//    var googleId = ""
//    var googleIdToken = ""
//    var googleFirstName = ""
//    var googleLastName = ""
//    var googleEmail = ""
//    var googleProfileURL = ""
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//
//        return GIDSignIn.sharedInstance.handle(url)
//    }
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        print("error",error ?? "")
//        guard user != nil else {
//            print("Uh oh. The user cancelled the Google login.")
//            return
//        }
//
//        print("TOKEN => \(user.authentication.idToken!)")
//        //  print(user)
//
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//        print("credential",credential)
//        Auth.auth().signIn(with: credential){(res, err) in
//            if err != nil {
//                print((err?.localizedDescription)!)
//                return
//            }
//            print("user=", res!)
//
//            //
//            print("user=" + (res!.user.email ?? ""))
//            self.googleEmail = (res!.user.email ?? "")
//            //  self.googleProfileURL = (res!.user.photoURL)
//            self.googleFirstName = (res!.user.displayName ?? "")
//            self.googleProfileURL = res!.user.photoURL!.absoluteString
//
//            //            do {
//            //
//            //                    try  self.googleProfileURL = String(contentsOf: res!.user.photoURL!)
//            //                } catch {
//            //                    print(error)
//            //                }
//
//            UserDefaults.standard.set((res!.user.email), forKey: "Smail")
//            UserDefaults.standard.set((res!.user.displayName), forKey: "Sname")
//
//            //
//            //
//            self.checkuser()
//        }
//
//    }
//
//
//    func signup() {
//
//        var base64String = ""
//        do {
//            let imgData = try NSData(contentsOf: URL.init(string: self.googleProfileURL)!, options: NSData.ReadingOptions())
//            base64String =     String(data: imgData as Data, encoding: .utf8) ?? ""
//
//        } catch {
//
//        }
//
//
//
//        var logInFormData: Parameters {
//            [
//                "userName": self.googleFirstName,
//                "email": self.googleEmail,
//                "password": "123456",
//                "dateOfBirth": "",
//                "profilePictureURL" : base64String ,
//                "deviceToken":UserDefaults.standard.string(forKey: "devicetoken")!,
//                "deviceType": "I",
//                "flag" : "G"
//            ]
//
//        }
//
//        print(logInFormData)
//
//
//        AccountAPI.signin(servciename: "Accounts/Register", logInFormData) { res in
//            switch res {
//            case .success:
//                print("resulllll",res)
//                if let json = res.value{
//
//
//                    print("Josn",json)
//                    if (json["status"] == "true")
//                    {
//
//                        let userdic = json["data"]
//                        let fullName : String = userdic["dateOfBirth"].stringValue
//                        let fullNameArr : [String] = fullName.components(separatedBy: "T")
//                        let datestr: String = fullNameArr[0]
//
//                        UserDefaults.standard.set(userdic["id"].int, forKey: "id")
//
//                        UserDefaults.standard.set(userdic["email"].string, forKey: "email")
//                        UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")
//                        UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
//                        UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
//                        UserDefaults.standard.set(datestr, forKey: "dateOfBirth")
//                        UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
//                        //                UserDefaults.standard.set(userdic["status"].string, forKey: "status")
//                        //                UserDefaults.standard.set(userdic["pin"].string, forKey: "pin")
//                        //                UserDefaults.standard.set(userdic["wallet"].string, forKey: "wallet")
//                        UserDefaults.standard.set("yes", forKey: "login")
//                        UserDefaults.standard.set("No", forKey: "StatusGmail")
//                        self.showsignupViewaftergoogle   = true
//
//
//
//                        //                self.logindetails.append(acc)
//                        //                print(self.logindetails)
//
//
//                    }
//                    else{
//                        //
//
//                        //  @Published  var showingAlert = false
//
//                        //        AlertToast(displayMode: .alert, type: .regular, title: json["ResponseMsg"].stringValue )
//                        //        AlertToast(displayMode: .alert, type: .regular, title:json["ResponseMsg"].stringValue )
//
//                    }
//
//
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//    }
//
//
//
//    //    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//    //
//    //        guard user != nil else {
//    //            print("Uh oh. The user cancelled the Google login.")
//    //            return
//    //        }
//    //
//    //        print("TOKEN => \(user.authentication.idToken!)")
//    //
//    //    }
//
//    func checkuser(){
//        //{"userid":"sweta.g@mishainfotech.com"}
//
//        var checData: Parameters {
//            [
//                "email": googleEmail,
//
//            ]
//
//        }
//
//        print(checData)
//
//        AccountAPI.signin(servciename: "Accounts/CheckUserExist", checData) { res in
//            switch res {
//            case .success:
//                print("resulllll",res)
//                if let json = res.value{
//
//
//                    print("Josn",json)
//                    //
//                    if(json["message"] == "User does not exist!")
//                    {
//                        self.signup()
//                        //                         existornot = "No"
//                        //
//                    }
//                    else if (json["message"] == "User exist!") {
//                        UserDefaults.standard.set("yes", forKey: "StatusGmail")
//                        //  existornot = "Yes"
//
//                        let userdic = json["data"]
//                        let fullName : String = userdic["dateOfBirth"].stringValue
//                        let fullNameArr : [String] = fullName.components(separatedBy: "T")
//                        let datestr: String = fullNameArr[0]
//
//                        UserDefaults.standard.set(userdic["id"].int, forKey: "id")
//
//                        UserDefaults.standard.set(userdic["email"].string, forKey: "email")
//                        UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")
//                        UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
//                        UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
//                        UserDefaults.standard.set(datestr, forKey: "dateOfBirth")
//                        UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
//
//                        UserDefaults.standard.set("yes", forKey: "login")
//                        self.showsignupViewaftergoogle = true
//
//                    } else {
//
//                    }
//
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
//
//    //    func signup() {
//    //        let imgData = image!.pngData()
//    //        let strBase64 = imgData!.base64EncodedString(options: .lineLength64Characters)
//    //
//    //        var logInFormData: Parameters {
//    //            [
//    //                "userName": name,
//    //                  "email": email,
//    //                  "password": password,
//    //                  "dateOfBirth": dob,
//    //                  "profilePictureURL": strBase64,
//    //                "deviceToken":UserDefaults.standard.string(forKey: "devicetoken")!,
//    //                  "deviceType": "I",
//    //                "flag" : "E"
//    //                  ]
//    //
//    //        }
//    //
//    //            print(logInFormData)
//    //
//    //
//    //                    AccountAPI.signin(servciename: "Accounts/Register", logInFormData) { res in
//    //                    switch res {
//    //                    case .success:
//    //                        print("resulllll",res)
//    //                        if let json = res.value{
//    //
//    //
//    //                            print("Josn",json)
//    //                            if (json["status"] == "true")
//    //                            {
//    //                                     let userdic = json["data"]
//    //
//    ////                                     UserDefaults.standard.set(userdic["id"].string, forKey: "id")
//    ////
//    ////                                     UserDefaults.standard.set(userdic["email"].string, forKey: "email")
//    ////                                    UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")
//    ////                                     UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
//    ////                                     UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
//    ////                                     UserDefaults.standard.set(userdic["dateOfBirth"].string, forKey: "dateOfBirth")
//    ////                                     UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
//    ////                     //                UserDefaults.standard.set(userdic["status"].string, forKey: "status")
//    ////                     //                UserDefaults.standard.set(userdic["pin"].string, forKey: "pin")
//    ////                     //                UserDefaults.standard.set(userdic["wallet"].string, forKey: "wallet")
//    ////                             UserDefaults.standard.set("yes", forKey: "login")
//    //
//    //
//    //                                self.showingAlert1.toggle()
//    //                                self.message = json["message"].stringValue
//    //
//    //
//    //                     //                self.logindetails.append(acc)
//    //                     //                print(self.logindetails)
//    //
//    //
//    //                            }
//    //                            else{
//    //                            //
//    //                             self.showingAlert.toggle()
//    //                             self.message = json["message"].stringValue
//    //                           //  @Published  var showingAlert = false
//    //
//    //                     //        AlertToast(displayMode: .alert, type: .regular, title: json["ResponseMsg"].stringValue )
//    //                     //        AlertToast(displayMode: .alert, type: .regular, title:json["ResponseMsg"].stringValue )
//    //
//    //                            }
//    //
//    //
//    //                        }
//    //                    case let .failure(error):
//    //                      print(error)
//    //                    }
//    //                  }
//    //
//    //        }
//
//}
    
    
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
import SwiftUI
import Combine
import CommonCrypto

class TwitterAPI: NSObject, ObservableObject {
    @Published var authorizationSheetIsPresented = false
    @Published var authorizationURL: URL?
    @Published var user: User?
    
    private var tokenCredentials: TokenCredentials?
    
    struct User {
        let ID: String
        let screenName: String
    }
    
    lazy var onOAuthRedirect = PassthroughSubject<URL, Never>()
    
    enum OAuthError: Error {
        case unknown
        case urlError(URLError)
        case httpURLResponse(Int)
        case cannotDecodeRawData
        case cannotParseResponse
        case unexpectedResponse
        case failedToConfirmCallback
    }
    
    struct ClientCredentials {
        
        
        static let APIKey = "JsogaghK7dO5EGYwPyGI650jC"
        static let APIKeySecret = "CdwTiNi8WWH6Ma7JPGdoVJO6RW3B9X2UipvWUoXRBxxncs4JaP"
        static let CallbackURLScheme = "twitterkit-JsogaghK7dO5EGYwPyGI650jC"//"https://mapzapp.firebaseapp.com/__/auth/handler"
    }//https://mapzapp.firebaseapp.com/__/auth/handler
    
    struct TemporaryCredentials {
        let requestToken: String
        let requestTokenSecret: String
    }
    
    struct TokenCredentials {
        let accessToken: String
        let accessTokenSecret: String
    }
    
    private func oAuthSignatureBaseString(httpMethod: String,
                                          baseURLString: String,
                                          parameters: [URLQueryItem]) -> String {
        var parameterComponents: [String] = []
        for parameter in parameters {
            let name = parameter.name.oAuthURLEncodedString
            let value = parameter.value?.oAuthURLEncodedString ?? ""
            parameterComponents.append("\(name)=\(value)")
        }
        let parameterString = parameterComponents.sorted().joined(separator: "&")
        return httpMethod + "&" +
            baseURLString.oAuthURLEncodedString + "&" +
            parameterString.oAuthURLEncodedString
    }
    
    private func oAuthSigningKey(consumerSecret: String,
                                 oAuthTokenSecret: String?) -> String {
        if let oAuthTokenSecret = oAuthTokenSecret {
            return consumerSecret.oAuthURLEncodedString + "&" +
                oAuthTokenSecret.oAuthURLEncodedString
        } else {
            return consumerSecret.oAuthURLEncodedString + "&"
        }
    }
    
    private func oAuthSignature(httpMethod: String,
                                baseURLString: String,
                                parameters: [URLQueryItem],
                                consumerSecret: String,
                                oAuthTokenSecret: String? = nil) -> String {
        let signatureBaseString = oAuthSignatureBaseString(httpMethod: httpMethod,
                                                           baseURLString: baseURLString,
                                                           parameters: parameters)
        
        let signingKey = oAuthSigningKey(consumerSecret: consumerSecret,
                                         oAuthTokenSecret: oAuthTokenSecret)

        return signatureBaseString.hmacSHA1Hash(key: signingKey)
    }
    
    private func oAuthAuthorizationHeader(parameters: [URLQueryItem]) -> String {
        var parameterComponents: [String] = []
        for parameter in parameters {
            let name = parameter.name.oAuthURLEncodedString
            let value = parameter.value?.oAuthURLEncodedString ?? ""
            parameterComponents.append("\(name)=\"\(value)\"")
        }
        return "OAuth " + parameterComponents.sorted().joined(separator: ", ")
    }
    
    func oAuthRequestTokenPublisher() -> AnyPublisher<TemporaryCredentials, OAuthError> {
        let request = (baseURLString: "https://api.twitter.com/oauth/request_token",
                       httpMethod: "POST",
                       consumerKey: ClientCredentials.APIKey,
                       consumerSecret: ClientCredentials.APIKeySecret,
                       callbackURLString: "\(ClientCredentials.CallbackURLScheme)://")
        
        guard let baseURL = URL(string: request.baseURLString) else {
            return Fail(error: OAuthError.urlError(URLError(.badURL)))
                .eraseToAnyPublisher()
        }
        
        var parameters = [
            URLQueryItem(name: "oauth_callback", value: request.callbackURLString),
            URLQueryItem(name: "oauth_consumer_key", value: request.consumerKey),
            URLQueryItem(name: "oauth_nonce", value: UUID().uuidString),
            URLQueryItem(name: "oauth_signature_method", value: "HMAC-SHA1"),
            URLQueryItem(name: "oauth_timestamp", value: String(Int(Date().timeIntervalSince1970))),
            URLQueryItem(name: "oauth_version", value: "1.0")
        ]
        
        let signature = oAuthSignature(httpMethod: request.httpMethod,
                                       baseURLString: request.baseURLString,
                                       parameters: parameters,
                                       consumerSecret: request.consumerSecret)
        
        parameters.append(URLQueryItem(name: "oauth_signature", value: signature))

        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = request.httpMethod
        urlRequest.setValue(oAuthAuthorizationHeader(parameters: parameters),
                            forHTTPHeaderField: "Authorization")

        return
            URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> TemporaryCredentials in
                guard let response = response as? HTTPURLResponse
                else { throw OAuthError.unknown }

                guard response.statusCode == 200
                else { throw OAuthError.httpURLResponse(response.statusCode) }

                guard let parameterString = String(data: data, encoding: .utf8)
                else { throw OAuthError.cannotDecodeRawData }
                
                if let parameters = parameterString.urlQueryItems {
                    guard let oAuthToken = parameters["oauth_token"],
                          let oAuthTokenSecret = parameters["oauth_token_secret"],
                          let oAuthCallbackConfirmed = parameters["oauth_callback_confirmed"]
                    else {
                        throw OAuthError.unexpectedResponse
                    }
                    
                    if oAuthCallbackConfirmed != "true" {
                        throw OAuthError.failedToConfirmCallback
                    }
                    
                    return TemporaryCredentials(requestToken: oAuthToken,
                                                requestTokenSecret: oAuthTokenSecret)
                } else {
                    throw OAuthError.cannotParseResponse
                }
            }
            .mapError { error -> OAuthError in
                switch (error) {
                case let oAuthError as OAuthError:
                    return oAuthError
                default:
                    return OAuthError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    func oAuthAccessTokenPublisher(temporaryCredentials: TemporaryCredentials, verifier: String) -> AnyPublisher<(TokenCredentials, User), OAuthError> {
        let request = (baseURLString: "https://api.twitter.com/oauth/access_token",
                       httpMethod: "POST",
                       consumerKey: ClientCredentials.APIKey,
                       consumerSecret: ClientCredentials.APIKeySecret)
        
        guard let baseURL = URL(string: request.baseURLString) else {
            return Fail(error: OAuthError.urlError(URLError(.badURL)))
                .eraseToAnyPublisher()
        }
        
        var parameters = [
            URLQueryItem(name: "oauth_token", value: temporaryCredentials.requestToken),
            URLQueryItem(name: "oauth_verifier", value: verifier),
            URLQueryItem(name: "oauth_consumer_key", value: request.consumerKey),
            URLQueryItem(name: "oauth_nonce", value: UUID().uuidString),
            URLQueryItem(name: "oauth_signature_method", value: "HMAC-SHA1"),
            URLQueryItem(name: "oauth_timestamp", value: String(Int(Date().timeIntervalSince1970))),
            URLQueryItem(name: "oauth_version", value: "1.0")
        ]
        
        let signature = oAuthSignature(httpMethod: request.httpMethod,
                                       baseURLString: request.baseURLString,
                                       parameters: parameters,
                                       consumerSecret: request.consumerSecret,
                                       oAuthTokenSecret: temporaryCredentials.requestTokenSecret)
        
        parameters.append(URLQueryItem(name: "oauth_signature", value: signature))
        
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = request.httpMethod
        urlRequest.setValue(oAuthAuthorizationHeader(parameters: parameters),
                            forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> (TokenCredentials, User) in
                guard let response = response as? HTTPURLResponse
                else { throw OAuthError.unknown }
                
                guard response.statusCode == 200
                else { throw OAuthError.httpURLResponse(response.statusCode) }
                
                guard let parameterString = String(data: data, encoding: .utf8)
                else { throw OAuthError.cannotDecodeRawData }
                
                if let parameters = parameterString.urlQueryItems {
                    guard let oAuthToken = parameters.value(for: "oauth_token"),
                          let oAuthTokenSecret = parameters.value(for: "oauth_token_secret"),
                          let userID = parameters.value(for: "user_id"),
                          let screenName = parameters.value(for: "screen_name")
                    else {
                        throw OAuthError.unexpectedResponse
                    }
                    
                    return (TokenCredentials(accessToken: oAuthToken,
                                            accessTokenSecret: oAuthTokenSecret),
                            User(ID: userID,
                                 screenName: screenName))
                } else {
                    throw OAuthError.cannotParseResponse
                }
            }
            .mapError { error -> OAuthError in
                switch (error) {
                case let oAuthError as OAuthError:
                    return oAuthError
                default:
                    return OAuthError.unknown
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private var subscriptions: [String: AnyCancellable] = [:]
    
    func authorize() {
        guard !self.authorizationSheetIsPresented else { return }
        self.authorizationSheetIsPresented = true
        
        self.subscriptions["oAuthRequestTokenSubscriber"] =
            self.oAuthRequestTokenPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: ()
                case .failure(_):
                    // Handle Errors
                    self.authorizationSheetIsPresented = false
                }
                self.subscriptions.removeValue(forKey: "oAuthRequestTokenSubscriber")
            }, receiveValue: { [weak self] temporaryCredentials in
                guard let self = self else { return }
                
                guard let authorizationURL = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(temporaryCredentials.requestToken)")
                else { return }
                
                self.authorizationURL = authorizationURL
                
                self.subscriptions["onOAuthRedirect"] =
                    self.onOAuthRedirect
                    .sink(receiveValue: { [weak self] url in
                        guard let self = self else { return }
                        
                        self.subscriptions.removeValue(forKey: "onOAuthRedirect")

                        self.authorizationSheetIsPresented = false
                        self.authorizationURL = nil
                        
                        if let parameters = url.query?.urlQueryItems {
                            guard let oAuthToken = parameters["oauth_token"],
                                  let oAuthVerifier = parameters["oauth_verifier"]
                            else {
                                // Handle error for unexpected response
                                
                                return
                            }
                            
                            if oAuthToken != temporaryCredentials.requestToken {
                                // Handle error for tokens do not match
                                return
                            }
                            
                            self.subscriptions["oAuthAccessTokenSubscriber"] =
                                self.oAuthAccessTokenPublisher(temporaryCredentials: temporaryCredentials,
                                                               verifier: oAuthVerifier)
                                .receive(on: DispatchQueue.main)
                                .sink(receiveCompletion: { _ in
                                    // Error handler
                                }, receiveValue: { [weak self] (tokenCredentials, user) in
                                    guard let self = self else { return }
                                    
                                    self.subscriptions.removeValue(forKey: "oAuthRequestTokenSubscriber")
                                    self.subscriptions.removeValue(forKey: "onOAuthRedirect")
                                    self.subscriptions.removeValue(forKey: "oAuthAccessTokenSubscriber")
                                    
                                    self.tokenCredentials = tokenCredentials
                                    self.user = user
                                })
                        }
                    })
            })
    }
}

extension String {
    func hmacSHA1Hash(key: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1),
               key,
               key.count,
               self,
               self.count,
               &digest)
        return Data(digest).base64EncodedString()
    }
}

extension CharacterSet {
    static var urlRFC3986Allowed: CharacterSet {
        CharacterSet(charactersIn: "-_.~").union(.alphanumerics)
    }
}

extension String {
    var oAuthURLEncodedString: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlRFC3986Allowed) ?? self
    }
}

extension String {
    var urlQueryItems: [URLQueryItem]? {
        URLComponents(string: "://?\(self)")?.queryItems
    }
}

extension Array where Element == URLQueryItem {
    func value(for name: String) -> String? {
        return self.filter({$0.name == name}).first?.value
    }
    
    subscript(name: String) -> String? {
        return value(for: name)
    }
}
import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    class SafariViewControllerWrapper: UIViewController {
        private var safariViewController: SFSafariViewController?
        
        var url: URL? {
            didSet {
                if let safariViewController = safariViewController {
                    safariViewController.willMove(toParent: self)
                    safariViewController.view.removeFromSuperview()
                    safariViewController.removeFromParent()
                    self.safariViewController = nil
                }
                
                guard let url = url else { return }
                
                let newSafariViewController = SFSafariViewController(url: url)
                addChild(newSafariViewController)
                newSafariViewController.view.frame = view.frame
                view.addSubview(newSafariViewController.view)
                newSafariViewController.didMove(toParent: self)
                self.safariViewController = newSafariViewController
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.url = nil
        }
    }
    
    typealias UIViewControllerType = SafariViewControllerWrapper

    @Binding var url: URL?

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SafariViewControllerWrapper {
        return SafariViewControllerWrapper()
    }

    func updateUIViewController(_ safariViewControllerWrapper: SafariViewControllerWrapper,
                                context: UIViewControllerRepresentableContext<SafariView>) {
        safariViewControllerWrapper.url = url
    }
}
class AuthenticationViewModel: NSObject, ObservableObject {

  // 1
  enum SignInState {
    case signedIn
    case signedOut
  }

  // 2
  @Published var state: SignInState = .signedOut
    @Published var showsignupViewaftergoogle : Bool = false //UserDefaults.standard.bool(forKey: "showsignup")

  // 3
  override init() {
    super.init()

   // setupGoogleSignIn()
  }

  // 4
//  func signIn() {
//      if GIDSignIn.sharedInstance.currentUser == nil {
//          GIDSignIn.sharedInstance.presentingViewController = UIApplication.shared.windows.first?.rootViewController
//          GIDSignIn.sharedInstance.signIn(withPresenting: UIViewController)
//      }
//  }

  // 5
  func signOut() {
    GIDSignIn.sharedInstance.signOut()

    do {
      try Auth.auth().signOut()

      state = .signedOut
    } catch let signOutError as NSError {
      print(signOutError.localizedDescription)
    }
  }

  // 6
//  private func setupGoogleSignIn() {
//      GIDSignIn.sharedInstance.delegate = self
//  }
}
//extension AuthenticationViewModel: GIDSignInDelegate {
//
//  // 1
//
//  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//    if error == nil {
//      firebaseAuthentication(withUser: user)
//    } else {
//      print(error.debugDescription)
//    }
//  }
//
//  // 2
//  private func firebaseAuthentication(withUser user: GIDGoogleUser) {
//    if let authentication = user.authentication {
//      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//
//      Auth.auth().signIn(with: credential) { (_, error) in
//        if let error = error {
//          print(error.localizedDescription)
//        } else {
//          self.state = .signedIn
//            self.checkuser()
//      // print(user?.profile.name ?? "")
//        }
//      }
//    }
//  }
//
//    func signup() {
//        let user = GIDSignIn.sharedInstance.currentUser
//        var base64String = ""
//        do {
//            let imgData = try NSData(contentsOf: (user?.profile?.imageURL(withDimension: 200)!)!, options: NSData.ReadingOptions())
//
//
//            base64String = String(data: imgData as Data, encoding: .utf8) ?? ""
//
//        } catch {
//
//        }
//
//
//
//        var logInFormData: Parameters {
//            [
//                "userName": user?.profile?.name ?? "",
//                "email": user?.profile?.email ?? "",
//                "password": "123456",
//                "dateOfBirth": "",
//                "profilePictureURL" : base64String ,
//                "deviceToken":UserDefaults.standard.string(forKey: "devicetoken")!,
//                "deviceType": "I",
//                "flag" : "G"
//                  ]
//
//        }
//
//            print(logInFormData)
//
//
//                    AccountAPI.signin(servciename: "Accounts/Register", logInFormData) { res in
//                    switch res {
//                    case .success:
//                        print("resulllll",res)
//                        if let json = res.value{
//
//
//                            print("Josn",json)
//                            if (json["status"] == "true")
//                            {
//
//                                let userdic = json["data"]
//                                 let fullName : String = userdic["dateOfBirth"].stringValue
//                                 let fullNameArr : [String] = fullName.components(separatedBy: "T")
//                                 let datestr: String = fullNameArr[0]
//
//                                 UserDefaults.standard.set(userdic["id"].int, forKey: "id")
//
//                                         UserDefaults.standard.set(userdic["email"].string, forKey: "email")
//                                        UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")
//                                         UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
//                                         UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
//                                         UserDefaults.standard.set(datestr, forKey: "dateOfBirth")
//                                         UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
//                         //                UserDefaults.standard.set(userdic["status"].string, forKey: "status")
//                         //                UserDefaults.standard.set(userdic["pin"].string, forKey: "pin")
//                         //                UserDefaults.standard.set(userdic["wallet"].string, forKey: "wallet")
//                                 UserDefaults.standard.set("yes", forKey: "login")
//                                UserDefaults.standard.set("No", forKey: "StatusGmail")
//                                self.showsignupViewaftergoogle   = true
//
//
//
//                     //                self.logindetails.append(acc)
//                     //                print(self.logindetails)
//
//
//                            }
//                            else{
//                            //
//
//                           //  @Published  var showingAlert = false
//
//                     //        AlertToast(displayMode: .alert, type: .regular, title: json["ResponseMsg"].stringValue )
//                     //        AlertToast(displayMode: .alert, type: .regular, title:json["ResponseMsg"].stringValue )
//
//                            }
//
//
//                        }
//                    case let .failure(error):
//                      print(error)
//                    }
//                  }
//
//        }
//
//
//
////    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
////
////        guard user != nil else {
////            print("Uh oh. The user cancelled the Google login.")
////            return
////        }
////
////        print("TOKEN => \(user.authentication.idToken!)")
////
////    }
//
//    func checkuser(){
//        //{"userid":"sweta.g@mishainfotech.com"}
//        let user = GIDSignIn.sharedInstance.currentUser
//
//        var checData: Parameters {
//            [
//                "email": user?.profile?.email ?? "",
//
//            ]
//
//        }
//
//        print(checData)
//
//        AccountAPI.signin(servciename: "Accounts/CheckUserExist", checData) { res in
//            switch res {
//            case .success:
//                print("resulllll",res)
//                if let json = res.value{
//
//
//                    print("Josn",json)
//                    //
//                    if(json["message"] == "User does not exist!")
//                    {
//                        self.signup()
//                        //                         existornot = "No"
//                        //
//                    }
//                    else if (json["message"] == "User exist!") {
//                        UserDefaults.standard.set("yes", forKey: "StatusGmail")
//                        //  existornot = "Yes"
//
//                        let userdic = json["data"]
//                        let fullName : String = userdic["dateOfBirth"].stringValue
//                        let fullNameArr : [String] = fullName.components(separatedBy: "T")
//                        let datestr: String = fullNameArr[0]
//
//                        UserDefaults.standard.set(userdic["id"].int, forKey: "id")
//
//                        UserDefaults.standard.set(userdic["email"].string, forKey: "email")
//                        UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")
//                        UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
//                        UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
//                        UserDefaults.standard.set(datestr, forKey: "dateOfBirth")
//                        UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
//
//                        UserDefaults.standard.set("yes", forKey: "login")
//                        self.showsignupViewaftergoogle = true
//
//                    } else {
//
//                    }
//
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
//}
