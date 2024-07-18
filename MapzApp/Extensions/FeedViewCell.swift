//
//  FeedViewCell.swift
//  MapzApp
//
//  Created by Misha Infotech on 14/12/2022.
//

import SwiftUI

struct FeedViewCell: View {
    var feedList : FeedViewModel
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing : 5.0) {
                HStack(spacing : 6.0){
                    
                        AsyncImage(
                            
                            url: NSURL(string: feedList.fileName)! as URL,
                            placeholder: {  Image(feedList.fileName)
                                    .frame(width: 50.0, height: 60.0)
                                    .aspectRatio(contentMode: .fit)
                                
                            },
                            image: { 
                                Image(uiImage: $0).resizable()
                                
                            }
                        )
                        .frame(width: 80.0, height: 80.0)
                        .aspectRatio(contentMode: .fill)
                    
                   // .frame(width: 80.0, height:80.0)
                       // .cornerRadius(50.0)
                        
//           .resizable()
//           .frame(width: 100, height: 100)
                    
                    VStack(alignment: .leading, spacing : 5.0) {
                        Text(feedList.createdByName)
                            .font(.custom("Inter-Bold", size: 14))
                        
                        Text(feedList.diaryName + " " + feedList.createdAt)
                            .font(.custom("Inter-Regular", size: 14))
                        
                        Text(feedList.address)
                            .font(.custom("Inter-Regular", size: 14))
                            .lineLimit(2)
                        
                    }
                    
                    Spacer()
                    
                }
                    .background(Color("lightgray"))
               /// Spacer()
            }
            .frame(width: UIScreen.main.bounds.width-30)
        }
    }
}

//struct FeedViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedViewCell()
//    }
//}
