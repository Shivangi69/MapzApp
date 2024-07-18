//
//  SignUpViews.swift
//  Indemart
//
//  Created by Misha Infotech on 29/06/2021.
//struct DatePickerWithButtons_Previews: PreviewProvider {


import SwiftUI
import Alamofire
//import Firebase
//import GoogleSignIn
import SimpleToast
struct SignUpViews: View {
    @State var showImagePicker: Bool = false
    @State var image = UIImage(named: "male-user")
    @State private var showingActionSheet = false
    @State var cmrstr = String()
    @State private var showSheet = false

    @State var showNextView = false
    @State var selectedDate = Date()

   // let googleSignIn = GIDSignIn.sharedInstance()
   // @ObservedObject var myGoogle = GoogleStuff1()
    @State private var signedIn = false

    @State var showDatePicker: Bool = false
        @State var savedDate: Date? = nil

    
    @State  var name: String = UserDefaults.standard.string(forKey: "Sname") ?? ""
    @State  var email: String = UserDefaults.standard.string(forKey: "Smail") ?? ""
    @State  var code: String = "+91"
    @State  var mobile: String = ""
    @State  var dob: String = "1982-09-01T09:53:26.672Z"
    @State  var showingAlert = false
    @State  var showingAlert1 = false
    @FocusStateLegacy var focusedField: FormFields1?
    @State  var message = String()
    @Environment(\.presentationMode) var presentationMode
   // @StateObject var viewModel1 = ViewModelSignup()

    @State  var password: String = ""
    @State  var cpassword: String = ""

    
    
