//
//  PackageSelection.swift
//  MapzApp
//
//  Created by Admin on 29/12/22.
//

import SwiftUI
import Alamofire

struct PackageSelection: View {
    @Environment(\.presentationMode) var presentationMode
    @State var heightplus : CGFloat = 35
    @ObservedObject var obs = PackageObservable()
    @State var showfriendlist: Bool = false
    @State var showCreategroup: Bool = false
    @ObservedObject var model = MyBackendModel()
    @State var packageID : String = ""
    @State var showNextView = false
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Spacer()
                    .frame(height :heightplus)
                
                VStack(alignment: .trailing){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    })
                    {
                        Spacer()
                        
                        Image("cross")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                    }
                }.padding(.horizontal , 10)
                HStack(spacing : 10) {
                    
                    
                    Text("Package Selection")
                        .foregroundColor(Color.black)
                        .font(.custom("Inter-Bold", size: 20))
                        .padding(.leading, 16.0)
                   
                    Spacer()
                }.padding(.horizontal , 10)
                HStack{
                    
                }
                .frame(width: UIScreen.main.bounds.width-30, height: 1.0)
                .border(Color.black, width: 1)
                .padding(.bottom,  3.0)
                   
                         QGrid(obs.GroupList,
                                  columns: 2,
                                  columnsInLandscape: 3,
                                  vSpacing: 20,
                                  hSpacing: 10,
                                  vPadding: 10,
                                  hPadding: 10) { person in
                             GridCellforpackages(person: person)
                                 .onTapGesture {
                                     showfriendlist.toggle()
                                     packageID = String(person.id)
                                     print(person.amount)
                                     model.amount  = person.amount
                                     model.preparePaymentSheet()
                                 }
//                                 .fullScreenCover(isPresented: $showfriendlist, content: {
//                                     UpdateGroup( groupDetail: person)
//                                 })
                            }
                         
                       
//                QGrid(obs.GroupList, columns: 3) {
//
//
//                    GridCellforpackages(person: $0)
//
//                }

                
             //   if obs.showview{
