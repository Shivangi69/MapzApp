//
//  ImageViewer.swift
//  MapzApp
//
//  Created by Misha Infotech on 28/09/2021.
//

import SwiftUI

struct ImageViewer: View {
    @Environment(\.presentationMode) var presentationMode
    
    var imgstr = String()
    var body: some View {
        // Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        ZStack{
            
            VStack(spacing: 0.0) {
                HStack() {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("icons8-back-24")
                            .resizable()
                        
                            .aspectRatio(contentMode: .fit)
                        
                    }.frame(width : 32 , height: 32)
                    
                    Spacer()
                    Text("Gallery Detail")
                        .foregroundColor(Color.white)
                    Spacer()
                    
                    Image("")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width : 32 , height: 32)
                    
                }.padding(.horizontal , 10)
                    .frame(width: UIScreen.main.bounds.width , height: 50.0)
                    .background(Color("themecolor"))
                
                AsyncImage(
                    url: NSURL(string: imgstr)! as URL ,
                    placeholder: { Image("istockphoto-1055686622-612x612").foregroundColor(colorGrey1)
                            .aspectRatio(contentMode: .fit)
                    },
                    image: { Image(uiImage: $0).resizable()
                        
                    }
                )
                .padding(.all, 0.0)
                .aspectRatio(contentMode: .fill)
            }
        }
    }
}

struct ImageViewer_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewer()
    }
}
