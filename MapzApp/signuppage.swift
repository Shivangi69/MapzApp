//
//  signuppage.swift
//  MapzApp
//
//  Created by Misha Infotech on 24/11/2021.
//

import SwiftUI
import SwiftUI
import Alamofire
//import Firebase
//import GoogleSignIn
import SimpleToast

import FBSDKLoginKit
import Firebase
import GoogleSignIn
import SimpleToast
import FirebaseAuth
struct signuppage: View {
    @State var showImagePicker: Bool = false
    @State var image = UIImage(named: "male-user")
    @State private var showingActionSheet = false
    @State var cmrstr = String()
    @State private var showSheet = false
    @StateObject var viewModel = AuthenticationViewModel()
    
    @State var showNextView = false
    @State var selectedDate = Date()
    
    // let googleSignIn = GIDSignIn.sharedInstance()
    // @ObservedObject var myGoogle = GoogleStuff1()
    @State private var signedIn = false
    
    @State var showDatePicker: Bool = false
    @State var savedDate: Date? = nil
    @State var savedDatestr : String? = nil
    @State var savedDatestrsee : String? = nil
    
    
    
    @State  var name: String = UserDefaults.standard.string(forKey: "Sname") ?? ""
    @State  var email: String = UserDefaults.standard.string(forKey: "Smail") ?? ""
    @State  var code: String = "+91"
    @State  var mobile: String = ""
    @State  var dob: String = ""//"1982-09-01T09:53:26.672Z"
    @State  var showingAlert = false
    @State  var showingAlert1 = false
    
    @State  var message = String()
    @Environment(\.presentationMode) var presentationMode
    // @StateObject var viewModel1 = ViewModelSignup()
    
    @State  var password: String = ""
    @State  var cpassword: String = ""
    @State  var tagline: String = ""
    
    private let premission = ["public_profile", "email"] //added
    @State   var emailstr : String = ""
    @State   var existornot : String = ""
    @State var showsignupViewafterFB = false
    
    private let toastOptions = SimpleToastOptions(
        alignment: .bottom, hideAfter: 5, showBackdrop: false
        
    )
    