//                ScrollView{
//                    VStack{
//                          ForEach(obs.GroupList, id: \.self) { pokemon in
//                           // FeedViewCell(GroupList : pokemon)
//                        }
//                    }
//                }
                
                
              Spacer()
              
             
                Spacer()
                    .frame(height :heightplus)
              //  }
            }.edgesIgnoringSafeArea(.all)
            .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
            .onAppear(){
             
             if UIDevice.current.hasNotch {
                 heightplus = 35
             } else {
                 //... don't have to consider notch
                 heightplus = 20
             }
                
         }
            if (model.showpaymentPage == true){
                VStack{
                    
                    Spacer()
                        .frame(height :heightplus)
                    
                    VStack(alignment: .trailing){
                        Button(action: {
                            model.showpaymentPage = false
                            
                        })
                        {
                            Spacer()
                            
                            Image("cross")
                                .resizable()
                                .frame(width: 30.0, height: 30.0)
                        }
                    }.padding(.horizontal , 10)
                    HStack(spacing : 10) {
                        
                        Text("Pay Now")
                            .foregroundColor(Color.black)
                            .font(.custom("Inter-Bold", size: 20))
                            .padding(.leading, 16.0)
                       
                        Spacer()
                    }.padding(.horizontal , 10)
                    HStack{
                        
                    }
                    .frame(width: UIScreen.main.bounds.width-30, height: 1.0)
                    .border(Color.black, width: 1)
                    .padding(.bottom,  3.0)
                    
                    Spacer()
                    
                    if let paymentSheet = model.paymentSheet {
                        PaymentSheet.PaymentButton(
                            paymentSheet: paymentSheet,
                            onCompletion: model.onCompletion
                        ) {
                            ExamplePaymentButtonView()
                        }
                    } else {
                        ExampleLoadingView()
                    }
                    if let result = model.paymentResult {
                      //  ExamplePaymentStatusView(result: result)
                        
                        HStack{
                            switch result {
                            case .completed:
                                Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                                Text("Your order is confirmed!")
                                    .onAppear(){
                                        savePayment()
                                    }
                            case .failed(let error):
                                Image(systemName: "xmark.octagon.fill").foregroundColor(.red)
                                Text("Payment failed: \(error.localizedDescription)")
                            case .canceled:
                                Image(systemName: "xmark.octagon.fill").foregroundColor(.orange)
                                Text("Payment canceled.")
                            }
                        }
                    }
                    Spacer()
                }.edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .background(Color.white)
                    .fullScreenCover(isPresented: $showNextView, content: MainView.init)

            }
        }
        
    }
    func savePayment(){
        UIApplication.dismissKeyboard()

        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = dateFormatter.string(from: date)
        print(someDateTime) // may print: 13
        
        var timeinmilli = Int()
        timeinmilli =    Int(Date().millisecondsSince1970) // 1641554695757

        var logInFormData: Parameters {
            [
                "packageId": packageID,
                  "orderId": String(timeinmilli),
                "userId":  Int(UserDefaults.standard.string(forKey: "id") ?? "0") ?? 0,
                  "paymentstatus": true,
                  "transactionId": String(timeinmilli),
                  "createdDate": someDateTime
                  ]

        }
        print(logInFormData)
 //http://grocery.swadhasoftwares.com/api/profile.php
       
        AccountAPI.signin(servciename: "UsersPaymentCategory/PaymentStatus", logInFormData) { res in
        switch res {
        case .success:
            print("resulllll",res)
            if let json = res.value{


                print("Josn",json)
       if (json["status"] == "true")
       {
                let userdic = json["data"]

        
        
//        let fullName : String = userdic["dateOfBirth"].stringValue
//        let fullNameArr : [String] = fullName.components(separatedBy: "T")
//        let datestr: String = fullNameArr[0]
//
//        UserDefaults.standard.set(userdic["id"].int, forKey: "id")
//
//                UserDefaults.standard.set(userdic["email"].string, forKey: "email")
//               UserDefaults.standard.set(userdic["firstName"].string, forKey: "name")
//                UserDefaults.standard.set(userdic["password"].string, forKey: "passwordHash")
//                UserDefaults.standard.set(userdic["mobile"].string, forKey: "phoneNumber")
//                UserDefaults.standard.set(datestr, forKey: "dateOfBirth")
//           UserDefaults.standard.set(fullName, forKey: "DateOfBirth")
//           UserDefaults.standard.set(userdic["tagLine"].string, forKey: "phoneNumber")
//           UserDefaults.standard.set(userdic["totalFriend"].int, forKey: "totalFriend")
//           UserDefaults.standard.set(userdic["totalEvent"].int, forKey: "totalEvent")
//
//                UserDefaults.standard.set(userdic["profilePictureURL"].string, forKey: "profilePictureURL")
                UserDefaults.standard.set("true", forKey: "paymentStatus")
                UserDefaults.standard.set(userdic["group"].string, forKey: "group")
                UserDefaults.standard.set(userdic["packageId"].string, forKey: "packageId")
      //  UserDefaults.standard.set("yes", forKey: "login")

//                self.logindetails.append(acc)
//                print(self.logindetails)
       //
           self.showNextView.toggle()
       }
       else{
       //
//        self.message = json["message"].stringValue
//        self.showingAlert = true

      //  @Published  var showingAlert = false

//        AlertToast(displayMode: .alert, type: .regular, title: json["ResponseMsg"].stringValue )
//        AlertToast(displayMode: .alert, type: .regular, title:json["ResponseMsg"].stringValue )

       }
              //  presentationmode(MainView().ondis)


////                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                           self.shouldRedirectToMAINView = true
//                       }

            }
        case let .failure(error):
          print(error)
        }
      }
    }
}

struct GridCellforpackages: View {
  var person: Package

  var body: some View {
    VStack(spacing: 10) {
        Text(person.type)
            .foregroundColor(Color("themecolor 1"))
            .font(.custom("Inter-Regular", size: 20))
        Text(String(person.minUser) + " - " + String(person.maxUser))
            .foregroundColor(Color("themecolor 1"))
            .font(.custom("Inter-Regular", size: 20))
           Spacer()
        HStack{
            Text("$ " + String(person.amount))
                .foregroundColor(Color.white)
                .font(.custom("Inter-Regular", size: 20))
        }
            .frame(width: UIScreen.main.bounds.width/2 - 30, height : 30)
            .background(Color("themecolor 1"))
    }.background(Color.white)
          .cornerRadius(10)
          .frame(width: UIScreen.main.bounds.width/2 - 30 )
          .shadow(color:  .gray, x: 1, y: 1, blur: 0.1)
  }
}

struct PackageSelection_Previews: PreviewProvider {
    static var previews: some View {
        PackageSelection()
    }
}
struct Package: Identifiable , Hashable {
    let type: String
    let amount: Double
    let minUser, maxUser, id: Int
    let createdAt, createdBy: String
    let modifiedAt, modifiedBy: String
    let version: String
    let isDeleted: Bool

    init(type: String, amount: Double, minUser: Int, maxUser: Int, id: Int, createdAt: String, createdBy: String, modifiedAt: String, modifiedBy: String, version: String, isDeleted: Bool) {
        self.type = type
        self.amount = amount
        self.minUser = minUser
        self.maxUser = maxUser
        self.id = id
        self.createdAt = createdAt
        self.createdBy = createdBy
        self.modifiedAt = modifiedAt
        self.modifiedBy = modifiedBy
        self.version = version
        self.isDeleted = isDeleted
    }
}
class PackageObservable: ObservableObject {

