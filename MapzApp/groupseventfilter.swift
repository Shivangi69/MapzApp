//
//  groupseventfilter.swift
//  MapzApp
//
//  Created by Admin on 05/01/23.
//

import SwiftUI

struct groupseventfilter: View {
    @State var showDatePicker: Bool = false
    @State var savedDate: Date? = nil
    @State var savedDatestr : String? = nil
    @State var savedDatestrer : String? = nil

    
    @State var showDatePicker2: Bool = false
    @State var savedDate2: Date? = nil
    @State var savedDatestr2 : String? = nil
    @State var savedDatestrsee2 : String? = nil

    @State var heightplus : CGFloat = 35

    @Environment(\.presentationMode) var presentationMode
    @State private var isToggle : Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    VStack(spacing: 10){
                    VStack{
                        
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
                                
                                Text("Filter")
                                    .foregroundColor(Color.black)
                                    .font(.custom("Inter-Bold", size: 20))
                                
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 10.0)
                        
                        
                    }
                    // Spacer (minLength: 2)
                    HStack{
                        
                    }
                    .frame(width: UIScreen.main.bounds.width-20, height: 1.0)
                    .border(Color.black, width: 1)
                    .padding(.bottom,
                             12.0)
                    
                }
                    
                    VStack(alignment: .leading, spacing : 12.0 ){
                        Text("From")
                        // .fontWeight(.bold)
                        
                        HStack(spacing: 20.00){
                            
                            Text(savedDatestrer ?? "Please select from date")
                                .foregroundColor(savedDatestr2 == "Please select from date" ? Color.gray : Color.black)
                            Spacer()
                            
                        }
                        .padding(.horizontal, 12.0)
                        
                        .frame(width: UIScreen.main.bounds.width-30, height: 50.0)
                        //  .background(Color ("EmailColorBackGround"))
//                        .border(Color .black, width: 1)
//                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: (5.0)).stroke(lineWidth: 1)
                            .foregroundColor(Color.black))
                        .onTapGesture {
                            showDatePicker.toggle()
                        }
                        Text("To")
                        // .fontWeight(.bold)
                        
                        HStack(spacing: 20.00){
                            
                            Text(savedDatestrsee2 ?? "Please select to date")
                                .foregroundColor(savedDatestrsee2 == "Please select to date" ? Color.gray : Color.black)
                            Spacer()
                            
                        }
                        .padding(.horizontal, 12.0)
                        
                        .frame(width: UIScreen.main.bounds.width-30, height: 50.0)
                        //  .background(Color ("EmailColorBackGround"))
                        .overlay(RoundedRectangle(cornerRadius: (5.0)).stroke(lineWidth: 1)
                            .foregroundColor(Color.black))
                        .onTapGesture {
                            showDatePicker2.toggle()
                        }
                        
                    }
                    HStack {
                        Toggle(isOn: $isToggle){
                            
                            Text("Map")
                            
                        }
                        Spacer()
                    }.padding()
                    Spacer()
                    HStack{
                        Button(action: {
                            //   showdetailpage.toggle()
                            
                            
                            
                            UserDefaults.standard.set(savedDatestr, forKey: "Gstartdate")
                            UserDefaults.standard.set(savedDatestr2, forKey: "GEndDate")

                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filterG"), object: self)

                            presentationMode.wrappedValue.dismiss()
                        })
                        {
                            Text("Apply")
                            
                                .foregroundColor(.white)
                                .font(.custom("Inter-Medium", size: 20))
                                .frame(width:
                                        UIScreen.main.bounds.width-30, height: 50.0)
                            
                                .background(Color ("themecolor-1"))
                                .cornerRadius(25)
                        }
                    }
                    Spacer().frame(height : heightplus + 5)
                   
                    
                }.edgesIgnoringSafeArea(.all)
                    .onAppear(){//"duration"
                       
                        if UIDevice.current.hasNotch {
                            heightplus = 35
                        } else {
                            //... don't have to consider notch
                            heightplus = 20
                        }
                    
                    }
                
                if showDatePicker {
                    DatePickerWithButtons6(showDatePicker: $showDatePicker, savedDate: $savedDate, selectedDate: savedDate ?? Date(), savedDatestr: $savedDatestr, savedDatestrer: $savedDatestrer)
                        .animation(.linear)
                        .transition(.opacity)
                }
                
                if showDatePicker2 {
                    DatePickerWithButtons7(showDatePicker2: $showDatePicker2, savedDate2: $savedDate2, selectedDate2: savedDate2 ?? Date(), savedDatestr2: $savedDatestr2, savedDatestrsee2: $savedDatestrsee2)
                        .animation(.linear)
                        .transition(.opacity)
                }
                
            }.navigationBarHidden(true)
           // Spacer()

        } .navigationBarHidden(true)
       // .edgesIgnoringSafeArea(.all)
        
    }
}

