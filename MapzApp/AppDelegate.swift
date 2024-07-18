//
//  AppDelegate.swift
//  MapzApp
//
//  Created by Misha Infotech on 14/08/2021.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import UserNotifications
import Firebase
//import FirebaseInstanceID
import FirebaseMessaging
import FirebaseAuth
import FBSDKCoreKit
import Firebase
import GoogleSignIn
import TwitterKit
import CoreLocation
import Stripe

@main
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate ,UNUserNotificationCenterDelegate{

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSPlacesClient.provideAPIKey("AIzaSyBQ4-P2_4_-Ku6T85fNORYCfmnAm9NWxgY")
        GMSServices.provideAPIKey("AIzaSyBQ4-P2_4_-Ku6T85fNORYCfmnAm9NWxgY")
        FirebaseApp .configure()
        Messaging.messaging().delegate = self
       // FirebaseApp.configure()
      //  GIDSignIn.sharedInstance.clientID = FirebaseApp.app()?.options.clientID
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            application.registerForRemoteNotifications()
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                           categories: nil)
            application.registerUserNotificationSettings(settings)
        }
       
//             InstanceID.instanceID().instanceID { (result, error) in
//                 if let error = error {
//                     print("Error fetching remote instance ID: \(error)")
//                 } else if let result = result {
//                     print("Remote instance ID token: \(result.token)")
//
//                 }
//             }
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
       // GIDSignIn.sharedInstance()?.restorePreviousSignIn()
//        GIDSignIn.sharedInstance().restorePreviousSignIn { user, error in
//            if error != nil || user == nil {
//              // Show the app's signed-out state.
//            } else {
//              // Show the app's signed-in state.
//            }
//          }
        //TWTRTwitterKit.sharedInstance.
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
       // Twitter.sharedInstance().start(withConsumerKey:"JsogaghK7dO5EGYwPyGI650jC", consumerSecret:"CdwTiNi8WWH6Ma7JPGdoVJO6RW3B9X2UipvWUoXRBxxncs4JaP")
        TWTRTwitter.sharedInstance().start(withConsumerKey:"JsogaghK7dO5EGYwPyGI650jC", consumerSecret:"CdwTiNi8WWH6Ma7JPGdoVJO6RW3B9X2UipvWUoXRBxxncs4JaP")

        UserDefaults.standard.set(token ?? "eDAt9YjlnkR3o7JhslF_Fw:APA91bFEyMZXsB8JWTzrvVaz9xGXFIo-ctTHPS1qdYmUpgJI4t29dzz6VjSQKnxDFFZ6bn6tPbOtXNolpef0f8-s2t14mP-FSfvLSXfGTOR00V5PYj0BYcrRvAYUkUdOh4eHN7yPeqIx", forKey: "devicetoken")
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        return true
    }
    // This method handles opening custom URL schemes (for example, "your-app://stripe-redirect")
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if TWTRTwitter.sharedInstance().application(app, open: url, options: options) {
            return true
        }
        
        let stripeHandled = StripeAPI.handleURLCallback(with: url)
        if (stripeHandled) {
            return true
        } else {
            // This was not a Stripe url – handle the URL normally as you would
        }
        var handled: Bool

        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
          return true
        }
        return false
    }
    
    

    
    
    
    
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//            if Twitter.sharedInstance().application(app, open: url, options: options) {
//                return true
//            }
//
//     return false
//    }
//    // This method handles opening universal link URLs (for example, "https://example.com/stripe_ios_callback")
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool  {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if let url = userActivity.webpageURL {
                let stripeHandled = StripeAPI.handleURLCallback(with: url)
                if (stripeHandled) {
                    return true
                } else {
                    // This was not a Stripe url – handle the URL normally as you would
                }
            }
        }
        return false
    }
    // MARK: UISceneSession Lifecycle
//    func application(
//      _ app: UIApplication,
//      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
////    ) -> Bool {
//      var handled: Bool
//
//        handled = GIDSignIn.sharedInstance().handle(url)
//      if handled {
//        return true
//      }
//
//      // Handle other custom URL types.
//
//      // If not handled by this app, return false.
//      return false
//    }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let firebaseAuth = Auth.auth()
        
        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.prod)
        
        //   Auth.auth().setAPNSToken(deviceToken, type: .prod)
        
        
        var token = ""
        Messaging.messaging().apnsToken = deviceToken
        
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        //  userDefault.set(token, forKey: "deviceToken")
        print("Registration succeeded!")
        print("Token: ", token)
        if token == "" {
            token = "eDAt9YjlnkR3o7JhslF_Fw:APA91bFEyMZXsB8JWTzrvVaz9xGXFIo-ctTHPS1qdYmUpgJI4t29dzz6VjSQKnxDFFZ6bn6tPbOtXNolpef0f8-s2t14mP-FSfvLSXfGTOR00V5PYj0BYcrRvAYUkUdOh4eHN7yPeqIx"
        }
        UserDefaults.standard.set(token , forKey: "devicetoken")

    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MapzApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

