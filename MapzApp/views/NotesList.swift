//
//  NotesList.swift
//  MapzApp
//
//  Created by Misha Infotech on 27/08/2021.
//

import SwiftUI

struct NotesList: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
        HStack(spacing: 20.0) {
            Button(action: {
               
            }) {
               Image("icons8-back-24")
                    .resizable()
                    
                    .aspectRatio(contentMode: .fit)
               Text("Back")
                   .foregroundColor(Color.white)
                .font(.custom("Inter-Bold", size: 17))

            }
            
            
            Spacer()
            
            Text("Add to Event Diary")
                .foregroundColor(Color.white)
                .font(.custom("Inter-Bold", size: 20))

            Button(action: {
               
            }) {
               Image("icons8-plus-+-24 (1)")
                    .resizable()
                    
                    .aspectRatio(contentMode: .fit)
              
               
            }
        
        }
        .padding()
        //.padding(.top,10)
        .frame(height: 60.0)
        .background(Color("themecolor"))
        
        ScrollView{
            
            //   List{
                      ForEach(0..<Databoarding.count){_ in
                      HStack(alignment: .center, spacing: 10.0){
                          Image("icons8-sticky-notes-24")
                              .resizable()
                              
                              .aspectRatio(contentMode: .fill)
                              .frame(width: 60.0, height: 60.0)
                          
                             
                              Text("NoLorem Ipsum is simplytext of the printing and type setting industry. Lorem Ipsum....")
                                  .font(.custom("Inter-Bold", size: 22))
                                  .foregroundColor(Color("themecolor"))

                          //Spacer()
                          Button(action: {
                             
                          }) {
                             Image("icons8-macos-close-24 (1)")
                                  .resizable()
                                  
                                  .aspectRatio(contentMode: .fit)
                             
                              
                          } .frame(width: 40.0, height: 40.0)
                                 
                        
                         
                      }
                      .padding(.horizontal, 10.0)
                      
                      //.padding(.vertical, 4.0)
                      .background(Color.white)
                      .cornerRadius(15.0)

                      //.shadow(color: .gray, radius: 5, x: 1, y: 1)
                      }
                      .padding(.top, 10.0)
                  
                  
        }
        }
        
    }
}

struct NotesList_Previews: PreviewProvider {
    static var previews: some View {
        NotesList()
    }
}
