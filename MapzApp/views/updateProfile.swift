//
//  updateProfile.swift
//  MapzApp
//
//  Created by Misha Infotech on 03/09/2021.
//

import SwiftUI

import Alamofire
import SwiftyJSON
struct updateProfile: View {
    @State var showImagePicker: Bool = false
    @State var image = UIImage(named: "male-user")
    @State private var showingActionSheet = false
    @State var cmrstr = String()
    @Environment(\.presentationMode) var presentationMode

    @State var showNextView = false
    @State var showDatePicker: Bool = false
        @State var savedDate: Date? = nil

    @State var savedDatestr : String? = nil

    @State private var signedIn = false

    @State  var name: String = UserDefaults.standard.string(forKey: "name") ?? ""
    @State  var email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    @State  var code: String = "+91"
    @State  var mobile: String = ""
    @State  var dob: String = UserDefaults.standard.string(forKey: "dateOfBirth") ?? ""
    @State  var comment = ""

    @State  var showingAlert = false
    @State  var showingAlert1 = false

    @State  var message = String()
    //@Environment(\.presentationMode) var presentationMode
   // @StateObject var viewModel1 = ViewModelSignup()

    @State  var password: String = ""
    @State  var cpassword: String = ""

    var body: some View {
        
        ZStack {
            
            VStack{

             HStack(spacing: 20.0) {
                 Button(action: {
                    presentationMode.wrappedValue.dismiss()
                 }) {
                    Image("icons8-back-24")
                         .resizable()

                         .aspectRatio(contentMode: .fit)
                    Text("Back")
                        .foregroundColor(Color.white)

                 }
                Spacer()
                 //.frame(width: 220,height: 50.0)

             }
             .padding()
             .padding(.top,10)
             .frame(height: 55.0)
             .background(Color("themecolor"))

            ScrollView{
                VStack(alignment: .center, spacing: 20.0 ) {


//                    Image("logo")
//                        .resizable()
//                         .aspectRatio(contentMode: .fit)
//                         .frame(width: 150, height: 100, alignment: .center)
//

                    Text("Please Update your profile.")
                        .foregroundColor(Color("themecolor"))
                        .font(.custom("Inter-Bold", size: 22))
                        .multilineTextAlignment(.center)
                        .frame(width: 300, height: 35
                            , alignment:.center)



                    HStack(alignment: .center, spacing: 20.0) {

                        Image(uiImage: image!)
                            .resizable()

                            .frame(width: 70, height: 70)
                            .cornerRadius(35.0)
                            .aspectRatio(contentMode: .fit)
//                            .overlay(
//                                Circle()
//                                    .stroke(Color.black, lineWidth: 2) // You can customize the color and lineWidth
//                            )
//                            .clipShape(Circle())
//
                        
                            .onTapGesture {

                                self.showingActionSheet = true

                               //

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

                        Text("Choose your Profile Picture")
                            .foregroundColor(Color("themecolor"))

                            .font(.custom("Inter-Regular", size: 17))
Spacer()
                    }.frame( height: 70)

                    HStack {

                        TextField("Name", text: $name).foregroundColor(Color("themecolor"))
                            .font(.custom("Inter-Regular", size: 17))
                            .placeholder(when: name.isEmpty) {
                                Text("Name").foregroundColor(Color("themecolor"))

                            }
                        Spacer()

                        Image("username")
                            .foregroundColor(Color("themecolor"))

                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: (25.0)).stroke(lineWidth: 2).foregroundColor(Color("themecolor")))

                    HStack {

                        TextField("Email Address", text: $email).foregroundColor(Color("themecolor"))
                            .font(.custom("Inter-Regular", size: 17))
                            .placeholder(when: email.isEmpty) {
                                Text("Email Address").foregroundColor(Color("themecolor"))

                            }
                        Spacer()
                        Image("mail")
                            .foregroundColor(Color("themecolor"))

                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: (25.0)).stroke(lineWidth: 2).foregroundColor(Color("themecolor")))


                    HStack {

                        Text(savedDate?.description ?? "Date of Birth")
                            .foregroundColor(Color("themecolor"))

                            .font(.custom("Inter-Regular", size: 17))
                            .onTapGesture {
                                showDatePicker.toggle()

                            }

                        Spacer()
                        Image( "Dob")
                            .foregroundColor(Color("themecolor"))

                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: (25.0)).stroke(lineWidth: 2).foregroundColor(Color("themecolor")))






                    Button("Upddate Profile"){
                      //  obs.ForgotPwd()
//

                        if (name == "")
                        {

                            message = "Please Enter Name!"

                            showingAlert.toggle()

                            return

                        }
                        if (email == ""){
                        
                            message = "Please Enter Email!"
                            showingAlert.toggle()
                            return

                        }
                        
                        if (savedDate?.description == "Date of Birth") {
                            message = "Please Enter Date of birth!"
                            showingAlert.toggle()
                            return

                        }

                       // signup()

                    }.font(.custom("Inter-Bold", size: 20))
                    .foregroundColor(Color.white)
                    .frame(width:UIScreen.main.bounds.width - 30 ,height: 60)
                    .background(Color("bluecolor"))
                    .cornerRadius(30)
                    .fullScreenCover(isPresented: $showNextView, content: MainView.init)
//                    .fullScreenCover(isPresented: $viewModel.isVerify, content: Verification())
//
//                    .fullScreenCover(isPresented: $viewModel1.isVerify, content: {
//                        verifyafterregistration(viewModelSignup: viewModel1)
//
//                            })
                    .alert(isPresented: $showingAlert, content: {
                            var alert: Alert {

                                Alert(title: Text("Warning"), message: Text(message), dismissButton: .default(Text("Ok")))
                    }
                        return alert
                    })

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





                }.padding(.horizontal, 5.0)


            }
            .background(Color.white)

            }
            