struct groupseventfilter_Previews: PreviewProvider {
    static var previews: some View {
        groupseventfilter()
    }
}


struct DatePickerWithButtons6: View {
    
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    @Binding var savedDatestr: String?
    
    @Binding var savedDatestrer: String?

    var body: some View {
        ZStack {
            
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 20.0) {
                DatePicker("Test", selection: $selectedDate, displayedComponents: [.date])
                    
                    .datePickerStyle(GraphicalDatePickerStyle())
                    //
                    .colorScheme(.dark) // or .light to get black text
                    //
                    
                   
                Divider()
                HStack {
                    Spacer()
                   
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    })
                    .frame(width: 110, height: 50)
                    .background(Color("blackcolor"))
                    .cornerRadius(10)
                    
                    Button(action: {
                        
                       
                        
                        
                        let formatter1 = DateFormatter()
                        formatter1.dateFormat = "dd-MM-yyyy"
                        let strt = formatter1.string(from: selectedDate)
                        savedDatestrer = strt
                        
                        
                        
                        let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"

                           let str = formatter.string(from: selectedDate)
                        
                        savedDatestr = str
                        savedDate = selectedDate
                        showDatePicker = false
                    }, label: {
                        Text("Set Date")
                            .foregroundColor(.white)

                            
                    }
                    )
                    .frame(width: 110, height: 50)
                    .background(Color("redColor"))
                    .cornerRadius(10)
                    
                    
                }
                .padding(.horizontal)

            }
            .padding()
            .background(
                Color.black
                    .cornerRadius(30)
            )

            
        }

    }
}





struct DatePickerWithButtons7: View {
    
    @Binding var showDatePicker2: Bool
    @Binding var savedDate2: Date?
    @State var selectedDate2: Date = Date()
    @Binding var savedDatestr2: String?
    @Binding var savedDatestrsee2: String?
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 20.0) {
                DatePicker("Test", selection: $selectedDate2, displayedComponents: [.date])
                
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .colorScheme(.dark) // or .light to get black text
                
                
                Divider()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showDatePicker2 = false
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    })
                    .frame(width: 110, height: 50)
                    .background(Color("blackcolor"))
                    .cornerRadius(10)
                    
                    Button(action: {
                        
                        let formatter1 = DateFormatter()
                        formatter1.dateFormat = "dd-MM-yyyy"
                        let strt = formatter1.string(from: selectedDate2)
                        savedDatestrsee2 = strt
                        
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let str = formatter.string(from: selectedDate2)
                        savedDatestr2 = str
                        
                        savedDate2 = selectedDate2
                        showDatePicker2 = false
                    }, label: {
                        Text("Set Date")
                            .foregroundColor(.white)
                    }
                    )
                    .frame(width: 110, height: 50)
                    .background(Color("redColor"))
                    .cornerRadius(10)
                    
                }
                .padding(.horizontal)
                
            }
            .padding()
            .background(
                Color.black
                    .cornerRadius(30)
            )
        }
    }
}
