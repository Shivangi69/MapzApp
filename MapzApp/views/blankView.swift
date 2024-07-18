//
//  blankView.swift
//  MapzApp
//
//  Created by Misha Infotech on 07/10/2021.
//

import SwiftUI

struct blankView: View {
    
    var imageNAme = String()
    var ErrorMsg = String()

    var body: some View {
        ZStack{
            VStack{
        Image(imageNAme)
           .resizable()
           .frame(width: 90, height:90)
           .aspectRatio(contentMode: .fit)
           
            Text(ErrorMsg)
            
            }
        }
    }
}

struct blankView_Previews: PreviewProvider {
    static var previews: some View {
        blankView(imageNAme: "", ErrorMsg: "")
    }
}
