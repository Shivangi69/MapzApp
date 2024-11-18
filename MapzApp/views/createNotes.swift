//
//  createNotes.swift
//  MapzApp
//
//  Created by Misha Infotech on 16/08/2021.
//

import SwiftUI
import Alamofire
struct createNotes: View {
    @State private var Note: String = "Enter Note"

   // @State private var Note: String?
    let minHeight: CGFloat = 60
    @State private var height: CGFloat?
    @Environment(\.presentationMode) var presentationMode
    @State var  eventNOE =  UserDefaults.standard.string(forKey: "eventNOE")
    @State var showupdateview = false
    @State  var showingAlert = false
    @State  var message = String()
    @State  var fromgroup = String()
    @State private var textStyle = UIFont.TextStyle.body

    var body: some View {
       // Text("Hello, World!")
        ZStack{

            VStack(spacing: 20.0) {
                
                HStack(spacing: 20.0) {
                    Button(action: {
                        if (eventNOE == "New"){
                            message = "If you go back to home screen current event will be discard. You Want to Processed?"
                            showingAlert = true
                            //presentationMode.wrappedValue.dismiss()
                            
                            
                        } else{
                            showupdateview.toggle()
                        }
                    })
                    {
                        Image("icons8-back-24")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    }
                    .fullScreenCover(isPresented: $showupdateview, content: CreateEventView
                        .init)
                    Spacer()
                    Text("Create New Note")
                        .foregroundColor(Color.white)
                        .font(.custom("Inter-Bold", size: 20))
                    Spacer()
                    
                    Image("")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    
                }
                .padding()
                //             .padding(.top,10)
                .frame(height: 60.0)
                .background(Color("themecolor"))
                
                HStack {
                    TextView1(text: $Note, textStyle: $textStyle)
                        .padding(.horizontal, 8.0)
                        .font(.custom("Inter-Regular", size: 14))
                        .frame(width: UIScreen.main.bounds.width-20, height: 300, alignment: .leading)
                        .cornerRadius(6.0)
                        .border(Color.gray, width: 0.5)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(self.Note == "Enter Note" ? .gray : .black)
                        .onAppear {
                            // Remove the placeholder text when keyboard appears
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                                withAnimation {
                                    if self.Note == "Enter Note" {
                                        self.Note = ""
                                    }
                                }
                            }
                            
                            // Put back the placeholder text if the user dismisses the keyboard without adding any text
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                                withAnimation {
                                    if self.Note == "" {
                                        self.Note = "Enter Note"
                                    }
                                }
                            }
                        }
                    }
                    .font(.body)
                
//                TextEditor(text: Binding($Note, replacingNilWith: ""))
//
//              //  TextEditor(text: $Note)
//                    .padding(.horizontal, 10.0)
//                    .font(.custom("Inter-Regular", size: 17))
//                    .frame(width: UIScreen.main.bounds.width-20, height: 300)
//                    .border(Color.gray, width: 0.5)
                    //.cornerRadius(10)

//                        Button(action: {
//                            //
//                            self.showCameraPopUp = false
//                        }, label: {
//                            Text("Record  Using Mobile")
//                                .font(.custom("Inter-Bold", size: 18))
//                        })
//                        .frame(width: UIScreen.main.bounds.width-100, height: 60)
//                        .background((Color("bluecolor")))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)

                Button(action: {
                    self.AddNote()
                }, label: {
                    Text("Add")
                    .font(.custom("Inter-Bold", size: 18))
                })
                .frame(width: UIScreen.main.bounds.width-30, height: 60)
                .background((Color("themecolor 1")))
                .foregroundColor(.white)
                .cornerRadius(10)
               
           Spacer()
            
        
            }
          } .alert(isPresented:$showingAlert) {
              Alert(
                  title: Text("Do you want to Exit?"),
                  message: Text(message),
                  primaryButton: .destructive(Text("Ok")) {
                      print("Deleting...")
                     
                      deleteevent()

                  },
                  secondaryButton: .cancel()
              )
          }
    }
    
    private func textDidChange(_ textView: UITextView) {
                if textView.contentSize.height >= 150
                {
                    textView.contentSize.height = 150
                }
            self.height = max(textView.contentSize.height, minHeight)

        }

    
    func deleteevent(){
        let str = UserDefaults.standard.string(forKey: "eventID") ?? ""

        var checData: Parameters {
            [
                "id": str,

                  ]

        }
print(checData)
        AccountAPI.signin(servciename: "EventDiary/DeleteEventDiary", checData) { res in
        switch res {
        case .success:
            print("resulllll",res)
            if let json = res.value{

            }
            presentationMode.wrappedValue.dismiss()
        case let .failure(error):
          print(error)
        }
      }
    }
    func AddNote(){
        let evntId = UserDefaults.standard.string(forKey: "eventID") ?? ""

        
        var groupid = String()
        var isgroupid = String()
//
        var ISfromGroup =            UserDefaults.standard.string(forKey: "isGroup")
//        UserDefaults.standard.set("yes", forKey: "isGroup")

        if ISfromGroup == "yes"{
            groupid = UserDefaults.standard.string(forKey: "groupId") ?? ""
            isgroupid = "true"
        }else{
            groupid = "0"
            isgroupid = "false"
        }
        var checData: Parameters {
            [
                "dbEventDiaryId": evntId,
                "noteText": Note ?? "",
                "Groupid1" : groupid,
                "IsGroup1" : isgroupid
                  ]//12
    }
print(checData)
        AccountAPI.signin(servciename: "EventDiaryNote/CreateEventDiaryNote", checData) { res in
        switch res {
        case .success:
            print("resulllll",res)
            if (eventNOE == "New"){
                UserDefaults.standard.set("camera", forKey: "fromwhere")
                showupdateview = true
            }else{
                presentationMode.wrappedValue.dismiss()
               
            }
            
        case let .failure(error):
          print(error)
        
        }
        }
    }
}

struct createNotes_Previews: PreviewProvider {
    static var previews: some View {
        createNotes()
    }
}
public extension Binding where Value: Equatable {
    init(_ source: Binding<Value?>, replacingNilWith nilProxy: Value) {
        self.init(
            get: { source.wrappedValue ?? nilProxy },
            set: { newValue in
                if newValue == nilProxy {
                    source.wrappedValue = nil
                }
                else {
                    source.wrappedValue = newValue
                }
        })
    }
}
struct TextView1: UIViewRepresentable {
 
    @Binding var text: String
    @Binding var textStyle: UIFont.TextStyle
 
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
 
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .clear
        
        return textView
    }
 
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
}
