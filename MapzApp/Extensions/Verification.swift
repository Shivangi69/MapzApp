//
//  Verification.swift
//  SwiftUI OTP
//
//  Created by Luthfi Abdul Azis on 07/03/21.
//

import SwiftUI

//import SwiftUIX
import Alamofire
import SwiftUI
//
struct Verification: View {
    
   // @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode

    @State var countPin = 4
    @State var currentFocus = 0
    
    @State var pin1 = ""
    @State var pin2 = ""
    @State var pin3 = ""
    @State var pin4 = ""
//    @State var pin5 = ""
//    @State var pin6 = ""
//
    @State  var emailstring = String()
    @State  var tokenstring = String()
    @State  var codestring = String()
    @State  var showresetpwd = false

    @State var isLoading: Bool = false
    
    var body: some View {
        
        ZStack{
           
            VStack(spacing: 35.0){
//                HStack{
//                    Text("Mapzapp")
//                        .font(.system(size: 25))
//
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                        .padding([.top, .leading, .bottom], 20.0)
//                        .frame(width: UIScreen.main.bounds.width, height: 70, alignment: .leading)
//
//                }.background(colorPrimarygreen)
                
                VStack(alignment: .center, spacing: 20.0 ) {
                

                Text("It may take a few minutes to get the code.")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding([.top, .leading, .trailing], 20.0)
                   
                    
//                    Text("*  *  *  *")
//                        .font(.system(size: 35, weight: .bold))
//                        .multilineTextAlignment(.center)
//                        .padding(.top)
//                        .foregroundColor(colorPrimarygreen)

//                Text("We have sent you an SMS \(Text(viewModel.code + viewModel.phoneNumber).fontWeight(.bold).foregroundColor(.black)) with 4 digit")
//                    .font(.callout)
//                    .foregroundColor(.gray)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal)
                
            }
        
//                VStack(alignment: .center) {
//           
//                    HStack(spacing: 20.0) {
//                
//               
//                CocoaTextField("-", text: $pin1)
//                    .isFirstResponder(currentFocus == 0)
//                    .font(.system(size: 18, weight: .bold))
//                    .lineLimit(1)
//                    .frame(maxWidth: 50, maxHeight: 50, alignment: .center)
//                    .multilineTextAlignment(.center)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 6)
//                            .strokeBorder(Color("themecolor"), lineWidth: 1, antialiased: true)
//                    )
//                    .keyboardType(.numberPad)
//                    .onChange(of: pin1, perform: { value in
//                        if value.count > 0 {
//                            currentFocus += 1
//                        }
//                    })
//                    .onTapGesture {
//                        currentFocus = 0
//                    }
//                
//                CocoaTextField("-", text: $pin2)
//                    .isFirstResponder(currentFocus == 1)
//                    .font(.system(size: 18, weight: .bold))
//                    .lineLimit(1)
//                    .frame(maxWidth: 50, maxHeight: 50, alignment: .center)
//                    .multilineTextAlignment(.center)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 6)
//                            .strokeBorder(Color("themecolor"), lineWidth: 1, antialiased: true)
//                    )
//                    .keyboardType(.numberPad)
//                    .onChange(of: pin2, perform: { value in
//                        if value.count > 0 {
//                            currentFocus += 1
//                        }
//                    })
//                    .onTapGesture {
//                        currentFocus = 1
//                    }
//                
//                CocoaTextField("-", text: $pin3)
//                    .isFirstResponder(currentFocus == 2)
//                    .font(.system(size: 18, weight: .bold))
//                    .lineLimit(1)
//                    .frame(maxWidth: 50, maxHeight: 50, alignment: .center)
//                    .multilineTextAlignment(.center)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 6)
//                            .strokeBorder(Color("themecolor"), lineWidth: 1, antialiased: true)
//                    )
//                    .keyboardType(.numberPad)
//                    .onChange(of: pin3, perform: { value in
//                        if value.count > 0 {
//                            currentFocus += 1
//                        }
//                    })
//                    .onTapGesture {
//                        currentFocus = 2
//                    }
//                
//                CocoaTextField("-", text: $pin4)
//                    .isFirstResponder(currentFocus == 3)
//                    .font(.system(size: 18, weight: .bold))
//                    .lineLimit(1)
//                    .frame(maxWidth: 50, maxHeight: 50, alignment: .center)
//                    .multilineTextAlignment(.center)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 6)
//                            .strokeBorder(Color("themecolor"), lineWidth: 1, antialiased: true)
//                    )
//                    .keyboardType(.numberPad)
//                    .onChange(of: pin4, perform: { value in
//                        if value.count > 0 {
//                            currentFocus += 1
//                        }
//                    })
//                    .onTapGesture {
//                        currentFocus = 3
//                    }
////
////                CocoaTextField("-", text: $pin5)
////                    .isFirstResponder(currentFocus == 4)
////                    .font(.system(size: 18, weight: .bold))
////                    .lineLimit(1)
////                    .frame(maxWidth: 50, maxHeight: 50, alignment: .center)
////                    .multilineTextAlignment(.center)
////                    .overlay(
////                        RoundedRectangle(cornerRadius: 6)
////                            .strokeBorder(Color.gray.opacity(0.1), lineWidth: 2, antialiased: true)
////                    )
////                    .keyboardType(.numberPad)
////                    .onChange(of: pin5, perform: { value in
////                        if value.count > 0 {
////                            currentFocus += 1
////                        }
////                    })
////                    .onTapGesture {
////                        currentFocus = 4
////                    }
////
////                CocoaTextField("-", text: $pin6)
////                    .isFirstResponder(currentFocus == 5)
////                    .font(.system(size: 18, weight: .bold))
////                    .lineLimit(1)
////                    .frame(maxWidth: 50, maxHeight: 50, alignment: .center)
////                    .multilineTextAlignment(.center)
////                    .overlay(
////                        RoundedRectangle(cornerRadius: 6)
////                            .strokeBorder(Color.gray.opacity(0.1), lineWidth: 2, antialiased: true)
////                    )
////                    .keyboardType(.numberPad)
////                    .onChange(of: pin6, perform: { value in
////                        if value.count > 0 {
////                            currentFocus += 1
////                        }
////                    })
////                    .onTapGesture {
////                        currentFocus = 5
////                    }
//                
//            }.padding()
//            
//           
//                    
//                    
//                    Button("Confirm Code"){
//                      
//                        codestring = pin1+pin2+pin3+pin4
//                        
//                        confirmOTP()
////                        viewModel.verifyCode(code: code)
//                            }.font(.custom("Inter-Bold", size: 20))
//                    .foregroundColor(Color.white)
//                    .frame(maxWidth: UIScreen.main.bounds.width / 1.6, maxHeight: 50)                    .background(Color("themecolor 1"))
//                    .cornerRadius(25)
//                    .shadow(color: Color("themecolor 1").opacity(0.8), radius: 6, x: 1, y: 1)
////                    .opacity(viewModel.isLoadingVerify ? 0.2 : 1)
////                    .overlay(
////                        viewModel.isLoadingVerify ? ProgressView() : nil
////                    )
//                   // .padding()
////                    .disabled(viewModel.isLoadingVerify)
//                 .fullScreenCover(isPresented: $showresetpwd, content: {
//                    resetPwd(emailstring :emailstring, tokenstring :tokenstring)
//                            })
//                   
//                    
//                    
//                    
////            Button(action: {
////
////                let code = pin1+pin2+pin3+pin4+pin5+pin6
////                viewModel.verifyCode(code: code)
////
////            }, label: {
////                Text("Submit")
////                    .font(.headline)
////                    .fontWeight(.bold)
////                    .foregroundColor(.white)
////                    .frame(maxWidth: UIScreen.main.bounds.width / 1.6, maxHeight: 50)
////                    .background(login_button)
////                    .cornerRadius(6)
////                    .shadow(color: Color("Primary").opacity(0.8), radius: 6, x: 1, y: 1)
////                    .opacity(viewModel.isLoadingVerify ? 0.2 : 1)
////                    .overlay(
////                        viewModel.isLoadingVerify ? ProgressView() : nil
////                    )
////            })
////            .padding()
////            .disabled(viewModel.isLoadingVerify)
////        } .frame(maxWidth: UIScreen.main.bounds.width / 1.4)
////                .padding(.horizontal, 30.0)
////        .background(Color.white)
////        .clipShape(
////            RoundedRectangle(cornerRadius: 25)
////        )
////        .shadow(color: Color.black.opacity(0.2), radius: 25, x: 1, y: 1)
////
//            
//                HStack {
////                    Text("Don't receive the OTP Code?")
////                        .font(.callout)
////                        .foregroundColor(.gray)
////
//                    Button(action: {}, label: {
//                        Text("Resend the code")
//                            .font(.callout)
//                            .fontWeight(.bold)
//                            .foregroundColor(Color("themecolor"))
//                    })
//                }
//                .frame(height: 100.0)
////                Text(" \("Some") Seconds Wait")
////                    .font(.callout)
////                    .foregroundColor(.gray)
//            Spacer()
//            }
            
           
        }//.offset(y: 60)
        
    }
        
        
}
    
    func confirmOTP() {
        
        var logInFormData: Parameters {
            [
                "email":    UserDefaults.standard.string(forKey: "emailf") ?? ""                             //UserDefaults.standard.set(forgtmail, forKey: "emailf")
,
                "otp": codestring

                  ]
        
        }
       
            print(logInFormData)

            
                    AccountAPI.signin(servciename: "Accounts/CheckOTPExist", logInFormData) { res in
                    switch res {
                    case .success:
                        print("resulllll",res)
                        if let json = res.value{
                           
                           
                            print("Josn",json)
                            if (json["status"] == "true")
                            {
                               
                                tokenstring = json["data"].stringValue
                                self.showresetpwd.toggle()
                                UserDefaults.standard.set(tokenstring, forKey: "tokenf")

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
//                             self.showingAlert.toggle()
//                             self.message = json["message"].stringValue
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
struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        Verification()
    }
}
