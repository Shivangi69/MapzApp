//
//  Termscondition.swift
//  MapzApp
//
//  Created by Rohit wadhwa on 16/07/24.
//

import SwiftUI

struct Termscondition: View {
    
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
                        
                        Text("Terms and Conditions")
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
                
                    WebView(url: URL(string: "http://mapzapp.com/terms-and-conditions.html")!)
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