        if showDatePicker {
                DatePickerWithButtons(showDatePicker: $showDatePicker, savedDate: $savedDate, selectedDate: savedDate ?? Date(), savedDatestr: $savedDatestr)
                               .animation(.linear)
                               .transition(.opacity)
//                            .background(Color.black)
//                            .foregroundColor(.white)
                       }
        }
        //    .onAppear(){
//
//            if(dob != ""){
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd"
//                savedDate = dateFormatter.date(from:dob)!
//            }
//        }
    }
    
//    func signup() {
//        let imgData = image!.pngData()
//        let strBase64 = imgData!.base64EncodedString(options: .lineLength64Characters)
//
//        var logInFormData: Parameters {
//            [
//                "name": name,
//                  "email": email,
//                 // "password": password,
//                "dateOfBirth": savedDate?.description as Any,
//                  "profilePictureURL": strBase64,
//             //   "deviceToken":UserDefaults.standard.string(forKey: "devicetoken")!,
//              //    "deviceType": "I"
//                  ]
//
//        }
//
//            print(logInFormData)
//
//
//                    AccountAPI.signin(servciename: "Profile/UpdateUserprofile", logInFormData) { res in
//                    switch res {
//                    case .success:
//                        print("resulllll",res)
//                        if let json = res.value{
//
//
//                            print("Josn",json)
//                            if (json["status"] == "true")
//                            {
//                                     let userdic = json["data"]
//
//
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
//                     //                UserDefaults.standard.set(userdic["status"].string, forKey: "status")
//                     //                UserDefaults.standard.set(userdic["pin"].string, forKey: "pin")
//                     //                UserDefaults.standard.set(userdic["wallet"].string, forKey: "wallet")
//                             UserDefaults.standard.set("yes", forKey: "login")
//
//
////
//                                self.showingAlert1.toggle()
////
//                                self.message = json["message"].stringValue
////
////
//                     //                self.logindetails.append(acc)
//                     //                print(self.logindetails)
//
//
//                            }
//                            else{
//                            //
//                             self.showingAlert.toggle()
//                             self.message = json["message"].stringValue
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
//        let baseURL = URL(string: "http://167.86.105.98:7723/api/Upload/uploadeventdiary")
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

}

struct updateProfile_Previews: PreviewProvider {
    static var previews: some View {
        updateProfile()
    }
}
struct DatePickerWithButtons: View {
    
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    @Binding var savedDatestr: String?

    var body: some View {
        ZStack {
            
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 20.0) {
                DatePicker("Test", selection: $selectedDate, displayedComponents: [.date])
                    
                    .datePickerStyle(GraphicalDatePickerStyle())
               
                    .colorScheme(.dark)
                
                Divider()
                HStack {
                    Spacer()
                   
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    })
                    .frame(width: 110, height: 50)
                    .background(Color("blackcolor"))
                    .cornerRadius(10)
                    
                    Button(action: {
                        
                        
                        let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"

                           let str = formatter.string(from: selectedDate)
                        
                        savedDatestr = str
                        savedDate = selectedDate
                        showDatePicker = false
                    }, label: {
                        Text("Set Date")
                            .foregroundColor(.white)

                            
                    }
                    )
                    .frame(width: 110, height: 50)
                    .background(Color("redColor"))
                    .cornerRadius(10)
                    
                    
                }
                .padding(.horizontal)

            }
            .padding()
            .background(
                Color.black
                    .cornerRadius(30)
            )

            
        }

    }
}


//
//struct DatePickerWithButtons_Previews: PreviewProvider {
//    static var previews: some View {
//        updateProfile()
//    }
//}
