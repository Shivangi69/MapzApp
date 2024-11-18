//
//  EditProfileView.swift
//  MapzApp
//
//  Created by Misha Infotech on 30/11/2022.
//

import SwiftUI
import Alamofire

struct EditProfileView: View {
    
    @State  var name: String = UserDefaults.standard.string(forKey: "name") ?? ""
    @State  var comment = UserDefaults.standard.string(forKey: "tagLine") ??  "Comment"
    @State  var email = UserDefaults.standard.string(forKey: "email") ??  ""
    @State private var image: UIImage? = {
        if let imageUrlString = UserDefaults.standard.string(forKey: "profilePictureURL"),
           let imageUrl = URL(string: imageUrlString),
           let imageData = try? Data(contentsOf: imageUrl) {
            return UIImage(data: imageData)
        }
        return nil
    }()
    
    
    @Environment(\.presentationMode) var presentationMode
    
    let minHeight: CGFloat = 100
    @State private var height: CGFloat?
    @State private var showingActionSheet = false
    let textLimit = 10
    @State var showImagePicker: Bool = false

    @State var cmrstr = String()
    let radius: CGFloat = 65
    var offset: CGFloat {
        sqrt(radius * radius / 2)
    }//icons8-male-user-72
//    @State var image = UIImage(named: "icons8-male-user-72")
    
    @State var showNextView = false
    @State private var signedIn = false

    @State  var showingAlert = false
    @State  var showingAlert1 = false

    @State  var message = String()
    
