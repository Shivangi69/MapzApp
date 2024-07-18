//
//  SettingVIew.swift
//  MapzApp
//
//  Created by Misha Infotech on 01/12/2022.
//

import SwiftUI

struct SettingVIew: View {

    @State var showEditProfile = false
    @State var showMyActivity = false
    @State var showChangePassword = false
    @State var showaboutus = false
    @State var showtermandconditions = false

    @State var showPrivacyPolicy = false
    @State var showLoginProfile = false

    @State var logout = false

    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        ZStack{
            VStack(alignment: .leading, spacing: 20.0) {
                
                //                HStack(spacing: 20.0) {
                //
                //                }
                //                .frame(height: 5.0)
                //                .background(Color.white)
                
                VStack(alignment: .leading) {
                    // Spacer(minLength: 12)
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Image("back")
                            .resizable()
                            .frame(width: 24.0, height: 24.0)
                        //    .padding(.top,12.0)
                        
                        //.cornerRadius(24)
                    }
                    Text("Settings")
                        .foregroundColor(Color.black)
                        .font(.custom("Inter-Bold", size: 20))
                }
                .padding(.trailing, 250.0)
              //  .padding(.bottom, 12.0)
                
                HStack{
                    
                }
                .frame(width: UIScreen.main.bounds.width-30, height: 1.0)
                .border(Color.black, width: 1)
                .padding(.bottom,
                         3.0)
                
                VStack(alignment: .leading, spacing : 20.0){
                    HStack{
                        Image("Image 1")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                        Text("Edit Profile")
                       .font(.custom("Inter-Regular", size: 17))
                    }
                    .onTapGesture {
                        showEditProfile.toggle()
                    }
                    
                    .fullScreenCover(isPresented: $showEditProfile, content: {
                        EditProfileView()
                    })
                    
                    
                    HStack{
                        Image("icons8-menu-50")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                        Text("My Activity")
                            .font(.custom("Inter-Regular", size: 17))
                    }
                    .onTapGesture {
                        showMyActivity.toggle()
                    }
                    
                    .fullScreenCover(isPresented: $showMyActivity, content: {
                        DairyList()
                    })
                    
                    
                    HStack{
                        Image("key")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                        Text("Change Password")
                            .font(.custom("Inter-Regular", size: 17))
                    }
                    .onTapGesture {
                        showChangePassword.toggle()
                    }
                    
                    .fullScreenCover(isPresented: $showChangePassword, content: {
                        ChangePwdView()
                    })
                    HStack{
                        Image("icons8-privacy-64")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                        Text("Privacy Policy")
                            .font(.custom("Inter-Regular", size: 17))
                    }
                    .onTapGesture {
                        showPrivacyPolicy.toggle()
                    }

                    .fullScreenCover(isPresented: $showPrivacyPolicy, content: {
                        PrivacyPloicy()
                    })
                    
                    
                    HStack{
                        Image("about")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                        Text("About us")
                            .font(.custom("Inter-Regular", size: 17))
                    }
                    .onTapGesture {
                        showaboutus.toggle()
                        
                    }
                    .fullScreenCover(isPresented: $showaboutus, content: {
                        Aboutus()
                    })
                    
                    HStack{
                        Image("Image 2")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                        Text("Terms and Conditions")
                            .font(.custom("Inter-Regular", size: 17))
                    }
                    .onTapGesture {
                        showtermandconditions.toggle()
                        
                    }
                    
                    .fullScreenCover(isPresented: $showtermandconditions, content: {
                        Termscondition()
                    })
                    HStack{
                        Image("icons8-logout-rounded-50")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                        Text("Logout")
                            .font(.custom("Inter-Regular", size: 17))
                    }
                    .onTapGesture {
                        
                        clear()
                        showLoginProfile.toggle()
                    }

                    .fullScreenCover(isPresented: $showLoginProfile, content: {
                        LoginViews()
                    })
                }
                Spacer()
            }
        }
    }
    
    func clear()  {
        let str = UserDefaults.standard.string(forKey: "devicetoken") ?? ""
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        UserDefaults.standard.setValue(str, forKey: "devicetoken")
    }
}
    
    struct SettingVIew_Previews: PreviewProvider {
        static var previews: some View {
            SettingVIew()
        }
    }
