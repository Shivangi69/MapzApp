//
//  ChangePwdView.swift
//  MapzApp
//
//  Created by Misha Infotech on 15/09/2021.
//

import SwiftUI
import Alamofire
struct ChangePwdView: View {
    @State  var opassword: String = ""
    @State var showresetpwd = false

    @State  var password: String = ""
    @State  var cpassword: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State  var showingAlert = false
    @State  var message = String()
    @State var heightplus : CGFloat = 35

    var body: some View {
        ZStack{
            VStack(spacing: 15.0) {
                Spacer()
                      .frame(height :heightplus)
//
                HStack{
                    VStack(alignment: .leading, spacing : 12.0) {
                        // Spacer(minLength: 12)
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            //                    withAnimation {
                            //                        x = 0
                            //                    }
                        }) {
                            Image("back")
                                .resizable()
                                .frame(width: 24.0, height: 24.0)
                            //    .padding(.top,12.0)
                           //.cornerRadius(24)
                        }
                        Text("Change password")
                            .foregroundColor(Color.black)
                            .font(.custom("Inter-Bold", size: 18))
                    }
                   Spacer()
                } .padding(.horizontal,
                           10.0)
                HStack{

                }
                .frame(width: UIScreen.main.bounds.width-30, height: 1.0)
                .border(Color.black, width: 1)
                .padding(.bottom,
                         3.0)
                
                
                VStack(spacing: 20.0){
                HStack {
                    SecureField("Enter existing password", text: $opassword)
                        .font(.custom("Inter-Regular", size: 14))
                        .placeholder(when: password.isEmpty) {
                            Text("Enter existing password").foregroundColor(.white)
                        }
                }
                .padding(.horizontal, 12.0)
                .frame(width: UIScreen.main.bounds.width-30, height: 45.0)
                .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 1))
                
                    VStack(spacing: 20.0){
                    
                HStack {
                    SecureField("Enter new password", text: $password)
                        .font(.custom("Inter-Regular", size: 14))
                        .placeholder(when: password.isEmpty) {
                            Text("Enter new password").foregroundColor(.white)
                            
                        }
                }
                .padding(.horizontal, 12.0)
                .frame(width: UIScreen.main.bounds.width-30, height: 45.0)
                .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 1))
                
                
                HStack {
                    SecureField("Re-enter new password", text: $cpassword)
                        .font(.custom("Inter-Regular", size: 14))
                        .placeholder(when: cpassword.isEmpty) {
                            Text("Enter confirm password").foregroundColor(.white)
                            
                        }
                }
                .padding(.horizontal, 12.0)
                .frame(width: UIScreen.main.bounds.width-30, height: 45.0)
                .overlay(RoundedRectangle(cornerRadius: (6.0)).stroke(lineWidth: 1))
        
                    }
                  
               Spacer()
                    
                Button("Save"){
                   //
                   // obs.showNextView.toggle()
                    if (opassword == "")
                    {
 //
                        message = "Please Enter Existing Password!"
                        showingAlert.toggle()
                        return

                    }
                    if (cpassword == "")
                        
                    {
                        message = "Please Enter Confirm Password!"
                        showingAlert.toggle()
                        return

                    }
                    
                        confirmPWD()
                        }.font(.custom("Inter-Bold", size: 20))
                        .foregroundColor(.white)
                .font(.custom("Inter-Medium", size: 20))
                .frame(width:
                        UIScreen.main.bounds.width-30, height: 50.0)
                
                .background(Color ("themecolor-1"))
                .cornerRadius(25)
                .onTapGesture(){
                    //
                    // obs.showNextView.toggle()
                     if (opassword == "")
                     {
  //
                     message = "Please Enter Existing Password!"
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

                         }
                
                .fullScreenCover(isPresented: $showresetpwd, content: LoginViews.init)
                .alert(isPresented: $showingAlert, content: {
                        var alert: Alert {

                            Alert(title: Text("Warning"), message: Text(message), dismissButton: .default(Text("Ok")))

                }
                    return alert
                })
                
                    
                }
                .padding(.horizontal, 15.0)
              
                Spacer()
            }.edgesIgnoringSafeArea(.all)
                .onAppear(){
                    if UIDevice.current.hasNotch {
                        heightplus = 35
                    } else {
                        //... don't have to consider notch
                        heightplus = 20
                    }
                }
        }
    }
    func confirmPWD() {
        
        var logInFormData: Parameters {
            [
                "email":    UserDefaults.standard.string(forKey: "email") ?? "",
                "currentPassword": opassword,
                  "confirmPassword": cpassword,
                "newPassword": password,

                  ]
        
        }
      // ///api/Accounts/ChangePassword
            print(logInFormData)

            
                    AccountAPI.signin(servciename: "Accounts/ChangePassword", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                           
                           
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                               // tokenstring = json["data"]
                                self.showresetpwd.toggle()
                                
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

struct ChangePwdView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePwdView()
    }
}