    @Published   var GroupList = [Package]()
    @Published   var showlist = false
    @Published   var addrsStr = String()
  

    init() {
        
        let str1  = "UsersPaymentCategory/GetAmountCategoryType"//str
        AccountAPI.getsignin(servciename: str1, nil) { res in
        switch res {
        case .success:
            print("resulllll",res)
            if let json = res.value{
                self.GroupList = []
                print("Josn",json)
              //  let userdic = json["data"]
                let events = json["data"]
                for i in events {
                    let members = i.1["members"]
                   let scc  = Package(type: i.1["type"].stringValue, amount:  i.1["amount"].doubleValue, minUser: i.1["minUser"].intValue, maxUser: i.1["maxUser"].intValue, id: i.1["id"].intValue, createdAt: i.1["createdAt"].stringValue, createdBy: i.1["createdBy"].stringValue, modifiedAt: i.1["modifiedAt"].stringValue, modifiedBy: i.1["modifiedBy"].stringValue, version: i.1["version"].stringValue, isDeleted:  i.1["isDeleted"].boolValue)
                  
                self.GroupList.append(scc)
                 
                }
             
                }
                print(self.GroupList)
        case let .failure(error):
          print(error)
        }
      }
    }
}
import StripePaymentSheet
import SwiftUI

struct ExampleSwiftUIPaymentSheet: View {
    @ObservedObject var model = MyBackendModel()

    var body: some View {
        VStack {
            if let paymentSheet = model.paymentSheet {
                PaymentSheet.PaymentButton(
                    paymentSheet: paymentSheet,
                    onCompletion: model.onCompletion
                ) {
                    ExamplePaymentButtonView()
                }
            } else {
                ExampleLoadingView()
            }
            if let result = model.paymentResult {
                ExamplePaymentStatusView(result: result)
            }
        }//.onAppear { model.preparePaymentSheet() }
    }

}

class MyBackendModel: ObservableObject

//{
//    let backendCheckoutUrl = URL(string: "https://stripe-mobile-payment-sheet.glitch.me/checkout")!  // An example backend endpoint
//    @Published var paymentSheet: PaymentSheet?
//    @Published var paymentResult: PaymentSheetResult?
//
//    func preparePaymentSheet() {
//        // MARK: Fetch the PaymentIntent and Customer information from the backend
//        var request = URLRequest(url: backendCheckoutUrl)
//        request.httpMethod = "POST"
//        let task = URLSession.shared.dataTask(
//            with: request,
//            completionHandler: { (data, response, error) in
//                guard let data = data,
//                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
//                        as? [String: Any],
//                    let customerId = json["customer"] as? String,
//                    let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
//                    let paymentIntentClientSecret = json["paymentIntent"] as? String,
//                    let publishableKey = json["publishableKey"] as? String
//
//                else {
//                    // Handle error
//                    return
//                }
//                // MARK: Set your Stripe publishable key - this allows the SDK to make requests to Stripe for your account
//                STPAPIClient.shared.publishableKey = publishableKey
//
//                // MARK: Create a PaymentSheet instance
//                var configuration = PaymentSheet.Configuration()
//                configuration.merchantDisplayName = "Example, Inc."
//                configuration.applePay = .init(
//                    merchantId: "com.foo.example", merchantCountryCode: "US")
//                configuration.customer = .init(
//                    id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
//                configuration.returnURL = "payments-example://stripe-redirect"
//                // Set allowsDelayedPaymentMethods to true if your business can handle payment methods that complete payment after a delay, like SEPA Debit and Sofort.
//                configuration.allowsDelayedPaymentMethods = true
//                DispatchQueue.main.async {
//                    self.paymentSheet = PaymentSheet(
//                        paymentIntentClientSecret: paymentIntentClientSecret,
//                        configuration: configuration)
//                }
//            })
//        task.resume()
//    }
//
//    func onCompletion(result: PaymentSheetResult) {
//        self.paymentResult = result
//
//        // MARK: Demo cleanup
//        if case .completed = result {
//            // A PaymentIntent can't be reused after a successful payment. Prepare a new one for the demo.
//            self.paymentSheet = nil
//            preparePaymentSheet()
//        }
//    }
//}