    @State var heightplus : CGFloat = 35
    
    
    var body: some View {
        
        ZStack {
     
            VStack{
                
                //                Spacer()
                //                    .frame(height :heightplus)
                
                HStack {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("icons8-back-24")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                        //.aspectRatio(contentMode: .fit)
                        
                    }
                    
                    Spacer()
                    
                }
                .padding()
                .padding(.top,10)
                .frame(width: UIScreen.main.bounds.width,height: 50)
                .background(Color("themecolor 1"))
                
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    
                    ZStack{
                        
                        //                    VStack{
                        //                        Image("Group 1649")
                        //                            .resizable()
                        //                            .aspectRatio(contentMode: .fill)
                        //                            //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                        //                            .ignoresSafeArea(.all, edges: .all)
                        //                    }
                        
                        VStack(alignment: .center, spacing: 20.0 ){
                            
                            VStack(alignment: .center, spacing: 20.0 ) {
                                // Spacer(minLength: 50)
                                Image("logo")
                                    .resizable()
                                //
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60, alignment: .center)
                                
                                Text("Please Create your account.")
                                    .lineLimit(2)
                                    .foregroundColor(.white)
                                    .font(.custom("Inter-Bold", size: 20))
                                    .multilineTextAlignment(.center)
                                    .frame(width: 300, height: 35 , alignment:.center)
                                
                            }
                            VStack(alignment: .center, spacing: 20.0 ) {
                                
                                HStack(alignment: .center, spacing: 20.0) {
                                    
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
                                                }
                                            }
                                        }
                                    
                                    Text("Choose your Profile Picture")
                                        .foregroundColor(.white)
                                    
                                        .font(.custom("Inter-Regular", size: 17))
                                    
                                    Spacer()
                                    
                                }.frame( width: UIScreen.main.bounds.width - 60, height: 70)
                                
                                //Spacer(minLength: 20)
                                
                                HStack {
                                    
                                    TextField("Name", text: $name).foregroundColor(Color.white)
                                        .font(.custom("Inter-Bold", size: 18))
                                        .placeholder(when: name.isEmpty) {
                                            Text("Name").foregroundColor(.white)
                                                .font(.custom("Inter-Bold", size: 18))
                                            
                                        }
                                    
                                    Spacer()
                                    Image("username")
                                        .foregroundColor(Color.white)
                                    
                                    
                                }
                                .padding()
                                .frame(width: (UIScreen.main.bounds.width - 60),height: 60)
                                
                                .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                                
                                HStack {
                                    
                                    TextField("Email Address", text: $email).foregroundColor(Color.white)
                                        .font(.custom("Inter-Bold", size: 18))
                                        .placeholder(when: email.isEmpty) {
                                            Text("Email Address").foregroundColor(.white)
                                                .font(.custom("Inter-Bold", size: 18))
                                            
                                        }
                                    
                                    Spacer()
                                    Image("mail")
                                        .foregroundColor(Color.white)
                                    
                                }
                                .padding()
                                .frame(width: UIScreen.main.bounds.width - 60,height: 60)
                                
                                .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                                
                                //                    HStack {
                                //
                                //                        TextField("Date Of Birth", text: $dob).foregroundColor(Color.white)
                                //                            .font(.custom("Inter-Bold", size: 18))
                                //                            .placeholder(when: dob.isEmpty) {
                                //                                Text("Email Address").foregroundColor(.white)
                                //                                    .font(.custom("Muli-Bold", size: 18))
                                //
                                //
                                //                            }
                                //
                                //                        Spacer()
                                //                        Image("user email")
                                //                            .foregroundColor(Color.white)
                                //
                                //                    }
                                //                    .padding()
                                //                    .frame(width: (UIScreen.main.bounds.width - 60),height: 60)
                                //
                                //                    .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                                //
                                //
                                //
                                //
                                //                    HStack {
                                //
                                //                        TextField("Date of Birth", text: $dob).foregroundColor(Color.white)
                                //                            .font(.custom("Inter-Bold", size: 18))
                                //                            .placeholder(when: dob.isEmpty) {
                                //                                Text("Date of Birth").foregroundColor(.white)
                                //                                    .font(.custom("Inter-Bold", size: 18))
                                //
                                //                            }
                                //
                                //                        Spacer()
                                //                        Image("Dob")
                                //                            .foregroundColor(Color.white)
                                //
                                //
                                //                    }
                                //                    .padding()
                                //                    .frame(width: (UIScreen.main.bounds.width - 60),height: 60)
                                //
                                //                    .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                                
                                
                                
                                HStack {
                                    //
                                    //                        TextField("Date of Birth", text: $dob).foregroundColor(Color.white)
                                    //                            .placeholder(when: dob.isEmpty) {
                                    //                                Text("Date of Birth").foregroundColor(.white)
                                    //
                                    //                            }
                                    
                                    Text(savedDatestr ?? "Date of birth")
                                    
                                        .foregroundColor(.white)
                                    
                                        .font(.custom("Inter-Bold", size: 18))
                                        .onTapGesture {
                                            UIApplication.dismissKeyboard()
                                            
                                            showDatePicker.toggle()
                                            
                                        }
                                    
                                    //   Spacer()
                                    
                                    Spacer()
                                    Image("Dob")
                                        .foregroundColor(Color.white)
                                    
                                }
                                .padding()
                                .frame(width: (UIScreen.main.bounds.width - 60),height: 60)
                                
                                .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                                
                                HStack {
                                    
                                    SecureField("Password", text: $password)
                                        .font(.custom("Inter-Bold", size: 18))
                                        .foregroundColor(Color.white)
                                        .placeholder(when: password.isEmpty) {
                                            Text("Password").foregroundColor(.white)
                                                .font(.custom("Inter-Bold", size: 18))
                                        }
                                    
                                    Spacer()
                                    Image( "pwd")
                                        .foregroundColor(Color.white)
                                    
                                }
                                .padding()
                                .frame(width: (UIScreen.main.bounds.width - 60),height: 60)
                                
                                .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                                
                                HStack {
                                    
                                    SecureField("Confirm Password", text: $cpassword)
                                        .font(.custom("Inter-Bold", size: 18))
                                        .foregroundColor(.white)
                                        .placeholder(when: cpassword.isEmpty) {
                                            Text("Confirm Password").foregroundColor(.white)
                                                .font(.custom("Inter-Bold", size: 18))
                                        }
                                    Spacer()
                                    Image( "pwd")
                                        .foregroundColor(Color.white)
                                }
                                
                                .padding()
                                .frame(width: (UIScreen.main.bounds.width - 60),height: 60)
                                
                                .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                                
                                HStack {
                                    
                                    TextField("TagLine", text: $tagline)
                                        .font(.custom("Inter-Bold", size: 18))
                                        .foregroundColor(Color.white)
                                        .placeholder(when: tagline.isEmpty) {
                                            Text("TagLine").foregroundColor(.white)
                                                .font(.custom("Inter-Bold", size: 18))
                                            
                                        }
                                    
                                    Spacer()
                                    Image("commnet")
                                        .resizable()
                                        .frame(width: 20.0, height: 20.0)
                                        .foregroundColor(Color.white)
                                    
                                    
                                }
                                .padding()
                                .frame(width: (UIScreen.main.bounds.width - 60),height: 60)
                                
                                .overlay(RoundedRectangle(cornerRadius: (30.0)).stroke(lineWidth: 2).foregroundColor(Color.white))
                                
                                Spacer()
                                
                                
                                VStack(alignment: .center, spacing: 20.0 ){
                                    Button("Create Account"){
                                        //  obs.ForgotPwd()
                                        //
                                        //
                                        UIApplication.dismissKeyboard()
                                        
                                        
                                        if (name == "")
                                        {
                                            
                                            message = "Please Enter Name!"
                                            showingAlert = true
                                            return
                                            
                                        }
                                        if (email == "")
                                        {
                                            
                                            message = "Please Enter Email!"
                                            showingAlert = true
                                            return
                                            
                                        }
                                        //                        if (dob == "")
                                        //                        {
                                        //
                                        //                            message = "Please Enter Email!"
                                        //
                                        //                            showingAlert = true
                                        //
                                        //                            return
                                        //
                                        //                        }
                                        if (savedDate?.description == "Date of Birth")
                                        {
                                            
                                            message = "Please Enter Date of birth!"
                                            
                                            showingAlert.toggle()
                                            
                                            return
                                            
                                        }
                                        
                                        
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
                                        
                                        let date = Date()
                                        
                                        let dateFormatterGet = DateFormatter()
                                        dateFormatterGet.dateFormat = "yyyy-MM-dd"
                                        
                                        let dateFormatterPrint = DateFormatter()
                                        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
                                        
                                        let datstr = dateFormatterGet.string(from: date)
                                        
                                        // print(svddate1 as Any)
                                        let datstr1 = dateFormatterGet.string(from: savedDate!)
                                        
                                        if (datstr == datstr1) {
                                            print("DOB should be same or greater than current date")
                                            message = "DOB should be smaller than current date!"//
                                            showingAlert = true
                                            return
                                        }
                                        
                                        if (savedDate! > date) {
                                            print("DOB should be smaller than current date!")
                                            message = "DOB should be smaller than current date!"//
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
                                        
                                    }.font(.custom("Inter-Bold", size: 22))
                                        .foregroundColor(Color.white)
                                        .frame(width:UIScreen.main.bounds.width - 60 ,height: 56)
                                        .background(Color("buttoncolor"))
                                        .cornerRadius(30)
                                        .fullScreenCover(isPresented: $showNextView, content: LoginViews.init)
                                        .onTapGesture(){
                                            
                                            if (name == "")
                                            {
                                                
                                                message = "Please Enter Name!"
                                                
                                                showingAlert = true
                                                
                                                return
                                                
                                            }
                                            if (email == "")
                                            {
                                                
                                                message = "Please Enter Email!"
                                                
                                                showingAlert = true
                                                
                                                return
                                                
                                            }
                                            //                        if (dob == "")
                                            //                        {
                                            //
                                            //                            message = "Please Enter Email!"
                                            //
                                            //                            showingAlert = true
                                            //
                                            //                            return
                                            //
                                            //                        }
                                            if (savedDate?.description == "Date of Birth")
                                            {
                                                
                                                message = "Please Enter Date of birth!"
                                                
                                                showingAlert.toggle()
                                                
                                                return
                                                
                                            }
                                            
                                            
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
                                            
                                            let date = Date()
                                            
                                            let dateFormatterGet = DateFormatter()
                                            dateFormatterGet.dateFormat = "yyyy-MM-dd"
                                            
                                            let dateFormatterPrint = DateFormatter()
                                            dateFormatterPrint.dateFormat = "yyyy-MM-dd"
                                            let datstr = dateFormatterGet.string(from: date)
                                            // print(svddate1 as Any)
                                            let datstr1 = dateFormatterGet.string(from: savedDate!)
                                            
                                            if (datstr == datstr1) {
                                                print("DOB should be same or greater than current date")
                                                message = "DOB should be smaller than current date!"//
                                                showingAlert = true
                                                return
                                            }
                                            
                                            if (savedDate! > date) {
                                                print("DOB should be smaller than current date!")
                                                message = "DOB should be smaller than current date!"//
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
                                            Alert(title: Text("Warning"), message: Text(message), dismissButton: .default(Text("Ok!")))
                                        }
                                        .alert(isPresented:$showingAlert1) {
                                            Alert(
                                                title: Text("Warning"),
                                                message: Text(message),
                                                primaryButton: .destructive(Text("Ok")) {
                                                    print("Deleting...")
                                                    self.showNextView.toggle()
                                                },
                                                secondaryButton: .cancel()
                                            )
                                        }
                                    
                                    
                                    Text("Or Create With")
                                        .foregroundColor(Color.white)
                                        .font(.custom("Inter-Regular", size: 17))
                                        .frame(width: 300, height: 35, alignment: .center)
                                    
                                    
                                    HStack{
                                        
                                        Button(action: {
                                            //                        self.googleSignIn?.signOut()
                                            //                        self.signedIn = true
                                            //                    self.googleSignIn?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
                                            //                     self.googleSignIn?.clientID = FirebaseApp.app()?.options.clientID
                                            //                        self.googleSignIn?.delegate = self.myGoogle
                                            //                        self.googleSignIn?.signIn()
                                            viewModel.signOut()
                                            //   viewModel.signIn()
                                            
                                        }, label: {
                                            HStack {
                                                Image( "gmail")
                                                    .aspectRatio(contentMode: .fill)
                                                
                                                
                                            }
                                        }).frame(width: 70 , height: 70)
                                        
                                            .fullScreenCover(isPresented: $viewModel.showsignupViewaftergoogle, content: {
                                                
                                                if ( UserDefaults.standard.string(forKey: "StatusGmail") == "yes"){
                                                    MainView()
                                                    
                                                }
                                                else if ( UserDefaults.standard.string(forKey: "StatusGmail") == "No"){
                                                    MainView()
                                                }
                                                
                                            })
                                        Button(action: {
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
                                        
                                        //
                                        //                    VStack {
                                        //                        if let screenName = twitterAPI.user?.screenName { // 2
                                        //                                       Text("Welcome").font(.largeTitle)
                                        //                                       Text(screenName).font(.largeTitle)
                                        //                                   } else { // 3
                                        //                                       Button("Signin with Twitter", action: {
                                        //                                           twitterAPI.authorize()
                                        //                                       })
                                        //                                   }
                                        //                               }
                                        //                               .sheet(isPresented: $twitterAPI.authorizationSheetIsPresented) { // 4
                                        //                                   SafariView(url: $twitterAPI.authorizationURL) // 5
                                        //                               }
                                        //
                                        //
                                        //
                                        
                                        
                                        Button(action: {
                                            // twitterAPI.authorize()
                                            
                                            
                                        }, label: {
                                            HStack {
                                                Image( "twitter")
                                                
                                            }
                                            .frame(width: 70
                                                   , height: 70)
                                        })
                                        //                    .sheet(isPresented: $twitterAPI.authorizationSheetIsPresented) {
                                        //                                SafariView(url: $twitterAPI.authorizationURL)
                                        //                            }
                                    }
                                }
                                
                                // Spacer()
                                // Spacer()
                                
                                
                            }.padding(.horizontal, 5.0)
                            //  Spacer()
                        }
                    }
                    //                /.background(Color("blackcolor") .ignoresSafeArea(.all, edges: .all))
                    
                }
                .frame(width:UIScreen.main.bounds.width)
                .background(Color("themecolor 1") .ignoresSafeArea(.all, edges: .all))
                
                
                
                if showDatePicker {
                    DatePickerWithButtons(showDatePicker: $showDatePicker, savedDate: $savedDate, selectedDate: savedDate ?? Date(), savedDatestr: $savedDatestr )
                        .animation(.linear)
                        .transition(.opacity)
                    //                            .background(Color.black)
                    //                            .foregroundColor(.white)
                }
                
                
            }
            //            .onAppear(){
            //
            //             if UIDevice.current.hasNotch {
            //                 heightplus = 35
            //             } else {
            //                 //... don't have to consider notch
            //                 heightplus = 20
            //             }
            //         }
            .background(Color("themecolor 1"))
            
        }
        
        
        .simpleToast(isPresented: $showingAlert, options: toastOptions) {
            HStack {
                
                Text(message)
            }
            .padding()
            .background(Color.white.opacity(0.8))
            .foregroundColor(Color.black)
            .cornerRadius(10)
        }
    }
    
    func signup() {
        UIApplication.dismissKeyboard()
        
        
        // UIApplication.dismissKeyboard()
        
        var strBase64 = String()
        if image == UIImage(named: "male-user"){
            strBase64 = ""
        }else{
            // let imgData = (image)?.jpeg(.lowest) //(imgARR[i] as? UIImage)!.pngData()
            
            //
            let imgData = image!.pngData()
            
            strBase64 = imgData!.base64EncodedString(options: .lineLength64Characters)
        }
        
        //        JSONObject jsonObject = new JSONObject();
        //                    jsonObject.put("deviceToken", "fZ-WwIU65E-KsI0CfLChrS:APA91bGg2O6Py-VvxDTnalxv8agKYFeO1av4bFNYdgYhVn5iRHhkpTMni8DQ89wHvdg7Xb_yB0fwElmUYEIvTqPLTJRPZUB3MeGchr-yDHw0A9xp5Du7qmdpj0ZXY3k7JdmHXrruBNNt");
        //                    jsonObject.put("username", name);
        //                    jsonObject.put("dateOfBirth", dob);
        //                    jsonObject.put("password", password);
        //                    jsonObject.put("email", email);
        //                    jsonObject.put("flag", flag);
        //                    jsonObject.put("deviceType", "A");
        //                    if (bitmap == null) {
        //                        jsonObject.put("profilePictureURL", "");
        //
        var logInFormData: Parameters {
            [
                "username": name,
                "dateOfBirth": savedDatestr ?? "",
                "email": email,
                "password": password,
                "deviceToken":UserDefaults.standard.string(forKey: "devicetoken") ?? "",
                "deviceType": "I",
                "flag":"E",
                "profilePictureURL" : strBase64
            ]
            
        }
        
        print(logInFormData)
        //Account/Register
        
        AccountAPI.signin(servciename: "Accounts/Register", logInFormData) { res in
            switch res {
            case .success:
                print("resulllll",res)
                if let json = res.value{
                    
                    
                    print("Josn",json)
                    if (json["status"] == "true")
                    {
                        _ = json["data"]
                        
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
    func FacebookLogin() {
        UIApplication.dismissKeyboard()
        
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
                                    
                                }else{
                                    
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
        UIApplication.dismissKeyboard()
        
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
}

struct signuppage_Previews: PreviewProvider {
    static var previews: some View {
        signuppage()
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
