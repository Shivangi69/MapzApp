//
//  ItemListView.swift
//  SlideOutMenu
//
//  Created by Liu Chuan on 2020/12/05.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var title: String
    var image: String
}

struct ItemRow: View {
    var item: Item
    @State var showPopup = false
    func actionSheet() {
            guard let data = URL(string: "https://www.zoho.com") else { return }
            let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        }
    @Binding var wdith: CGFloat
    
    @Binding var x: CGFloat
    
    var body: some View {
        VStack{
            HStack(spacing: 20.0) {
            
//            Image(item.image)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 25, height: 25)
            Text(item.title)
                .font(.headline)
                .foregroundColor(Color("themecolor"))

            Spacer()
        }
            .contentShape(Rectangle())

        .padding(.leading, 20.0)
        .frame(width: wdith )
        
        .onTapGesture {
            
            print(item.title)
            if item.title == "Home"{
                withAnimation {
                   x = -wdith
                }
                showPopup.toggle()
            }
            
           else if item.title == "Notification"{
            UserDefaults.standard.set("sm", forKey: "not")
            showPopup.toggle()
            }
           else if (item.title == "" || item.title == "Privacy Policy" || item.title == "Refer App to Friends" || item.title == "Rate On Store") {
                return
            }//
           else if item.title == "My Diary"{
            UserDefaults.standard.set("", forKey: "duration")
            showPopup.toggle()
           }
           else if item.title == "Logout"{
                clear()
            showPopup.toggle()
            }
           else{
            showPopup.toggle()
           }
            
        }.fullScreenCover(isPresented: $showPopup, content: {
            if item.title == "Home"{
                MainView()
            }
           else if item.title == "My Diary"{
                //ProfileView(x: $x, selectedTab: "")
            }
           else if item.title == "My Pin List"{
                mypinList()
            }
           else if item.title == "My Friends"{
                friendsList()
            }
//            if item.title == "My Diary"{
//                activityList()
//            }
            
           else if item.title == "Notification"{

                notificationList()
            }
            
           else  if item.title == "My Activity"{
                DairyList()
            }

            
           else if item.title == "Logout"{

                LoginViews()
            }
           else   if item.title == "Change Password"{
                ChangePwdView()
            }
//            if item.title == "Privacy Policy"{
//                LoginViews()
//            }
//            if item.title == "Refer App to Friends"{
//                LoginViews()
//            }
        })
            Spacer()
            HStack{}
                .frame(width: wdith - 40 ,height: 2)
                .background((Color("yellowColor")))
            Spacer()

        }
        .padding(.vertical, 20.0)
        //.padding(.all, 20.0)//
        
    }
    
    
    func clear()  {
        let str = UserDefaults.standard.string(forKey: "devicetoken") ?? ""
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        UserDefaults.standard.setValue(str, forKey: "devicetoken")
    }
}

struct ItemListView: View {
    
    @Binding var dark: Bool
    @State var showPopup = false
    @Binding var wdith: CGFloat
    
    
    @Binding var x: CGFloat
    
    var items: [Item] = [
        Item(title: "Home", image: ""),
        Item(title: "My Diary", image: ""),
        //Item(title: "My Diary", image: ""),
        Item(title: "My Pin List", image: ""),
       // Item(title: "My Friends", image: ""),
       // Item(title: "Notification", image: ""),
        Item(title: "My Activity", image: ""),
        Item(title: "Change Password", image: ""),
        Item(title: "Privacy Policy", image: ""),
        Item(title: "Rate On Store", image: ""),
        Item(title: "Refer App to Friends", image: ""),
        Item(title: "Logout", image: ""),
       
    ]
    
    var body: some View {
        
        
        
//        ZStack {
//            VStack(){
//            HStack {
//                VStack(alignment: .leading) {
//                    
//                    HStack (){
//                        Image("icons8-male-user-72")
//                            .resizable()
//                            .frame(width: 90, height: 90)
//                            .clipShape(Circle())
//                        //
//                        //Spacer()
//                        
//                        VStack(alignment: .leading) {
//
//                            Spacer(minLength: 20)
//                            //lineSpacing(20)
//                            Text(UserDefaults.standard.string(forKey: "mobile")!)
//                            .foregroundColor(.black)
//                            .font(.body)
//                        Text(UserDefaults.standard.string(forKey: "email")!)
//                            .foregroundColor(.black)
//                            .font(.body)
//                         
//                            
//                            HStack {
//                                Image("wallet")
//                                    .resizable()
//                                    .frame(width: 24, height: 24)
//                                    .clipShape(Circle())
//                                Text(UserDefaults.standard.string(forKey: "wallet")!)
//                                    .foregroundColor(.black)
//                                    .font(.body)
//                            }
//                        }
//                        Button(action: {
//                            withAnimation {
//                                x = -wdith - 10// 动画改变x值 -> 打开滑动菜单
//                            }
//                        }) {
//                            Image("close-with-transparency")
//                                .resizable()
//                                .frame(width: 35, height: 35)
//                        }
//                        
//                    }
//                    
//                }
//                
//
//            }
//            .padding()
//        }
//        .frame(width: self.wdith+20, height: 200)
//        .background(colorPrimarygreen)
//        
//        //.background(HeaderViewBackground(x: $x))
//    }
        
      
        
        VStack(alignment: .leading) {
            
            
            ScrollView{
                Spacer(minLength: 20)
                
                HStack(alignment: .center, spacing: 20.0) {
//                    Image( "icons8-male-user-72")
//                        .resizable()
//                        .frame(width: 70, height: 70)
//                        .aspectRatio(contentMode: .fit)
                    AsyncImage(
                        url: NSURL(string: UserDefaults.standard.string(forKey: "profilePictureURL")!)! as URL ,
                                       placeholder: { Image("icons8-male-user-72")
                                      
                                        .resizable()
                                        .foregroundColor(colorGrey1)
                                        .aspectRatio(contentMode: .fill)
                                       },
                                                   image: { Image(uiImage: $0).resizable()

                                                        }
                                   )
                   
                    .frame(width: 70, height: 70)
                    .cornerRadius(35)
                     .aspectRatio(contentMode: .fit)
                    
                    Text(UserDefaults.standard.string(forKey: "name") ?? "")
                        .foregroundColor(Color("themecolor"))

                        .font(.custom("Inter-Regular", size: 17))
    Spacer()
                }.padding(.leading, 20.0).frame( height: 70)
                
                
                
            ForEach(items, id: \.title){thisItem in
            //List(items, id: \.title) { thisItem in
                ItemRow(item: thisItem , wdith: $wdith, x: $x)
                    .frame(height: 50)
    
            }
          
            }.background(Color("lightBlue"))
            .cornerRadius(30)
        }
        
    }
    struct PlayerView: View {
        let name: String

        var body: some View {
            Text("Selected player: \(name)")
                .font(.largeTitle)
        }
    }
}