    private let toastOptions = SimpleToastOptions(
        alignment: .bottom, hideAfter: 5, showBackdrop: false
        
    )
    
    
    var body: some View {
        
        ZStack {
           //
            ScrollView{
                
                
                ZStack{
                    
                    VStack{
                        Image("Group 1649")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                      
                    }
                   // .padding(.all, 10.0)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .background(Color("blackcolor") .ignoresSafeArea(.all, edges: .all))
                
                    VStack{
                        Spacer(minLength: 20)
                           HStack(spacing: 20.0) {
                               Button(action: {
                                focusedField = nil

                                  presentationMode.wrappedValue.dismiss()
                               }) {
                                  Image("backIcon")
                                       .resizable()
                                       
                                       .aspectRatio(contentMode: .fit)
                                   
                               }
                              Spacer()
                             
                           }
                           .padding([.top, .leading, .trailing], 15.0)
                           //.padding(.leading, 20.0)
                          // .padding(.top,10)
                           .frame(width: UIScreen.main.bounds.width,height: 50.0)
                           .contentShape(Rectangle())
                           .onTapGesture {
                            focusedField = nil

                              presentationMode.wrappedValue.dismiss()
                           }
                VStack(alignment: .center, spacing: 30.0 ) {
                   //
//                    Spacer(minLength: 05)
//                       HStack(spacing: 20.0) {
//                           Button(action: {
//                              presentationMode.wrappedValue.dismiss()
//                           }) {
//                              Image("backIcon")
//                                   .resizable()
//                                   
//                                   .aspectRatio(contentMode: .fit)
//                               
//                           }
//                          Spacer()
//                         
//                       }
//                       .padding(.leading, 20.0)
//                      // .padding(.top,10)
//                       .frame(height: 32.0)
//                    
                     Image("logo")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 200, height: 140, alignment: .center)
                   
                    HStack {
                        Image("User Name")
                            .foregroundColor(Color.white)
                        TextField("Username", text: $name).foregroundColor(Color.white)
                            .focusedLegacy($focusedField, equals: .username)

                            .onReceive(name.publisher.last()) { (output) in
                               
                                let filtered = name.filter { _ in "0123456789qwertyuiopasdfghjklmnbvcxz AQWERTYUIOPLKJHGFDSZXCVBNM".contains(output) }
                                                if filtered != name {
                                                   
                                                    name =    String(self.name.dropLast())
                                                }
                                if (output == " "){
                                    name =    String(self.name.dropLast())
                                }
                                            
//                                                if self.name.count>6{ //set count as you want
//                                                    self.name = String(self.name.dropLast())
//                                                }
                                print(output)
                                        }
                            .font(.custom("Muli-Bold", size: 18))
                            .placeholder(when: name.isEmpty) {
                                Text("Username").foregroundColor(.white)
                                    .font(.custom("Muli-Bold", size: 18))

                            }
                       // Spacer()
                
                       

                    }
                    .padding()
                    .frame(width: (UIScreen.main.bounds.width - 60),height: 60)

                    .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                    
                    HStack {
                        Image("user email")
                            .foregroundColor(Color.white)
                        TextField("Email Address", text: $email).foregroundColor(Color.white)
                            .font(.custom("Muli-Bold", size: 18))
                            .focusedLegacy($focusedField, equals: .Email)

                            .placeholder(when: email.isEmpty) {
                                Text("Email Address").foregroundColor(.white)
                                    .font(.custom("Muli-Bold", size: 18))

                            }
                       // Spacer()
                       

                    }
                    .padding()
                    .frame(width: (UIScreen.main.bounds.width - 60),height: 60)

                    .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                    
                    
//                    HStack {
////
////                        TextField("Date of Birth", text: $dob).foregroundColor(Color.white)
////                            .placeholder(when: dob.isEmpty) {
////                                Text("Date of Birth").foregroundColor(.white)
////
////                            }
//                        Image( "Dob")
//                            .foregroundColor(Color.white)
//                        Text(savedDate?.description ?? "Date of Birth")
//                            .foregroundColor(.white)
//
//                            .font(.custom("Muli-Bold", size: 17))
//                            .onTapGesture {
//                                showDatePicker.toggle()
//
//                            }
//
//                     //   Spacer()
//
//
//                    }
                    .padding()
                    .frame(width: (UIScreen.main.bounds.width - 60),height: 60)

                    .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                    
                    HStack {
                        Image( "Password")
                            .foregroundColor(Color.white)
                        SecureField("Password", text: $password)
                            .font(.custom("Muli-Bold", size: 18))
                            .focusedLegacy($focusedField, equals: .password)

                            .foregroundColor(Color.white)
                            .placeholder(when: password.isEmpty) {
                                Text("Password").foregroundColor(.white)
                                    .font(.custom("Muli-Bold", size: 18))

                            }
                        
                    //    Spacer()
                        

                    }
                    .padding()
                    .frame(width: (UIScreen.main.bounds.width - 60),height: 60)

                    .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                    
                   
                    
                    HStack {
                        Image( "Password")
                            .foregroundColor(Color.white)
                        SecureField("Confirm Password", text: $cpassword)
                            .font(.custom("Muli-Bold", size: 18))
                            .foregroundColor(.white)
                            .focusedLegacy($focusedField, equals: .cpassword)

                            .placeholder(when: cpassword.isEmpty) {
                                Text("Confirm Password").foregroundColor(.white)
                                    .font(.custom("Muli-Bold", size: 18))

                            }
                      //  Spacer()
                       
                    }
                    .padding()
                    .frame(width: (UIScreen.main.bounds.width - 60),height: 60)

                    .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                    
                       
                    Button("SIGN UP"){
                      //  obs.ForgotPwd()
//
                        UIApplication.dismissKeyboard()

                        focusedField = nil

                        if (name == "")
                        {
    
                            message = "Please Enter Username!"
    
                            showingAlert = true
    
                            return

                        }
                        if (email == "")
                        {
    
                            message = "Please Enter Email!"
    
                            showingAlert = true
    
                            return

                        }
                        if self.textFieldValidatorEmail(self.email) {
                                           
                        }else{
                            message = "Please Enter Valid Email!"
    
                            showingAlert = true
    
                            return

                        }
//                        if (email == "")
//                        {
//
//                            message = "Please Enter Email!"
//
//                            showingAlert = true
//
//                            return
//
//                        }
//
                        if (password == "")
                        {
    
                            message = "Please Enter Password!"//
                            showingAlert = true
    
                            return

                        }
                        if (cpassword == "")
                        {
    
                            message = "Please Enter Confirm Password!"//
                            showingAlert = true
                            return

                        }
                        if ((password != cpassword))
                        {
    
                            message = "Password Should be same as Confirm Password!"//
                            showingAlert = true
                            return

                        }
                        signup()
//                        if (mobile.count > 10)
//                        {
//
//                            message = "Please Enter Valid Mobile No!"//
//                            showingAlert.toggle()
//
//                            return
//
//                        }
//                        if (code == "")
//                        {
//
//                            message = "Please Enter Mobile Code!"//
//                            showingAlert.toggle()
//
//                            return
//
//                        }
                        
//                        self.viewModel1.sendCode(phone: mobile, password: password, name: name, ccode: code, email: email)
//
                        
                    }.font(.custom("Muli-Bold", size: 22))
                    .foregroundColor(Color.white)
                    .frame(width:UIScreen.main.bounds.width - 60 ,height: 60)
                    .background(Color("redColor"))
                    .cornerRadius(30)
                    .fullScreenCover(isPresented: $showNextView, content: LoginViews.init)
                    .onTapGesture {
                        //  obs.ForgotPwd()
  //
                          UIApplication.dismissKeyboard()

                        focusedField = nil

                          if (name == "")
                          {
      
                              message = "Please Enter Username!"
      
                              showingAlert = true
      
                              return

                          }
                          if (email == "")
                          {
      
                              message = "Please Enter Email!"
      
                              showingAlert = true
      
                              return

                          }
                          if self.textFieldValidatorEmail(self.email) {
                                             
                          }else{
                              message = "Please Enter Valid Email!"
      
                              showingAlert = true
      
                              return

                          }
  //                        if (email == "")
  //                        {
  //
  //                            message = "Please Enter Email!"
  //
  //                            showingAlert = true
  //
  //                            return
  //
  //                        }
  //
                          if (password == "")
                          {
      
                              message = "Please Enter Password!"//
                              showingAlert = true
      
                              return

                          }
                          if (cpassword == "")
                          {
      
                              message = "Please Enter Confirm Password!"//
                              showingAlert = true
                              return

                          }
                          if ((password != cpassword))
                          {
      
                              message = "Password Should be same as Confirm Password!"//
                              showingAlert = true
                              return

                          }
                          signup()
  //                        if (mobile.count > 10)
  //                        {
  //
  //                            message = "Please Enter Valid Mobile No!"//
  //                            showingAlert.toggle()
  //
  //                            return
  //
  //                        }
  //                        if (code == "")
  //                        {
  //
  //                            message = "Please Enter Mobile Code!"//
  //                            showingAlert.toggle()
  //
  //                            return
  //
  //                        }
                          
  //                        self.viewModel1.sendCode(phone: mobile, password: password, name: name, ccode: code, email: email)
  //
                          
                      }
                    .alert(isPresented: $showingAlert) {
                                Alert(title: Text(""), message: Text(message), dismissButton: .default(Text("Ok!")))
                            }
                    .alert(isPresented:$showingAlert1) {
                                Alert(
                                    title: Text(""),
                                    message: Text(message),
                                    primaryButton: .destructive(Text("Ok")) {
                                        print("Deleting...")
                                        self.showNextView.toggle()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                    
                   
                    Spacer()

        
               
                }.padding(.horizontal, 5.0)
                    }.ignoresSafeArea(.all, edges: .all)
                }
//                /.background(Color("blackcolor") .ignoresSafeArea(.all, edges: .all))
           
//            if showDatePicker {
//                           DatePickerWithButtons(showDatePicker: $showDatePicker, savedDate: $savedDate, selectedDate: savedDate ?? Date())
//                               .animation(.linear)
//                               .transition(.opacity)
//
                
            }                           .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)

                            .ignoresSafeArea(.all, edges: .all)
            .simpleToast(isPresented: $showingAlert, options: toastOptions) {
                   HStack {
                       
                       Text(message)
                   }
                   .padding()
                   .background(Color.red.opacity(0.8))
                   .foregroundColor(Color.white)
                   .cornerRadius(10)
               }
        }
    }
    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    func signup() {
        
        var logInFormData: Parameters {
            [
                "Name": name,
                  "Email": email,
                  "Password": password,
                "deviceToken":UserDefaults.standard.string(forKey: "devicetoken")!,
                  "deviceType": "I",
                "Flag":"E",
               ]
            
        }
       
            print(logInFormData)
//Account/Register
            
                    AccountAPI.signin(servciename: "Account/Register", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                           
                           
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                                     let userdic = json["data"]

//                                     UserDefaults.standard.set(userdic["id"].string, forKey: "id")
//
//                                     UserDefaults.standard.set(userdic["email"].string, forKey: "email")
//                                    UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")
//                                     UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
//                                     UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
//                                     UserDefaults.standard.set(userdic["dateOfBirth"].string, forKey: "dateOfBirth")
//                                     UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
//                     //                UserDefaults.standard.set(userdic["status"].string, forKey: "status")
//                     //                UserDefaults.standard.set(userdic["pin"].string, forKey: "pin")
//                     //                UserDefaults.standard.set(userdic["wallet"].string, forKey: "wallet")
//                             UserDefaults.standard.set("yes", forKey: "login")

                                
                               //
                               // if  (self.message == "Registration successfully!"){
                                    self.showingAlert1.toggle()
                                    self.message = json["message"].stringValue
                              //  }
//                                else{
//                                    self.showingAlert.toggle()
//                                }
                               
                                
                     //                self.logindetails.append(acc)
                     //                print(self.logindetails)
                           
                               
                            }
                            else{
                            //
                             self.showingAlert.toggle()
                             self.message = json["message"].stringValue
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

struct SignUpViews_Previews: PreviewProvider {
    static var previews: some View {
        SignUpViews()
    }
}

public struct ImagePickerView: UIViewControllerRepresentable {

    private let sourceType: UIImagePickerController.SourceType
    private let onImagePicked: (UIImage) -> Void
    @Environment(\.presentationMode) private var presentationMode

    public init(sourceType: UIImagePickerController.SourceType, onImagePicked: @escaping (UIImage) -> Void) {
        self.sourceType = sourceType
        self.onImagePicked = onImagePicked
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
       // picker.allowsEditing = true
        
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onDismiss: { self.presentationMode.wrappedValue.dismiss() },
            onImagePicked: self.onImagePicked
        )
    }

    final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        private let onDismiss: () -> Void
        private let onImagePicked: (UIImage) -> Void

        init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
            self.onDismiss = onDismiss
            self.onImagePicked = onImagePicked
        }

       
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.onImagePicked(image)
            }else if let image = info[.editedImage] as? UIImage {
                self.onImagePicked(image)
            }
            self.onDismiss()
        }

        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
            self.onDismiss()
        }

    }

}
//class GoogleStuff1: UIViewController, GIDSignInDelegate, ObservableObject {
//    @Published var showsignupViewaftergoogle : Bool = false //UserDefaults.standard.bool(forKey: "showsignup")
//
//    var googleSignIn = GIDSignIn.sharedInstance()
//    var googleId = ""
//    var googleIdToken = ""
//    var googleFirstName = ""
//    var googleLastName = ""
//    var googleEmail = ""
//    var googleProfileURL = ""
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//
//        guard user != nil else {
//            print("Uh oh. The user cancelled the Google login.")
//            return
//        }
//
//        print("TOKEN => \(user.authentication.idToken!)")
//        print("TOKEN => \(user.authentication.idToken!)")
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                          accessToken: authentication.accessToken)
//          Auth.auth().signIn(with: credential){(res, err) in
//              if err != nil {
//                  print((err?.localizedDescription)!)
//                  return
//              }
//              print("user=" + (res!.user.email)!)
//            self.googleEmail = (res!.user.email)!
//            self.googleFirstName = (res!.user.displayName)!
//            self.googleProfileURL = res!.user.photoURL!.absoluteString
//            UserDefaults.standard.set((res!.user.email), forKey: "Smail")
//            UserDefaults.standard.set((res!.user.displayName), forKey: "Sname")
//
//            self.checkuser()
//          }
//
//    }
//
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//
//        guard user != nil else {
//            print("Uh oh. The user cancelled the Google login.")
//            return
//        }
//
//        print("TOKEN => \(user.authentication.idToken!)")
//
//    }
//    func signup() {
//
//        var base64String = ""
//        do {
//              let imgData = try NSData(contentsOf: URL.init(string: self.googleProfileURL)!, options: NSData.ReadingOptions())
//
//
//
//
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
//                  "password": "123456",
//                  "dateOfBirth": "",
//                "profilePictureURL" : base64String ,
//                "deviceToken":UserDefaults.standard.string(forKey: "devicetoken")!,
//                  "deviceType": "I",
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
//                                self.showsignupViewaftergoogle.toggle()
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
//    func checkuser(){
//       //{"userid":"sweta.g@mishainfotech.com"}
//
//        var checData: Parameters {
//            [
//                    "userid": googleEmail,
//
//                  ]
//
//        }
//
//
//               AccountAPI.signin(servciename: "check_user.php", checData) { res in
//               switch res {
//               case .success:
//                   print("resulllll",res)
//                   if let json = res.value{
//
//                    print("11",self.showsignupViewaftergoogle)
//
//                       print("Josn",json)
////
//
//                    if(json["ResponseMsg"] == "user doesn't exists")
//                    {
//                        self.signup()
//
//                    }
//                   else if (json["ResponseMsg"] == "Login successfully!") {
//                    UserDefaults.standard.set("yes", forKey: "StatusGoogle")
//
//                    let userdic = json["user"]
//                    UserDefaults.standard.set(userdic["id"].int, forKey: "id")
//
//                    UserDefaults.standard.set(userdic["email"].string, forKey: "email")
//                   UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")
//                    UserDefaults.standard.set(userdic["password"].string, forKey: "password")
//                    UserDefaults.standard.set(userdic["mobile"].string, forKey: "mobile")
//                    UserDefaults.standard.set(userdic["rdate"].string, forKey: "rdate")
//                    UserDefaults.standard.set(userdic["imei"].string, forKey: "imei")
//                    UserDefaults.standard.set(userdic["ccode"].string, forKey: "ccode")
//                    UserDefaults.standard.set(userdic["status"].string, forKey: "status")
//                    UserDefaults.standard.set(userdic["pin"].string, forKey: "pin")
//                    UserDefaults.standard.set(userdic["wallet"].string, forKey: "wallet")
//               //\
//                    UserDefaults.standard.set("yes", forKey: "login")
//
//                    UserDefaults.standard.set(true, forKey: "showsignup")
//                    print("1",self.showsignupViewaftergoogle)
//                    self.showsignupViewaftergoogle =                     UserDefaults.standard.bool(forKey: "showsignup")
//                  //  self.showsignupViewaftergoogle.toggle()
//                   //
//
//
//print("111",self.showsignupViewaftergoogle)
//                   } else {
//
//                    }
//                     //  presentationmode(MainView().ondis)
//
//
//       ////                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//       //                           self.shouldRedirectToMAINView = true
//       //                       }
//
//                   }
//               case let .failure(error):
//                 print(error)
//               }
//             }
//           }
//
//}
enum FormFields1 {
    case username, Email, password, cpassword
}
extension FormFields1: FocusStateCompliant {

    static var last: FormFields1 {
        .cpassword
    }

    var next: FormFields1? {
        switch self {
        case .username:
            return .Email
        case .Email:
            return .password
        case .password:
            return .cpassword
//        case .cpassword:
//            return .password
//        case .password:
//            return .password
        default: return nil
        }
    }
}
