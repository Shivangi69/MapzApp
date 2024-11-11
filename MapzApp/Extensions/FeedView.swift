//
//  FeedView.swift
//  MapzApp
//
//  Created by Misha Infotech on 14/12/2022.
//

import SwiftUI

struct FeedView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var heightplus : CGFloat = 35
    @ObservedObject var obs = feedlistObservable()
    @State var searchText =  String()
    @State private var showCancelButton: Bool = false
    
    
    var onCommit: () ->Void = {
        print("onCommit")
        
    }
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Spacer()
                    .frame(height :heightplus)
                
                HStack(spacing : 10.0) {
                    Text("Yourfeed")
                        .foregroundColor(Color.black)
                        .font(.custom("Inter-Bold", size: 18
                                     ))
                    
                    Spacer()
                    
//                    HStack {
//                        Image(systemName: "magnifyingglass")
//                        
//                        // Search text field
//                        ZStack (alignment: .leading) {
//                            if searchText.isEmpty { // Separate text for placeholder to give it the proper color
//                                Text("")
//                            }
//                            TextField("", text: $searchText, onEditingChanged: { isEditing in
//                                self.showCancelButton = true
//                            }, onCommit: onCommit).foregroundColor(.primary)
//                        }
//                     
//                        // Clear button
//                        Button(action: {
//                            self.searchText = ""
//                        }) {
//                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
//                        }
//                        
//                        
//                    }
//                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
//                    .foregroundColor(.secondary) // For magnifying glass and placeholder test
//                    .background(Color(.white))
//                    .overlay(RoundedRectangle(cornerRadius: (16)).stroke(lineWidth: 1.0))
//                    
                    
                    
                              HStack {
                                  Image(systemName: "magnifyingglass")
                                  
                                  // Search text field
                                  ZStack(alignment: .leading) {
                                      if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                                          Text("")
                                      }
                                      TextField("", text: $searchText)
                                          .onChange(of: searchText) { _ in
                                              self.showCancelButton = true
                                          }
                                          .foregroundColor(.primary)
                                  }
                                  
                                  // Clear button
                                  Button(action: {
                                      self.searchText = ""
                                  }) {
                                      Image(systemName: "xmark.circle.fill")
                                          .opacity(searchText == "" ? 0 : 1)
                                  }
                              }
                              .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                              .foregroundColor(.secondary) // For magnifying glass and placeholder text
                              .background(Color(.white))
                              .overlay(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1.0))
                         
                    
                    
                }.frame(width: UIScreen.main.bounds.width-30)
                
                HStack{
                    
                }
                .frame(width: UIScreen.main.bounds.width-30, height: 1.0)
                .border(Color.black, width: 1)
                .padding(.bottom, 3.0)
            
                
                
                //   if obs.showview{
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        ForEach(obs.feedList, id: \.self) { pokemon in
                            FeedViewCell(feedList : pokemon)
                            
                        }
                    }
                }
                
                
                //  }
            }
            .frame(width: UIScreen.main.bounds.width)


            .onAppear(){
                
                if UIDevice.current.hasNotch {
                    heightplus = 35
                } else {
                    //... don't have to consider notch
                    heightplus = 20
                }
            }
            
        }
               .edgesIgnoringSafeArea(.all)


    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

class feedlistObservable: ObservableObject {
    
    @Published   var feedList = [FeedViewModel]()
    @Published   var showlist = false
    @Published   var addrsStr = String()
    
    init() {
        
        let str = UserDefaults.standard.string(forKey: "id") ?? ""
        let str1  = "EventDiary/EventsPostedBy_Friends?id="+str
        AccountAPI.getsignin(servciename: str1, nil) { res in
            switch res {
            case .success:
                print("resulllll",res)
                
                if let json = res.value{
                    self.feedList = []
                    print("Josn",json)
                    //  let userdic = json["data"]
                    
                    let events = json["data"]
                    for i in events {
                        
                        
                        let scc = FeedViewModel(i.1["eventId"].intValue,  i.1["diaryName"].stringValue, i.1["diaryDescription"].stringValue, i.1["address"].stringValue,i.1["read"].intValue,i.1["createdAt"].stringValue,i.1["fileType"].stringValue,i.1["fileName"].stringValue,i.1["createdById"].intValue,i.1["createdByName"].stringValue)
                        
                        
                        self.feedList.append(scc)
                        
                    }
                    
                }
                print(self.feedList)
            case let .failure(error):
                print(error)
            }
        }
    }
}

struct FeedViewModel:Hashable {
    var eventID: Int
    var diaryName, diaryDescription, address: String
    var read: Int
    var createdAt: String
    var  fileType: String
    var fileName: String
    var createdByID: Int
    var createdByName: String
    
    init(_ eventID:Int,_ diaryName:String,_ diaryDescription:String,_ address:String,_ read:Int,_ createdAt:String,_ fileType:String ,_ fileName:String,_ createdByID:Int,_ createdByName:String){
        self.eventID = eventID
        self.diaryName = diaryName
        self.diaryDescription = diaryDescription
        self.address = address
        self.read = read
        self.createdAt = createdAt
        self.fileType = fileType
        self.fileName = fileName
        self.createdByID = createdByID
        self.createdByName = createdByName
        
        
    }
    
}
