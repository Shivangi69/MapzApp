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
                                  .frame(width: 60, height: 70.0)
                                   .aspectRatio(contentMode: .fit)
                            },
                            image: { 
                                Image(uiImage: $0).resizable()
                                
                            }
                        )
                        .frame(width: 60, height: 70.0)
                        .aspectRatio(contentMode: .fit)
                  
                    VStack(alignment: .leading, spacing : 5.0) {
                        Text(feedList.createdByName)
                            .font(.custom("Inter-Bold", size: 14))
                        
                        Text(feedList.diaryName + " " + formatDate(feedList.createdAt))
                            .font(.custom("Inter-Regular", size: 14))
                        
                        Text(feedList.address)
                            .font(.custom("Inter-Regular", size: 14))
                            .lineLimit(2)
                        
                    }
                    
                    Spacer()
                    
                }
                    .background(Color("lightgray"))
            }
            .frame(width: UIScreen.main.bounds.width-30)
        }
        
    }
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        
        // Set the date format of the incoming string (yyyy-MM-dd format)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            // Set the desired output format (dd/MM/yyyy)
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        } else {
            return dateString // Return the original string if formatting fails
        }
    }
}

//struct FeedViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedViewCell()
//    }
//}
