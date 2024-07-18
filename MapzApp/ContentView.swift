//
//  ContentView.swift
//  MapzApp
//
//  Created by Misha Infotech on 14/08/2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var twitterAPI = TwitterAPI() //1
    
    var body: some View {
        //
        //
        // ExampleSwiftUIPaymentSheet()
        //
        //
        //
        //PackageSelection()
        if (UserDefaults.standard.string(forKey: "login") == nil) {
            
            LoginViews()
                .environmentObject(twitterAPI)
                .onOpenURL { url in
                    guard let urlScheme = url.scheme,
                          let callbackURL = URL(string: "\(TwitterAPI.ClientCredentials.CallbackURLScheme)://"),
                          let callbackURLScheme = callbackURL.scheme
                    else { return }
                    
                    guard urlScheme.caseInsensitiveCompare(callbackURLScheme) == .orderedSame
                    else { return }
                    
                    twitterAPI.onOAuthRedirect.send(url)
                }
        }
        else {
            
            MainView()
            //  SettingVIew()
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//import StripePaymentSheet
//import SwiftUI
//
//class MyBackendModel: ObservableObject {
//  //let backendCheckoutUrl = URL(string: "Your backend endpoint")! // Your backend endpoint
//  @Published var paymentSheet: PaymentSheet?
//  @Published var paymentResult: PaymentSheetResult?
//
//  func preparePaymentSheet() {
//    // MARK: Fetch the PaymentIntent and Customer information from the backend
////    var request = URLRequest(url: backendCheckoutUrl)
////    request.httpMethod = "POST"
////    let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
////      guard let data = data,
////            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
////            let customerId = json["customer"] as? String,
////            let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
////            let paymentIntentClientSecret = json["paymentIntent"] as? String,
////            let self = self else {
////        // Handle error
////        return
////      }
////
////
////    })
////    task.resume()
////
//      STPAPIClient.shared.publishableKey =                 "pk_test_51MGz0ASAFRzpLP7D1jDDrKQavJSzAXKDGx0oprog7ha2r5xN6V3h3uK1KNUE2Bbj6rdQ9E5TGkK8tz7oVSCwa8rk00xoh9J4a5"
//
//      let customerId = "123"
//      let customerEphemeralKeySecret = ""
//      let paymentIntentClientSecret = "sk_test_51MGz0ASAFRzpLP7D6FzUUk4TsWnBdbX9ufaGJ2VbzlD4bAQAqrWbuGnnwB9Wd0hecTumIwRNbd0Afti6He6eSeU000oCP69wMC"
//
//
//
//    // MARK: Create a PaymentSheet instance
//    var configuration = PaymentSheet.Configuration()
//    configuration.merchantDisplayName = "Example, Inc."
//
//          // configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
//    // Set `allowsDelayedPaymentMethods` to true if your business can handle payment methods
//    // that complete payment after a delay, like SEPA Debit and Sofort.
//    configuration.allowsDelayedPaymentMethods = true
//
//    DispatchQueue.main.async {
//      self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
//    }
//
//
//  }
//
//  func onPaymentCompletion(result: PaymentSheetResult) {
//    self.paymentResult = result
//  }
//}
//
//struct CheckoutView: View {
//  @ObservedObject var model = MyBackendModel()
//
//  var body: some View {
//    VStack {
//      if let paymentSheet = model.paymentSheet {
//        PaymentSheet.PaymentButton(
//          paymentSheet: paymentSheet,
//          onCompletion: model.onPaymentCompletion
//        ) {
//          Text("Buy")
//        }
//      } else {
//        Text("Loading…")
//      }
//      if let result = model.paymentResult {
//        switch result {
//        case .completed:
//          Text("Payment complete")
//        case .failed(let error):
//          Text("Payment failed: \(error.localizedDescription)")
//        case .canceled:
//          Text("Payment canceled.")
//        }
//      }
//    }.onAppear { model.preparePaymentSheet() }
//  }
//}

