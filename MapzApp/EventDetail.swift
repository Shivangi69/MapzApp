//
//  EventDetail.swift
//  MapzApp
//
//  Created by Admin on 12/12/22.
//

import SwiftUI

struct EventDetail: View {
    var myId = UserDefaults.standard.string(forKey: "id") ?? ""
    @State var columns: CGFloat = 1.0
    @State var vSpacing: CGFloat = 10.0
    @State var hSpacing: CGFloat = 10.0
    @State var vPadding: CGFloat = 0.0
    @State var hPadding: CGFloat = 10.0
    @State var heightplus : CGFloat = 35
    @Environment(\.presentationMode) var presentationMode
    @State var filelist = [AllFilesModal]()
    @State var addrs = String()

    var body: some View {
        ZStack{
            VStack(spacing: 0.0) {
                Spacer()
                      .frame(height :heightplus)
             HStack(spacing: 20.0) {
                
                 Button(action: {
                     presentationMode.wrappedValue.dismiss()

                 
                 }) {
                   
                     Image("back")
                         .resizable()
                         .frame(width: 24.0, height: 24.0)

                    
                     
                 }
                // .fullScreenCover(isPresented: $showupdateview, content: MainView.init)
                 
               Spacer()
             }
            
             .frame(height: 50.0)
             .padding(.horizontal, 10.0)

                        VStack(spacing: 0.0){


                        HStack(alignment: .center, spacing: 10.0){

                            VStack{
                        AsyncImage(
                            url: NSURL(string: UserDefaults.standard.string(forKey: "profilePictureURL")!)! as URL ,
                                           placeholder: { Image("icons8-male-user-72")

                                            .resizable()
                                            .foregroundColor(colorGrey1)
                                            .aspectRatio(contentMode: .fill)
                                           },
                                                       image: { Image(uiImage: $0).resizable()

                                        }
                                       )

                        .frame(width: 60, height: 60)
                         .cornerRadius(30)
                         .aspectRatio(contentMode: .fit)


                            }
                            VStack(alignment: .leading, spacing: 5.0){
                                Text(UserDefaults.standard.string(forKey: "name") ?? "")
                                    .font(.custom("Inter-Bold", size: 15))
                                    .foregroundColor(Color.black)

                                Text(addrs)
                                    .font(.custom("Inter-Regular", size: 14))
                                .foregroundColor(Color.black)

                            }
                          Spacer()

                        }
                            HStack(spacing: 20.0) {
                            }
                            .frame(width :UIScreen.main.bounds.width-20 , height: 1.0)
                            .background(Color.black)

                        }
                        .padding(.horizontal, 10.0)
                        .frame(width: UIScreen.main.bounds.width , height: 80)
             
                Spacer()
                    .frame(height: 5.0)
                        GeometryReader { geometry in
                          ZStack {

                              VStack(spacing : 10) {


                                self.gridViewall(geometry)

                            }
                               .padding(.horizontal, 10.0)


                          }

                        }
               
                
                Spacer()
                
                Spacer()
                      .frame(height :heightplus)

            }.edgesIgnoringSafeArea(.all)
            // Spacer(minLength: 30)
                
            
            
        }.onAppear(){
            
            
            if UIDevice.current.hasNotch {
                heightplus = 35
            } else {
                //... don't have to consider notch
                heightplus = 20
            }
        }
        
    }
    private func gridViewall(_ geometry: GeometryProxy) -> some View {


        QGrid(filelist,
            columns: Int(self.columns),
            columnsInLandscape: Int(self.columns),

            vSpacing: min(self.vSpacing, 5),

            hSpacing: max(min(self.hSpacing, 5), 0.0),

            vPadding: min(self.vPadding, 0),

            hPadding: max(min(self.hPadding, 5), 0.0),
            isScrollable: true
        )
        {
            GridCellvieww(person: $0)
      }
    }
}
struct GridCellvieww: View {
   // @ObservedObject var obs = partyinfoObserver()

  var person: AllFilesModal
    @State var showPopup = false
    @State var showpicture = false
    @State var showvideoplayer = false

