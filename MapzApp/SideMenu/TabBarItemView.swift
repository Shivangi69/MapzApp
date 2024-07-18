//
//  TabBarViewItem.swift
//  CustomTabBar
//
//  Created by Satyadev Chauhan on 23/03/21.
//

import SwiftUI

struct TabBarItemView: View {
    
    var type: TabBarItem
    @Binding var selectedTab: TabBarItem
    
    var isSelected: Bool {
        return selectedTab == type
    }
    
    var body: some View {
        GeometryReader.init(content: { geometry in
            VStack{
            Button(action: {
                UserDefaults.standard.set("", forKey: "not")
                UserDefaults.standard.set("", forKey: "duration")
                UserDefaults.standard.set("", forKey: "sR")
                UserDefaults.standard.set("", forKey: "frID")
                UserDefaults.standard.set("", forKey: "sN")
                selectedTab = type
            }, label: {
                VStack {
                    Image(type.imageName + (isSelected ? "" : ""))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32 , height: 32  )

                    
                }
            })
            .frame(width: UIScreen.main.bounds.width/5 , height: 60  )
           // .frame(maxWidth: .infinity, maxHeight: .infinity)
            //.foregroundColor(isSelected ? .white : .clear)
               
                //Spacer()
//            HStack{
//
//            }
//            .frame(width: UIScreen.main.bounds.width/4, height: 2 )
//            .background(Color(isSelected ? .white : .clear))
//
            }
        })
        .frame(height: 60)
    }
}

struct TabBarViewItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItemView(type: .home, selectedTab: .constant(.home))
    }
}
