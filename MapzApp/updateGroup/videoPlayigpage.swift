//
//  videoPlayigpage.swift
//  MapzApp
//
//  Created by Admin on 05/01/23.
//

import SwiftUI
import AVKit // 1

struct videoPlayigpage: View {
    var imgstr = String()

    @State var player = AVPlayer()
   //        var videoUrl: String = "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4"
    @State var heightplus : CGFloat = 35
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
//            Spacer()
//                  .frame(height :heightplus)
            VStack(spacing : 0.0){
                HStack() {
                    Button(action: {
                       presentationMode.wrappedValue.dismiss()
                    }) {
                       Image("icons8-back-24")
                          .resizable()
                            
                            .aspectRatio(contentMode: .fit)
                      
                     
                           
                    }.frame(width : 32 , height: 32)
                    
                   
                    Spacer()
                      Text("Video Detail")
                          .foregroundColor(Color.white)
                     Spacer()
              
                    Image("")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width : 32 , height: 32)
                  
                
                }.padding(.horizontal , 10)
                .frame(width: UIScreen.main.bounds.width , height: 50.0)
                .background(Color("themecolor"))
                
                
                
                VideoPlayer(player: player)
                    .onAppear() {
                        player = AVPlayer(url: URL(string: imgstr)!)
                    }
                
            }
        }.onAppear(){
            if UIDevice.current.hasNotch {
                heightplus = 35
            } else {
                //... don't have to consider notch
                heightplus = 20
            }
        }
        
    }
}

struct videoPlayigpage_Previews: PreviewProvider {
    static var previews: some View {
        videoPlayigpage()
    }
}