  var body: some View {
    ZStack{
    VStack{
        if person.fileType == "jpg" || person.fileType == "jpeg"{
            let baseURLimg11 = URL(string: person.thumbnail)
            AsyncImage(
                url: baseURLimg11!,
                placeholder: { Text("Loading..").foregroundColor(colorGrey1) },
                image: { Image(uiImage: $0).resizable()
                }
            )
            
            .frame(width: UIScreen.main.bounds.width-20, height: 300)
            .clipShape(Rectangle())
            //.padding([.top, .leading, .trailing], 10)
            .scaledToFill()
        } else if person.fileType == "Notes"{
            HStack{
                Text(person.noteText)
                    
Spacer()
            } .frame(width: UIScreen.main.bounds.width-30)
              
        }
        else if person.fileType == "mp4" || person.fileType == "3gp"{
            ZStack{
               
                let baseURLimg11 = URL(string: person.thumbnail)
                AsyncImage(
                    url: baseURLimg11!,
                    placeholder: { Text("Loading..").foregroundColor(colorGrey1) },
                    image: { Image(uiImage: $0).resizable()
                    }
                )
                
                .frame(width: UIScreen.main.bounds.width-20, height: 300)
                .clipShape(Rectangle())
                //.padding([.top, .leading, .trailing], 10)
                .scaledToFill()
                
                
                Image("icons8-circled-play-24")
                    .resizable()
             .frame(width: 80, height: 80)

            }
        }
        else if person.fileType == "mp3"{
            ZStack{
               
                let baseURLimg11 = URL(string: person.thumbnail)
                AsyncImage(
                    url: baseURLimg11!,
                    placeholder: { Text("Loading..").foregroundColor(colorGrey1) },
                    image: { Image(uiImage: $0).resizable()
                    }
                )
                
                .frame(width: UIScreen.main.bounds.width-20, height: 300)
                .clipShape(Rectangle())
                //.padding([.top, .leading, .trailing], 10)
                .scaledToFill()
                
                
                Image("icons8-microphone-100_w")
                    .resizable()
             .frame(width: 80, height: 80)

            }
        }
    }//.frame(width: UIScreen.main.bounds.width/3, height: 100)
    .onTapGesture {
        if person.fileType != "Notes"{
            showpicture = true
        }
      
       
        
    }
    .fullScreenCover(isPresented: $showpicture, content: {
        
     
        
        if person.fileType == "jpg" || person.fileType == "jpeg"{
            ImageViewer(imgstr : person.file)
            
        }
        else if person.fileType == "mp4" || person.fileType == "3gp"{
          videoPlayigpage(imgstr : person.file)
            
        }
        
        
        
    })
        
        
        
//       HStack{
//
//
//            Image("icons8-macos-close-24")
//                .resizable()
//            .frame(width: 40, height: 40)
//            .clipShape(Rectangle())
//            //.padding([.top, .leading, .trailing], 10)
//            .aspectRatio(contentMode: .fit)
//        }.frame(width: 40, height: 40)
//       .onTapGesture {
//        obs.showpiclist = true
//
//        var checData: Parameters {
//            [
//                "id": person.fileId,
//
//                  ]
//
//        }
//print(checData)
//        AccountAPI.signin(servciename: "Upload/DeleteUploadedFile", checData) { res in
//        switch res {
//        case .success:
//            print("resulllll",res)
////            if let json = res.value{
////
////            }
//            obs.showlist = true
//            obs.showpiclist = true
//            obs.showvidlist = true
//            obs.showaudiolist = true
//            obs.fetch()
//        case let .failure(error):
//          print(error)
//        }
//      }
//       }
      // .offset(x: UIScreen.main.bounds.width/4-30 , y : -105)
        
        
    }.background(Color.white.ignoresSafeArea())
    .cornerRadius(0)
//    //.shadow(color: colorGrey1, radius: 3)
//    .padding([.top, .leading, .trailing,.bottom], 5)
//    .font(.headline).foregroundColor(.black)
//    .onTapGesture {
//        print(person.catname)
//        showPopup = true
//        UserDefaults.standard.set(person.id, forKey: "catID")
//        UserDefaults.standard.set(person.catname, forKey: "catname")
//
//    }.fullScreenCover(isPresented: $showPopup, content: {
//                SubCatagory()
//
//            })
  }
}
struct EventDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventDetail()
    }
}
