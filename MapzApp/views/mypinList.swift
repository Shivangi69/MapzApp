//
//  mypinList.swift
//  MapzApp
//
//  Created by Misha Infotech on 30/08/2021.
//

import SwiftUI
import CoreLocation
import GoogleMaps
import GooglePlaces

struct mypinList: View {
    
    @ObservedObject var obs = pinListObserver()
    @Environment(\.presentationMode) var presentationMode
    @State var showupdateview = false

    var body: some View {
        ZStack{
            VStack(spacing: 20.0) {
             
             HStack(spacing: 20.0) {
                 Button(action: {
                    presentationMode.wrappedValue.dismiss()
                 }) {
                    Image("menu")
                         .resizable()
                         
                         .aspectRatio(contentMode: .fit)
                   
                     
                 }
                 
                Spacer()
                 
                Text("My Pin List")
                    .foregroundColor(Color.white)
                    .font(.custom("Inter-Bold", size: 22))
                Spacer()
                Image("")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
             }
             .padding()
             .padding(.top,10)
             .frame(height: 50.0)
             .background(Color("themecolor"))
             
                if (obs.showlist){
                   
                    List(obs.eventlist, id: \.self) { pokemon in
               // List{
                    HStack(alignment: .center, spacing: 5){
                        Image("location-1")
                            .resizable()
                           
                            .frame(width: 40, height: 40)
                            .aspectRatio(contentMode: .fit)
                        VStack(alignment: .leading, spacing: 0.0){
                           
                            Text(pokemon.Addrs)                    .font(.custom("Inter-Regular", size: 16)).frame(height: 30.0)

                            Text(pokemon.diaryName)
                                    .font(.custom("Inter-Bold", size: 17))
                                .foregroundColor(Color("themecolor"))
                                .frame(height: 30.0)

                        }
                        Spacer()
//                        Image("2")
//                            .padding(.trailing, 10.0)
//                            .frame(width: 60.0, height: 60.0)
//                            .cornerRadius(10)
                        AsyncImage(
                            url: NSURL(string: pokemon.thumbnail)! as URL,
                            placeholder: { Image("Loading..") },
                                        image: { Image(uiImage: $0).resizable()
                                             }
                        )
                
                        //.padding(.trailing, 10.0)
                        .frame(width: 40, height: 40)
                        .cornerRadius(10)
                        
                    }
                    .padding(.horizontal, 3.0)
                    .frame(height: 60.0)

                    //.padding(.vertical, 4.0)
                    .background(Color.white)
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        UserDefaults.standard.set("Edit", forKey: "eventNOE")
                        UserDefaults.standard.set(pokemon.eventId, forKey: "eventID")
                        showupdateview = true
                    }
                    .fullScreenCover(isPresented: $showupdateview, content: UpdatepartyDetails.init)

                    //.shadow(color: .gray, radius: 5, x: 1, y: 1)
                
                }
                
                }else{
                    
                    
                    blankView(imageNAme: "no_found_location",ErrorMsg : "Pin list not Found")
                        .offset(y : UIScreen.main.bounds.height/2-120)

                    Spacer()
        }
        Spacer()
            }
    
        }

    }
}

struct mypinList_Previews: PreviewProvider {
    static var previews: some View {
        mypinList()
    }
}
class pinListObserver: ObservableObject {
   
    @Published   var eventlist = [pineventmodalclassss]()
    
    @Published   var showlist = false
    @Published   var addrsStr = String()

    init() {
        
        let str = UserDefaults.standard.string(forKey: "id") ?? ""
        let str1  = "EventDiary/GetMyDiariesPinList/?id="+str
        AccountAPI.getsignin(servciename: str1, nil) { res in
        switch res {
        case .success:
            print("resulllll",res)
            
            if let json = res.value{
                self.eventlist = []
                print("Josn",json)
      //  let userdic = json["data"]
                
                let events = json["data"]
                for i in events {

                    let str = (i.1["address"].stringValue)
                    if (str == ""){
                    let lat: Double = Double("\(i.1["latitude"].stringValue)")!
                    //21.228124
                    let lon: Double = Double("\(i.1["longitude"].stringValue)")!
                   
                  

                    let geocoder = GMSGeocoder()
                    let coordinate = CLLocationCoordinate2DMake(lat,lon)
                    
                    var currentAddress = String()
                    
                    geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
                        if let address = response?.firstResult() {
                            let lines1 = address.lines! as [String]
                            
                            print("Response is = \(address)")
                            print("Response line is = \(lines1)")
                            
                            currentAddress = lines1.joined(separator: "\n")
                          
                            let scc = pineventmodalclassss(i.1["eventId"].stringValue, i.1["userId"].stringValue, i.1["longitude"].stringValue, i.1["latitude"].stringValue, i.1["diaryName"].stringValue, i.1["diaryDescription"].stringValue, i.1["date"].stringValue,i.1["thumbnail"].stringValue, currentAddress)
                        self.eventlist.append(scc)
                    }
                        else{
                            let scc = pineventmodalclassss(i.1["eventId"].stringValue, i.1["userId"].stringValue, i.1["longitude"].stringValue, i.1["latitude"].stringValue, i.1["diaryName"].stringValue, i.1["diaryDescription"].stringValue, i.1["date"].stringValue,i.1["thumbnail"].stringValue, "")
                        self.eventlist.append(scc)
                        }
                    
                    
                    }
                    
                  
                    }else{
                        let scc = pineventmodalclassss(i.1["eventId"].stringValue, i.1["userId"].stringValue, i.1["longitude"].stringValue, i.1["latitude"].stringValue, i.1["diaryName"].stringValue, i.1["diaryDescription"].stringValue, i.1["date"].stringValue,i.1["thumbnail"].stringValue, str)
                    self.eventlist.append(scc)
                    }
                   
                   
                }
                if  (self.eventlist.count > 0){
                    self.showlist.toggle()
                    
                }
                }
                print(self.eventlist)
        case let .failure(error):
          print(error)
        }
      }
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(pdblLatitude)")!
            //21.228124
            let lon: Double = Double("\(pdblLongitude)")!
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }

                        self.addrsStr = addressString
                        print(addressString)
                  }
            })

        }
    
    
}
