//
//  Aboutus.swift
//  MapzApp
//
//  Created by Rohit wadhwa on 13/12/23.
//

import SwiftUI
//
//struct Aboutus: View {
//    @Environment(\.presentationMode) var presentationMode
//    
//    
//    var body: some View {
//        ZStack{
//            VStack{
//                HStack{
//                    VStack(alignment: .leading, spacing : 12.0) {
//                        
//                        Button(action: {
//                            presentationMode.wrappedValue.dismiss()
//                            
//                        }) {
//                            Image("back")
//                                .resizable()
//                                .frame(width: 24.0, height: 24.0)
//                            //    .padding(.top,12.0)
//                            
//                            //.cornerRadius(24)
//                        }
//                        Text("About us")
//                            .foregroundColor(Color.black)
//                            .font(.custom("Inter-Bold", size: 18))
//                    }
//                    Spacer()
//                }.padding(.horizontal , 10)
//                
//                VStack {
//                    
//                    Image("logo")
//                        .resizable()
//                        .frame(width:  UIScreen.main.bounds.width-30, height: 120)
//                    
//                }
//                .frame(width: UIScreen.main.bounds.width, height: 150)
//                .background(Color.blue)
//                
//                
//                VStack(spacing: 5.0){
//                   
//                    Text("Need Some help ?")
//                    
//                    Text("Mobile- 1234567890")
//                        .foregroundColor(Color.gray)
//                    Text("Email- Jerome@venglass.co.uk")
//                        .foregroundColor(Color.gray)
//
//                    Text("App Version- 6.0")
//                        .foregroundColor(Color.gray)
//
//
//                }
//                Spacer()
//                
//            }
//        }
//    }
//}
//
//#Preview {
//    Aboutus()
//}
 
struct Aboutus: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var privaycPolicy = String()
    @State private var showWebView = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    
                    HStack{
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            
                        })
                        {
                            Image("back")
                                .resizable()
                                .frame(width: 24.0, height: 24.0)
                                .cornerRadius(24)
                        }
                        Spacer()
                        
                        Text("About Us")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .bold ))
                        Spacer()
                        
                        Image("")
                            .resizable()
                            .frame(width: 48.0, height: 48.0)
                            .cornerRadius(24)
                        
                        // Spacer()
                        
                    }
                    .padding()
                    .background(Color.white)
                    
                    Divider()
                
                    WebView(url: URL(string: "http://122.176.104.29:55020/aboutus")!)
                }
                .onAppear(){
                    
                    //  self.fetch()
                }
            }
                .navigationBarHidden(true)
            
        }
        .edgesIgnoringSafeArea(.all)
 
    }
    func fetch() {
        
        AccountAPI.getsignin(servciename: "GetPolicy", nil) { res in
            switch res {
            case .success:
                print("resulllll",res)
                
                if let json = res.value{
                    
                    print("Josn",json)
                    
                    
                    let events = json["data"]
                    privaycPolicy = events["privacy"].stringValue
                }
                
                
            case let .failure(error):
                print(error)
            }
        }
    }
}


//import WebKit
//import SwiftUI
//
//struct HTMLStringView: UIViewRepresentable {
//    let htmlContent: String
//
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.loadHTMLString(htmlContent, baseURL: nil)
//    }
//}
//
//struct WebView: UIViewRepresentable {
//
//    var url: URL
//
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//
//    func updateUIView(_ webView: WKWebView, context: Context) {
//        let request = URLRequest(url: url)
//        webView.load(request)
//    }
//}
