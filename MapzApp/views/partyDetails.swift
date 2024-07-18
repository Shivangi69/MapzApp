//
//  partyDetails.swift
//  MapzApp
//
//  Created by Misha Infotech on 17/08/2021.
//

import SwiftUI
struct partyDetails: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var showCameraPopUp = false
    @State private var showVideoPopUp = false
    @State private var showrecdPopUp = false
    @State private var showdocPopUp = false
    @State private var Note = String()
    var body: some View {
        ZStack{
            VStack(spacing: 0.0) {
             
             HStack(spacing: 20.0) {
                 Button(action: {
                    presentationMode.wrappedValue.dismiss()
                 }) {
                    Image("icons8-back-24")
                         .resizable()
                         
                         .aspectRatio(contentMode: .fit)
                    Text("Back")
                        .foregroundColor(Color.white)
                     
                 }
                 
            Spacer()
                 
             }
             .padding()
             .padding(.top,10)
             .frame(height: 50.0)
             .background(Color("themecolor"))
                VStack{
                  //  GoogleMApView()

                }
                .frame(height: 300.0)
                    HStack{
                        Image("mappin")
                            .padding(.leading, 20.0)
                            .frame(width: 32.0, height: 32.0)
                        Text("Down Town California...")
                        .font(.custom("Inter-Bold", size: 17))
                    .foregroundColor(Color("darkyellow"))
                        Spacer()
                        
                    }.frame(height: 40.0)
                    //.background(Color("themecolor"))
                    .background(RoundedCorners(color: Color("themecolor"), tl: 0, tr: 0, bl: 15, br: 15))

                    
             
               
                VStack(spacing: 20.0){
                    HStack{
                        Spacer()

                        Text("Birthday Party")
                                .font(.custom("Inter-Bold", size: 25))
                            .foregroundColor(Color("themecolor"))
                        Spacer()
                        Text("Friday 9 July,2021")
                                .font(.custom("Inter-Bold", size: 17))
                            .foregroundColor(Color("themecolor 1"))
                        Spacer()

                    }
                    
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type book.")
                            .font(.custom("Inter-Regular", size: 17))
                    
                    
                    HStack{
                        Spacer()
                     Image("add_rec")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                          
                                showVideoPopUp = false
                                showrecdPopUp = false
                                showdocPopUp = false
                                showCameraPopUp = true
                            }
                        VStack{
                            Text("ADD NEW")
                                .font(.custom("Inter-Bold", size: 15))
                            
                            Text("PHOTOS")
                                .font(.custom("Inter-Bold", size: 21))
                            
                        }
                        .onTapGesture {
                          
                                showVideoPopUp = false
                                showrecdPopUp = false
                                showdocPopUp = false
                                showCameraPopUp = true
                            }
                        Spacer()
                        Image("add_rec")
                            
                           .resizable()
                           .frame(width: 70, height: 70)
                           .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                              
                                showCameraPopUp = false
                            //       showVideoPopUp = false
                                   showrecdPopUp = false
                                   showdocPopUp = false
                                self.showVideoPopUp = true
                                }
                           VStack{
                               Text("ADD NEW")
                                   .font(.custom("Inter-Bold", size: 15))
                               
                               Text("VIDEOS")
                                   .font(.custom("Inter-Bold", size: 21))
                               
                           }
                           .onTapGesture {
                             
                            showCameraPopUp = false
                        //       showVideoPopUp = false
                               showrecdPopUp = false
                               showdocPopUp = false
                            self.showVideoPopUp = true
                               }
                        Spacer()

                    }
                 
                    HStack{
                        Spacer()
                     Image("add_rec")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                          
                            showCameraPopUp = false
                               showVideoPopUp = false
                         //      showrecdPopUp = false
                               showdocPopUp = false
                        showrecdPopUp = true
                            }
                        VStack{
                            Text("ADD NEW")
                                .font(.custom("Inter-Bold", size: 15))
                            
                            Text("VOICES")
                                .font(.custom("Inter-Bold", size: 21))
                            
                        } .onTapGesture {
                            showCameraPopUp = false
                               showVideoPopUp = false
                         //      showrecdPopUp = false
                               showdocPopUp = false
                        showrecdPopUp = true
                        }
                        Spacer()
                        Image("add_rec")
                           .resizable()
                           .frame(width: 70, height: 70)
                           .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                              
                                showCameraPopUp = false
                                   showVideoPopUp = false
                                   showrecdPopUp = false
                            showdocPopUp = true
                                }
                           VStack{
                               Text("ADD NEW")
                                   .font(.custom("Inter-Bold", size: 15))
                               
                               Text("NOTE")
                                   .font(.custom("Inter-Bold", size: 21))
                               
                           }
                           .onTapGesture {
                             
                            showCameraPopUp = false
                               showVideoPopUp = false
                               showrecdPopUp = false
                        showdocPopUp = true
                               }
                        Spacer()

                    }
                }
                .padding(.horizontal, 10.0)
                .padding([.top], 20.0)
               
        Spacer()
                
            }
            
            
            if $showCameraPopUp.wrappedValue {
                ZStack {
                   //
                    Color.white
                    VStack(alignment: .center, spacing: 20.0) {
                        Spacer()
                        Text("Add New Photos")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("themecolor"))
                        Spacer()
                        Button(action: {
                            //
                            self.showCameraPopUp = false
                        }, label: {
                            Text("Click Using Camera")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(action: {
                             self.showCameraPopUp = false
                        }, label: {
                            Text("Choose from gallery")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Spacer()
                    }.padding()
                   

                }
                .frame(width: UIScreen.main.bounds.width-60, height: 260)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
            
            
            
            if $showVideoPopUp.wrappedValue {
                ZStack {
                   //
                    Color.white
                    VStack(alignment: .center, spacing: 20.0) {
                        Spacer()
                        Text("Add New Videos")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("themecolor"))
                        Spacer()
                        Button(action: {
                            //
                            self.showVideoPopUp = false
                        }, label: {
                            Text("Click Using Camera")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(action: {
                             self.showVideoPopUp = false
                        }, label: {
                            Text("Choose from gallery")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Spacer()
                    }.padding()
                   

                }
                .frame(width: UIScreen.main.bounds.width-60, height: 260)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
            
            
            if $showrecdPopUp.wrappedValue {
                ZStack {
                   //
                    Color.white
                    VStack(alignment: .center, spacing: 20.0) {
                        Spacer()
                        Text("Add New Voices")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("themecolor"))
                        Spacer()
                        Button(action: {
                            //
                            self.showrecdPopUp = false
                        }, label: {
                            Text("Record  Using Mobile")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(action: {
                             self.showrecdPopUp = false
                        }, label: {
                            Text("Choose from device")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Spacer()
                    }.padding()
                   

                }
                .frame(width: UIScreen.main.bounds.width-60, height: 400)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
            
            if $showdocPopUp.wrappedValue {
                ZStack {
                   //
                    Color.white
                    VStack(alignment: .center, spacing: 20.0) {
                        Spacer()
                        Text("Add New Note")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("themecolor"))
                          
                        
                        
                        
                        TextField("Note", text: $Note)
                            .font(.custom("Inter-Regular", size: 17))
                            .frame(width: UIScreen.main.bounds.width-100, height: 200)
                            .border(Color.gray, width: 0.5)
                            //.cornerRadius(10)

//                        Button(action: {
//                            //
//                            self.showCameraPopUp = false
//                        }, label: {
//                            Text("Record  Using Mobile")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("themecolor 1")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)

                        Button(action: {
                             self.showdocPopUp = false
                        }, label: {
                            Text("Add")
                                .font(.custom("Inter-Bold", size: 18))
                        })
                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
                        .background((Color("themecolor 1")))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                       
                    }.padding()
                }
                .frame(width: UIScreen.main.bounds.width-60, height: 400)
                .cornerRadius(20)
                .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
        }
    }
}

struct partyDetails_Previews: PreviewProvider {
    static var previews: some View {
        partyDetails()
    }
}
