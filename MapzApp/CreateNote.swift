//
//  CreateNote.swift
//  MapzApp
//
//  Created by Misha Infotech on 16/08/2021.
//

import SwiftUI

struct CreateNote: View {
    var body: some View {
        ZStack{
            VStack(spacing: 0.0) {
                
                HStack(spacing: 20.0) {
                    Button(action: {
                        withAnimation {
                            x = 0
                        }
                    }) {
                        Image("")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("lightBlue"))
                    }
                    
                   
                    
                   Spacer()
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 200, height: 40)
                        .aspectRatio(contentMode: .fit)
    //                Button(action: {
    //                    print("test1")
    //                }, label: {
                    Spacer()
                    Image("")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .aspectRatio(contentMode: .fit)
                }
                .padding()
                .padding(.top, 20)
                .background(LinearGradient(gradient: Gradient(colors: [(Color("themecolor")), (Color("themecolor"))]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
                
                
        }
    }
}

struct CreateNote_Previews: PreviewProvider {
    static var previews: some View {
        CreateNote()
    }
}
