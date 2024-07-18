//
//  MenuHeaderView.swift
//  SlideOutMenu
//
//  Created by Liu Chuan on 2020/12/05.
//

import SwiftUI

struct MenuHeaderView: View {
    
    @Binding var wdith: CGFloat
    
    
    @Binding var x: CGFloat
    let name : String = ""

    var body: some View {
        
        ZStack {
           // HStack {
              //
            HStack(alignment: .center) {
                //Spacer()
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 100, alignment: .center)
              
              //  Spacer()

                
            }
            
        }
        .frame(width: self.wdith, height: 120)
        .background((Color("themecolor")))
        
        //.background(HeaderViewBackground(x: $x))
    }
}


// TODO: - 动画背景，需处理...
struct HeaderViewBackground: View {
    
    @State var isAnimate: Bool  = false
    
    @Binding var x: CGFloat
    
    
    var body: some View {
        
        ZStack {
            Image("sidebar_bg")
                .resizable()
//                    .aspectRatio(contentMode: .fill)   // 保证图片比例不变 -> 放大， fit： 拉伸，不放大。
//                    .frame(width: UIScreen.main.bounds.width - 80, height: isAnimate ? 600 : 200)
                .frame(height: 900)
                .offset(x: x, y: isAnimate ? 300 : 0)
                .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true))
            
        }
        
        .onAppear() {
            self.isAnimate.toggle()
        }
    }
}