{
    let backendCheckoutUrl = URL(string: "http://mapzapp.com/api/PaymentCheckOut/PaymentToken")!  // An example backend endpoint
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    @Published var amount =  Double()
    @Published var showpaymentPage : Bool = false

    func preparePaymentSheet() {
        // MARK: Fetch the PaymentIntent and Customer information from the backend
        var request = URLRequest(url: backendCheckoutUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let cmdParams: [String: Any] =   ["secretkey": "sk_test_51MGz0ASAFRzpLP7D6FzUUk4TsWnBdbX9ufaGJ2VbzlD4bAQAqrWbuGnnwB9Wd0hecTumIwRNbd0Afti6He6eSeU000oCP69wMC",
        "publishableKey": "pk_test_51MGz0ASAFRzpLP7D1jDDrKQavJSzAXKDGx0oprog7ha2r5xN6V3h3uK1KNUE2Bbj6rdQ9E5TGkK8tz7oVSCwa8rk00xoh9J4a5",
                                          "amount": amount * 100,
        "name": UserDefaults.standard.string(forKey: "name") ?? "Gumshuda" ,
        "description":"Pay for Group",
        "customer": "",
        "Line1" : "test",
                                          
        "PostalCode" : "32332",
        "City" : "ddfdfd",
        "State" : "fdfd",
        "Country" : "fdf"
        ]


        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: cmdParams)
        } catch let error {
            print(error.localizedDescription)
            }
        let task = URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                        as? [String: Any],
                    let customerId = json["customer"] as? String,
                    let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
                    let paymentIntentClientSecret = json["paymentIntent"] as? String,
                    let publishableKey = json["publishablekey"] as? String
                        
                        
                else {
                    // Handle error
                    return
                }
                // MARK: Set your Stripe publishable key - this allows the SDK to make requests to Stripe for your account
                print(json)

                self.showpaymentPage = true

                STPAPIClient.shared.publishableKey = publishableKey

                // MARK: Create a PaymentSheet instance
                var configuration = PaymentSheet.Configuration()
                configuration.merchantDisplayName = "Example, Inc."
              //  configuration.applePay = .init(
               //     merchantId: "com.foo.example", merchantCountryCode: "US")
                configuration.customer = .init(
                    id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
                configuration.returnURL = "payments-example://stripe-redirect"
                // Set allowsDelayedPaymentMethods to true if your business can handle payment methods that complete payment after a delay, like SEPA Debit and Sofort.
                configuration.allowsDelayedPaymentMethods = true
                DispatchQueue.main.async {
                    self.paymentSheet = PaymentSheet(
                        paymentIntentClientSecret: paymentIntentClientSecret,
                        configuration: configuration)
                }

            })
        task.resume()
    }

    func onCompletion(result: PaymentSheetResult) {
        self.paymentResult = result

        // MARK: Demo cleanup
        if case .completed = result {
            // A PaymentIntent can't be reused after a successful payment. Prepare a new one for the demo.
            self.paymentSheet = nil
            preparePaymentSheet()
        }
    }
}


//
//  ExampleAdditions.swift
//  PaymentSheet Example
//
//  Created by David Estes on 1/15/21.
//  Copyright © 2021 stripe-ios. All rights reserved.
//

import StripePaymentSheet
import SwiftUI

struct ExamplePaymentButtonView: View {
    var body: some View {
        HStack {
            Text("Buy").fontWeight(.bold)
        }
        .frame(minWidth: 200)
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(6)
        .accessibility(identifier: "Buy button")
    }
}

struct ExampleLoadingView: View {
    var body: some View {
        if #available(iOS 14.0, *) {
            ProgressView()
        } else {
            Text("Preparing payment…")
        }
    }
}

struct ExamplePaymentStatusView: View {
    let result: PaymentSheetResult

    var body: some View {
        HStack {
            switch result {
            case .completed:
                Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                Text("Your order is confirmed!")
            case .failed(let error):
                Image(systemName: "xmark.octagon.fill").foregroundColor(.red)
                Text("Payment failed: \(error.localizedDescription)")
            case .canceled:
                Image(systemName: "xmark.octagon.fill").foregroundColor(.orange)
                Text("Payment canceled.")
            }
        }
        .accessibility(identifier: "Payment status view")
    }
}

struct ExamplePaymentOptionView: View {
    let paymentOptionDisplayData: PaymentSheet.FlowController.PaymentOptionDisplayData?

    var body: some View {
        HStack {
            Image(uiImage: paymentOptionDisplayData?.image ?? UIImage(systemName: "creditcard")!)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 30, maxHeight: 30, alignment: .leading)
                .foregroundColor(.black)
            Text(paymentOptionDisplayData?.label ?? "Select a payment method")
                // Surprisingly, setting the accessibility identifier on the HStack causes the identifier to be
                // "Payment method-Payment method". We'll set it on a single View instead.
                .accessibility(identifier: "Payment method")
        }
        .frame(minWidth: 200)
        .padding()
        .foregroundColor(.black)
        .background(Color.init(white: 0.9))
        .cornerRadius(6)
    }
}

struct ExampleSwiftUIViews_Preview: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 12) {
            ExamplePaymentOptionView(paymentOptionDisplayData: nil)
            ExamplePaymentButtonView()
            ExamplePaymentStatusView(result: .canceled)
            ExampleLoadingView()
        }
    }
}
extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
