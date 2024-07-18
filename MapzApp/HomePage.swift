//
//  HomePage.swift
//  SlideOutMenu
//
//  Created by Liu Chuan on 2020/12/05.
//

import Alamofire
import SwiftUI
//import SwiftyJSON
import SSSwiftUILoader

public let colorPrimarygreen = Color(red: 181 / 255, green: 242 / 255, blue: 137 / 255)
public  let colorPrimary = Color(red: 185 / 255, green: 243 / 255, blue: 119 / 255)
let baseURLimg = "http://grocery.swadhasoftwares.com/"

    public  let colorPrimarytext = Color(red: 99 / 255, green: 177 / 255, blue: 9 / 255)
    public  let colorPrimaryDark = Color(red: 185 / 255, green: 243 / 255, blue: 119 / 255)
    public  let colorAccent = Color(red: 185 / 255, green: 243 / 255, blue: 119 / 255)
    public  let colorWhite = Color(red: 225 / 255, green: 255 / 255, blue: 255 / 255)
   // public  let colorGrey = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
public  let colorGrey = Color(red: 235 / 255, green: 232 / 255, blue: 234 / 255)
    public  let colorGrey1 = Color(red: 136 / 255, green: 136 / 255, blue: 136 / 255)
    public  let colorGrey2 = Color(red: 90 / 255, green: 90 / 255, blue: 90 / 255)
    public  let colorBalck = Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255)
    public  let colorRad = Color(red: 215 / 255, green: 28 / 255, blue: 50 / 255)
    public  let colorYellow = Color(red: 241 / 255, green: 161 / 255, blue: 40 / 255)
   // public  let colorTranfar = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)#7FFBFAFA</color>
    public  let colorGrey0 = Color(red: 239 / 255, green: 237 / 255, blue: 237 / 255)
    public  let facebook_button = Color(red: 36 / 255, green: 71 / 255, blue: 137 / 255)
    public  let color_deep_purple = Color(red: 158 / 255, green: 0 / 255, blue: 93 / 255)
    public  let google_button = Color(red: 227 / 255, green: 83 / 255, blue: 86 / 255)
public  let login_button = Color(red: 63 / 255, green: 164 / 255, blue: 63 / 255)
let baseURLimg1 = URL(string: "http://grocery.swadhasoftwares.com/")
//http://grocery.swadhasoftwares.com/api/login.php
struct QConstants {
  static let showDesigner = true
  static let columnsMax = 8
  static let vSpacingMaxToGeometryRatio: CGFloat = 0.5 // 50%
  static let vPaddingMaxToGeometryRatio: CGFloat = 0.3 // 30%
  static let hPaddingMaxToGeometryRatio: CGFloat = 0.3 // 30%
}

struct HomePage: View {
   // @ObservedObject var obs = HomeObserver()
    @Binding var x : CGFloat
    @State private var search: String = ""
    @Environment(\.managedObjectContext) var moc

    @Environment(\.presentationMode) var presentationMode

    
    @Binding var isDark: Bool
    @State var index = 0
   // var arrImage = ["bnr1", "ban2", "collage", "collage"]
    @State var columns: CGFloat = 3.0
    @State var vSpacing: CGFloat = 10.0
    @State var hSpacing: CGFloat = 10.0
    @State var vPadding: CGFloat = 0.0
    @State var hPadding: CGFloat = 10.0
    @State var showcartView = false
    @State var shownotiView = false
    @State var selectedTab: TabBarItem = .home

    var body: some View {
        ZStack{
           // Color("bluecolor")

        VStack(spacing: 0.0) {
            switch selectedTab {
            case .home:
                
                ProfileView(selectedTab: "")
            case .Friends:
                FeedView()
            case .Notification:

                notificationList()
            case .search:
                SearchResultView()
               // SearchResult(text: "", selectedTab: "")
            case .Add:
                HomeView()
            }
            
          //  Spacer()
            TabBarView(tabs: TabBarItem.allCases, selectedTab: $selectedTab)


        }
        .edgesIgnoringSafeArea(.all)
            
        }
        
    }

    
}


