//
//  DairyList.swift
//  MapzApp
//
//  Created by Misha Infotech on 30/08/2021.
//

import SwiftUI

struct DairyList: View {
    @ObservedObject var obs = ActivityObserver()
    @Environment(\.presentationMode) var presentationMode
    @State var heightplus : CGFloat = 35
    
    var body: some View {
        ZStack{
            VStack(spacing: 10.0) {
                Spacer()
                    .frame(height :heightplus)
                HStack{
                    VStack(alignment: .leading, spacing : 12.0) {
                        // Spacer(minLength: 12)
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            //                    withAnimation {
                            //                        x = 0
                            //                    }
                        }) {
                            Image("back")
                                .resizable()
                                .frame(width: 24.0, height: 24.0)
                            //    .padding(.top,12.0)
                            
                            //.cornerRadius(24)
                        }
                        Text("Activity log")
                            .foregroundColor(Color.black)
                            .font(.custom("Inter-Bold", size: 18))
                        
                    }
                    
                    Spacer()
                    
                } .padding(.horizontal,
                           10.0)
                
                HStack{
                    
                }
                .frame(width: UIScreen.main.bounds.width-30, height: 1.0)
                .border(Color.black, width: 1)
                .padding(.bottom, 3.0)
                
                
                if (obs.showview)
                    
                {
                    ScrollView{
                        ForEach(obs.Activitylist, id: \.self) { pokemon in
                            // List{
                            VStack{
                                HStack(alignment: .center, spacing: 10.0){
                                    //                        Image("icons8-male-user-72")
                                    //                            .frame(width: 60.0, height: 60.0)
                                    //                            .cornerRadius(30)
                                    VStack(alignment: .leading, spacing: 5.0){
                                        
                                        Text(pokemon.activity)
                                            .font(.custom("Inter-Bold", size: 15))
                                        
                                            .padding(.horizontal,10.0)
                                           
                                        
                                        Text(pokemon.date)
                                            .font(.custom("Inter-Regular", size: 13))
                                            .padding(.horizontal,10.0)
                                            .foregroundColor(Color.gray)
                                        
                                        // Divider()
                                        // .foregroundColor(Color("bluecolor"))
                                        
                                    }
                                    Spacer()
                                    //                        Image("2")
                                    //                            .padding(.trailing, 10.0)
                                    //                            .frame(width: 60.0, height: 60.0)
                                    //                            .cornerRadius(10)
                                    
                                }
                                
                
                                
                                    .padding(.horizontal, 10.0)
                                    .background(Color.white)
                                // .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                            }
                            Spacer()
                            //.shadow(color: .gray, radius: 5, x: 1, y: 1)
                        }
                        
                    }
                }
                
                else{
                    
                    
                    blankView(imageNAme: "no_found_activity",ErrorMsg : "Activity not Found")
                        .offset(y : UIScreen.main.bounds.height/2-120)
                    Spacer()
                    
                }
                Spacer()
            }.edgesIgnoringSafeArea(.all)
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

struct DairyList_Previews: PreviewProvider {
    static var previews: some View {
        DairyList()
    }
}
struct ActivityModal :Hashable {
    
    var  activity : String
    var    date : String
    
    init(_ activity:String,_ date:String){
       self.activity  = activity
       self.date = date
      
      
    }
    
}
class ActivityObserver: ObservableObject {
    
    @Published   var Activitylist = [ActivityModal]()
    
    @Published   var showview = false
    
    init() {
        
        let str = UserDefaults.standard.string(forKey: "id") ?? ""
        let str1  = "Accounts/ActivityLog/?id="+str
        AccountAPI.getsignin(servciename: str1, nil) { res in
            switch res {
            case .success:
                print("resulllll",res)
                
                if let json = res.value{
                    self.Activitylist = []
                    print("Josn",json)
                    
                    
                    let events = json["data"]
                    for i in events {
                        
                        
                        let  acc  = ActivityModal(i.1["activity"].stringValue,i.1["date"].stringValue)
                        self.Activitylist.append(acc)
                    }
                    print(self.Activitylist)
                    if  (self.Activitylist.count > 0){
                        self.showview.toggle()
                        
                    }
                }
                
                
            case let .failure(error):
                print(error)
            }
        }
    }
}