    var body: some View {
        
        ZStack{
            VStack{

                HStack{
                    VStack(alignment: .leading, spacing : 12.0) {
                        // Spacer(minLength: 12)
                        Button(action: {
                            //
                            presentationMode.wrappedValue.dismiss()
                           
                        }) {
                            Image("back")
                                .resizable()
                                .frame(width: 24.0, height: 24.0)
                            //    .padding(.top,12.0)
                            
                            //.cornerRadius(24)
                        }
                        Text("Edit profile")
                            .foregroundColor(Color.black)
                            .font(.custom("Inter-Bold", size: 18))
                    }
                    Spacer()
                }.padding(.horizontal , 10)
               
                
                HStack{
                    
                }
                .frame(width: UIScreen.main.bounds.width-20, height: 1.0)
                .border(Color.black, width: 1)
                .padding(.bottom,3.0)
                         

                
                HStack{
                    
//                    Image("icons8-male-user-72")
//                        .resizable()
//                        .frame(width: 120.0, height: 120.0)
//                        .cornerRadius(60.0)
//
                    
                      VStack  {
                          
                            
//                          Image(uiImage: image!)
//                              .resizable()
//                              .frame(width: 100.0, height: 100.0)
//                              .cornerRadius(50.0)
//                              .overlay(
//                                  Circle()
//                                      .stroke(Color.black, lineWidth: 2) // You can customize the color and lineWidth
//                              )
//                              .clipShape(Circle())


//                                .overlay(
//                                                   Circle()
//                                                       .stroke(Color.black.opacity(0.8), lineWidth: 1)
//                                                   .frame(width: 100, height: 100, alignment: .center)
//                                               )
                          
                              
//                                .overlay(
//                                    Button(action: {
//                                        self.showingActionSheet = true
//
//                                    }) {
//
//                                      Text ("Change Image")
//                                            // .foregroundColor(Color("purplecolor"))
//                                            //       .padding(8)
//                                            //    .background(Color.black)
//                                            .clipShape(Circle())
//                                            .background(
//                                                Circle()
//                                                    .stroke(Color.white, lineWidth: 2)
//
//                                            )
//                                    }.offset(x: offset, y: -offset)
//                                )
                                
                          
                          if let image = image {
                         
                              Image(uiImage: image)
                                  .resizable()
                                  .frame(width: 100.0, height: 100.0)
                                  .cornerRadius(50.0)
                                  .overlay(
                                    Circle()
                                    .stroke(Color.black, lineWidth: 2) // You can customize the color and lineWidth
                                  )
                                  .clipShape(Circle())
                              
                              
//                                  .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .inset(by: 0.5)
//                                        .stroke(Color.black.opacity(0.15), lineWidth: 1)
//                                  )
                              
                                  .actionSheet(isPresented: $showingActionSheet) {
                                      ActionSheet(title: Text("Choose"), message: Text(""), buttons: [
                                        .default(Text("Camera")) {
                                            self.showImagePicker .toggle()
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
                          }
                        }
                    
                    
                    Button(action: {
                        self.showingActionSheet = true
                    }) {
                        Text("Change image")
                            .foregroundColor(Color.black)
                            .font(.custom("Inter-Regular", size: 16))
                        
                    }
                  Spacer()
                   
                }
              
                .padding(.horizontal , 10)


                VStack(spacing: 25.0){
                    HStack{
                        
                        TextField (name, text: $name)
                            .font(.custom("Inter-Regular", size: 14))
                            .placeholder(when: name.isEmpty) {
                                Text("Name").foregroundColor(.gray)
                                    .font(.custom("Inter-Regular", size: 14))
                                
                            }
                    }
                    .padding(.horizontal, 8.0)
                    .frame(width: UIScreen.main.bounds.width-30, height: 45.0)
                    .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 1))
                    
                    HStack{
                        Text (email)
                            .font(.custom("Inter-Regular", size: 14))
                            .placeholder(when: name.isEmpty) {
                                Text("Name").foregroundColor(.gray)
                                    .font(.custom("Inter-Regular", size: 14))
                            }
                        Spacer()
                    }
                    .padding(.horizontal, 8.0)
                    .frame(width: UIScreen.main.bounds.width-30, height: 45.0)
                    .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 1))
                    //  .border(Color .black, width: 1)
                    //  .cornerRadius(6)
                    
//                    HStack(alignment: .top, spacing: 14.33){
//
//
//                        WrappedTextView(text: $comment, textDidChange: self.textDidChange)
//                            .frame(height: height ?? minHeight)
//                            .padding(.all, 8.0)
//
//
//                            //  .foregroundColor(self.text == "Reason" ? .white : .white)
//
//
//                            .font(.custom("Inter-Regular", size: 17))
//
//                            .onAppear {
//                                // remove the placeholder text when keyboard appears
//                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
//                                    withAnimation {
//                                        if self.comment == "Comment" {
//                                            self.comment = ""
//                                        }
//                                    }
//                                }
//
//                                // put back the placeholder text if the user dismisses the keyboard without adding any text
//                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
//                                    withAnimation {
//                                        if self.comment == "Comment" {
//                                            self.comment = ""
//                                        }
//                                    }
//                                }
//                            }
//
//                    }  .padding(.horizontal, 12.0)
                    
                    
                    
                    
                    HStack {
                        WrappedTextView(text: $comment, textDidChange: self.textDidChange)
                                    .frame(height: height ?? minHeight)
                                    .padding(.horizontal, 8.0)
                                    .font(.custom("Inter-Regular", size: 14))

                                    .foregroundColor(self.comment == "Comment" ? .gray : .black)

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
                Spacer()
                
                
                
                
                Button("Save"){
                  //  obs.ForgotPwd()
                    if (name == ""){
                        message = "Please Enter Name!"
                        showingAlert.toggle()
                        return
                        
                    }
                    signup()

                }
                .font(.custom("Inter-Bold", size: 20))
                    .foregroundColor(.white)
                    .font(.custom("Inter-Medium", size: 20))
                    .frame(width:
                            UIScreen.main.bounds.width-30, height: 60.0)
                    .background(Color ("themecolor"))
                    .cornerRadius(36)
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

                
                Spacer().frame( height: 15)
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

    func signup()  {
        UIApplication.dismissKeyboard()

        var strBase64  = String()
        if image == UIImage(named: "icons8-male-user-72"){
            strBase64 = ""
        }else{
            let imgData = image!.pngData()
            
            strBase64 = imgData!.base64EncodedString(options: .lineLength64Characters)

        }
       
        var logInFormData: Parameters {
            [
                "name": name,
                "profilePictureURL": strBase64,
                "email": UserDefaults.standard.string(forKey: "email") ?? "",
                "dateOfBirth": UserDefaults.standard.string(forKey: "DateOfBirth") ?? "",
                "tagLine" : comment
                ]
            }
            
                    AccountAPI.signin(servciename: "Profile/UpdateUserprofile", logInFormData) { res in
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
                                UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")//firstName
                                UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
                                UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
                                UserDefaults.standard.set(datestr, forKey: "dateOfBirth")
                                UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
                                UserDefaults.standard.set(userdic["tagLine"].string, forKey: "phoneNumber")
                                UserDefaults.standard.set(userdic["totalFriend"].int, forKey: "totalFriend")
                                UserDefaults.standard.set(userdic["totalEvent"].int, forKey: "totalEvent")
                                
                                
                                UserDefaults.standard.set(fullName, forKey: "DateOfBirth")
                                
                                //
                                self.showingAlert1.toggle()
                                //
                                self.message = json["message"].stringValue
                                //
                                //
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
    

    func uploadInBackground(fileInData: Data) {
        
        UIApplication.dismissKeyboard()

//        let evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""
//        let parameters = [
//
//              "EventId": evntId,
//                "UserId": UserDefaults.standard.string(forKey: "id") ?? "",
//              "Groupid1" : "12",
//              "IsGroup1" : "true"
//
//            ]
        var groupid = String()
        var isgroupid = String()
//
        var ISfromGroup =            UserDefaults.standard.string(forKey: "isGroup")
//        UserDefaults.standard.set("yes", forKey: "isGroup")

        if ISfromGroup == "yes"{
            groupid = UserDefaults.standard.string(forKey: "groupId") ?? ""
            isgroupid = "true"
        }else{
            groupid = "0"
            isgroupid = "false"
        }
        let evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""
        let parameters = [
              "EventId": evntId,
            "UserId": UserDefaults.standard.string(forKey: "id") ?? "",
              "Groupid1" : groupid,
              "IsGroup1" : isgroupid
              
            ]
    print(parameters)
        let headers: HTTPHeaders
            headers = ["Content-type": "multipart/form-data",
                       "Content-Disposition" : "form-data"]
            
//            let headers: [String : String] = [ "Authorization": "key"]
        let baseURL = URL(string: "http://mapzapp.com/api/Upload/uploadeventdiary")
        print(baseURL!)

            Networking.sharedInstance.backgroundSessionManager.upload(multipartFormData: { (multipartFormData) in
          
                multipartFormData.append(fileInData, withName: "file", mimeType: "image/jpeg")
               // multipartFormData.append(fileInData, withName: "file")
                for (key, value) in parameters {
                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
                       }
            }, usingThreshold: UInt64.init(), to: baseURL!, method: .post, headers: headers)
            
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    ///api/Upload/upload
                    upload.uploadProgress(closure: { (progress) in
                        //Print progress
                        let value =  Int(progress.fractionCompleted * 100)
                        print("\(value) %")
                    })
                    
                    upload.responseJSON { response in
                        //print response.result
                        print(response.description)
                        let res = response.response?.statusCode
                        print(res!)
                        Toast(text: "Upload Successfully").show()

                    }
                    
                case .failure(let encodingError):
                    //print encodingError.description
                    print(encodingError.localizedDescription)
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}


struct WrappedTextView: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    let textDidChange: (UITextView) -> Void

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.delegate = context.coordinator
        view.textColor = .black
       
        view.font = UIFont(name: "Inter-Regular", size: 14)//UIFont.custom("Inter-Bold", size: 17)
                let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
                let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(view.doneButtonTapped(button:)))
                toolBar.items = [doneButton]
                toolBar.setItems([doneButton], animated: true)
        view.inputAccessoryView = toolBar
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = self.text
        DispatchQueue.main.async {
            self.textDidChange(uiView)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, textDidChange: textDidChange)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        let textDidChange: (UITextView) -> Void

        init(text: Binding<String>, textDidChange: @escaping (UITextView) -> Void) {
            self._text = text
            self.textDidChange = textDidChange
        }

        func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
            self.textDidChange(textView)
        }
    }
}
extension  UITextView{
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }

}
