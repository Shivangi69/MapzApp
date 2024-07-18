//
//  resetPwd.swift
//  MapzApp
//
//  Created by Misha Infotech on 06/09/2021.
//

import SwiftUI
import Alamofire
import SwiftUI
//
struct resetPwd: View {
    @State  var password: String = ""
    @State  var cpassword: String = ""
    
    @State  var showingAlert1 = false
    @State var emailstring = String()
    @State  var tokenstring = String()
    @State  var showingAlert = false
    @State  var message = String()
    @State var showresetpwd = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack{

            VStack(spacing: 20.0) {
             
             HStack(spacing: 20.0) {
                Button(action: {
                   
                }) {
                   Image("icons8-back-24")
                        .resizable()
                        
                        .aspectRatio(contentMode: .fit)
                   Text("Back")
                       .foregroundColor(Color.white)
                  
                   Spacer()
                    
                   Text("Reset Password")
                                       .foregroundColor(Color("yellowColor"))
                                       .font(.custom("Inter-Bold", size: 20))
                }
             }.padding()
             .padding(.top,10)
             .frame(height: 50.0)
             .background(Color("themecolor"))
            
               
                VStack(spacing: 20.0) {
                
                HStack {
                   SecureField("New Password", text: $password)
                       .font(.custom("Inter-Regular", size: 17))
                       .placeholder(when: password.isEmpty) {
                           Text("Password").foregroundColor(.white)
                           
                       }
                   
                   Spacer()
                   Image( "pwd")
                       .foregroundColor(Color.white)

               }
               .padding()
               .overlay(RoundedRectangle(cornerRadius: (25.0)).stroke(lineWidth: 2).foregroundColor(Color("themecolor")))
               
               
               HStack {
                   
                   SecureField("Confirm Password", text: $cpassword)
                       .font(.custom("Inter-Regular", size: 17))
                       .placeholder(when: password.isEmpty) {
                           Text("Confirm Password").foregroundColor(.white)
                           
                       }
                   Spacer()
                   Image( "pwd")
                       .foregroundColor(Color.white)
               }
               .padding()
               .overlay(RoundedRectangle(cornerRadius: (25.0)).stroke(lineWidth: 2).foregroundColor(Color("themecolor")))
               
               
               Button("    Submit    "){
                  //
                  // obs.showNextView.toggle()
                   if (password == "")
                   {
//
                   message = "Please Enter Password!"
//
                       showingAlert.toggle()
//
                       return

                   }
                   if (cpassword == "")
                   {
//
                       message = "Please Enter Confirm Password!"
//
                       showingAlert.toggle()
//
                       return

                   }
                confirmPWD()

                       }.font(.custom("Inter-Bold", size: 20))
               .foregroundColor(Color.white)
               .frame(width:UIScreen.main.bounds.width - 30 ,height: 60)
               .background(Color("themecolor 1"))
               .cornerRadius(30)
               .fullScreenCover(isPresented: $showresetpwd, content: LoginViews.init)
               .alert(isPresented: $showingAlert, content: {
                       var alert: Alert {

                           Alert(title: Text("Warning"), message: Text(message), dismissButton: .default(Text("Ok")))

               }
                   return alert
               })
//
               
                }
                .padding(.horizontal, 20.0)
             
                Spacer()
            
            }
          
            
        }

    
    }

    func confirmPWD() {
        
        var logInFormData: Parameters {
            [
                "email":    UserDefaults.standard.string(forKey: "emailf") ?? "",
                "password": password,
                  "confirmPassword": cpassword,
                "token": UserDefaults.standard.string(forKey: "tokenf") ?? "",  

                  ]
        
        }
       
            print(logInFormData)

            
                    AccountAPI.signin(servciename: "Accounts/ResetPassword", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                           
                           
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                               // tokenstring = json["data"]
                                self.showresetpwd.toggle()
                                
//                              self.showingotpScreen.toggle()
//                                    self.message = json["message"].stringValue
//
//
//                         //                self.logindetails.append(acc)
//                         //                print(self.logindetails)
//
//
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
struct resetPwd_Previews: PreviewProvider {
    static var previews: some View {
        resetPwd()
    }
}
