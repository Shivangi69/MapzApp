//
//  SearchResultView.swift
//  MapzApp
//
//  Created by Misha Infotech on 13/12/2022.
//

import SwiftUI

struct SearchResultView: View {
    @Environment(\.presentationMode) var presentationMode
    //  @State  var searchText = ""
    @State var searchText =  String()

    @State private var showCancelButton: Bool = false
    var onCommit: () ->Void = {
        print("onCommit")
        
    }
    @State var someText: String = "0.00"
      @State var oldText: String = ""
      @State var amount: Double = 0.00
    @State var heightplus : CGFloat = 35
    @ObservedObject var obs = SearchListObserver()
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                    .frame(height :heightplus)
                VStack(spacing: 8.0){
                    
//                    VStack {
//                           TextField("Enter some text here", text: $someText,
//                                     onCommit: {
//                                       print("someText = \(someText)")
//                                       self.amount = Double(someText)!
//                                       }
//                           )
//                               .onChange(of: someText, perform: { value in
//                                   print(value)
////                                       if someText != oldText {
////                                           someText = editInputNumber(textIn: someText)
////                                           oldText = someText
////                                       }
//                                   }
//
//                               )
//
//                               Text("The amount entered was \(self.amount)")
//
//                               }
                    
                    
                    VStack{
                        
                        Image("")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                        
                        HStack(spacing : 10.0) {
                           
                            HStack(spacing : 10.0) {
                                Text("Search")
                                    .foregroundColor(Color.black)
                                    .font(.custom("Inter-Bold", size: 18 ))
                               
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                    
                                    // Search text field
                                ZStack(alignment: .leading) {
                                    if obs.searchText.isEmpty { // Separate text for placeholder to give it the proper color
                                        Text("")
                                    }
                                        
                                        TextField("", text: $obs.searchText)
                                            .onChange(of: obs.searchText) { _ in
                                                obs.fetch()
                                            }
                                            .foregroundColor(.primary)
                                        
                                    }
                                    
                                    // Clear button
                                    Button(action: {
                                        self.obs.searchText = ""
                                    }) {
                                        Image(systemName: "xmark.circle.fill").opacity(obs.searchText == "" ? 0 : 1)
                                    }
                                }

                                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                                .foregroundColor(.secondary) // For magnifying glass and placeholder text
                                .background(Color(.white))
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1.0))

//
//                                HStack {
//                                    Image(systemName: "magnifyingglass")
//                                    
//                                    // Search text field
//                                    ZStack (alignment: .leading) {
//                                        if obs.searchText.isEmpty { // Separate text for placeholder to give it the proper color
//                                            Text("")
//                                        }
//                                        TextField("", text: $obs.searchText, onEditingChanged: { isEditing in
//                                            self.showCancelButton = true
//                                            obs.fetch()
//                                        }, onCommit: onCommit).foregroundColor(.primary)
//                                    }
//                                    // Clear button
//                                    Button(action: {
//                                        self.obs.searchText = ""
//                                    }) {
//                                        Image(systemName: "xmark.circle.fill").opacity(obs.searchText == "" ? 0 : 1)
//                                    }
//                                }
//                                
//                                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
//                                .foregroundColor(.secondary) // For magnifying glass and placeholder test
//                                .background(Color(.white))
//                                .overlay(RoundedRectangle(cornerRadius: (16)).stroke(lineWidth: 1.0))
                                
                            }.frame(width: UIScreen.main.bounds.width-30 )
//                                       .padding()
//                            HStack {
//                                Image(systemName: "magnifyingglass")
//                                
//                                // Search text field
//                                TextField("Search", text: $searchText,
//                                          onCommit: {
//                                            print("Search = \(searchText)")
//                                          //  self.amount = Double(searchText)!
//                                            }
//                                )
//                                
//                                    .onChange(of: searchText, perform: { value in
//                                        print(value)
//     //                                       if someText != oldText {
//     //                                           someText = editInputNumber(textIn: someText)
//     //                                           oldText = someText
//     //                                       }
//                                        obs.searchText = value
//                                        obs.fetch()
//                                        }
//                                    
//                                    )
//                                
//                                    .foregroundColor(Color.black)
//                                    .font(.custom("Inter-Regular", size: 20))
//                             
//                            }
                       
                            
                        }.frame(width: UIScreen.main.bounds.width-30)
                            
                    }
                    HStack{
                        
                    }
                    .frame(width: UIScreen.main.bounds.width-16, height: 1.0)
                    .border(Color.black, width: 1)
                    .padding(.bottom,
                             5.0)
                }
                
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        //                            ForEach(0..<dataTypesArray.count) { each in
                        //
//                        ForEach(obs.eventlist, id: \.self) { pokemon in
                            
                            ForEach((obs.eventlist).filter{$0.userName.contains(searchText) || searchText == ""}, id:\.self) { pokemon in
                          
                            
            //  ForEach((obs.eventlist).filter{$0.address.contains(searchText) || searchText == ""}, id:\.self) { pokemon in
            //  searchResultViewCell(eventlistu: pokemon)
                                
                            HStack{
                                VStack(alignment: .leading, spacing: 2){
                                    
                                  //  Text(pokemon.userName)
                                    hilightedText(str: pokemon.userName, searched: searchText)

                                        .font(.custom("Inter-Bold", size: 15))
                                        .multilineTextAlignment(.leading)

                                    //                                Text(highlight(str: pokemon.address))
                                    //                                    .font(.custom("Inter-Regular", size: 15))
                                    //
                                    //
//                                    Text(pokemon.address)
//                                        .font(.custom("Inter-Regular", size: 15))
                                    hilightedText(str: pokemon.address, searched: searchText)
                                        .font(.custom("Inter-Regular", size: 15))

                                            .multilineTextAlignment(.leading)
                                }
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width-10 )
                            .padding(.horizontal, 10)
                        }
                    }
                }
                
                
            } //.frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height - 60)
            .onAppear(){
                
                if UIDevice.current.hasNotch {
                    heightplus = 35
                } else {
                    //... don't have to consider notch
                    heightplus = 20
                }
            }
        }
    }
  //  func editInputNumber(textIn: String) -> String
//    {
//            var fixedText = ""
//            var charactersWork = [Character]()
//            charactersWork = getNumericInputString(textIn: textIn)
//            fixedText = formatDecimalNumericString(charactersWork:
//            charactersWork)
//            return fixedText
//    }
    func hilightedText(str: String, searched: String) -> Text {
            guard !str.isEmpty && !searched.isEmpty else { return Text(str) }

            var result: Text!
            let parts = str.components(separatedBy: searched)
            for i in parts.indices {
                result = (result == nil ? Text(parts[i]) : result + Text(parts[i]))
                if i != parts.count - 1 {
                    result = result + Text(searched).foregroundColor(Color("themecolor"))
                }
            }
            return result ?? Text(str)
        }
    
    func highlight(str: String) -> String {
        let textToSearch = searchText
        var result = ""
        
        if str.contains(textToSearch) {
            let index = str.startIndex
            result = String( str[index])
        }
        
        return result
    }
}
struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView()
    }
}

class SearchListObserver: ObservableObject {
    
    @Published   var eventlist = [SearchResultModel]()
    @Published   var showlist = false
    @Published   var addrsStr = String()
    @Published   var searchText = String()
    
    func fetch() {
        
        let str = UserDefaults.standard.string(forKey: "id") ?? ""
        let str1  = "EventDiary/SearchFriend_EventDairy?Id=" + str +  "&msg=" + searchText
        AccountAPI.getsigninwitoutloader(servciename: str1, nil) { res in
            switch res {
            case .success:
                print("resulllll",res)
                
                if let json = res.value{
                    self.eventlist = []
                    print("Josn",json)
                    //  let userdic = json["data"]
                    
                    let events = json["data"]
                    for i in events {
                        
                        let scc = SearchResultModel(i.1["eventId"].intValue,  i.1["diaryName"].stringValue, i.1["diaryDescription"].stringValue, i.1["address"].stringValue,i.1["userName"].stringValue, i.1["profile"].stringValue,i.1["dob"].stringValue,
                                                    i.1["createdBy"].intValue)
                        
                        self.eventlist.append(scc)
                        
                    }
                    
                }
                print(self.eventlist)
            case let .failure(error):
                print(error)
            }
        }
    }
}
   

struct SearchResultModel:Hashable {
    var  eventId : Int
    var  diaryName : String
    var  diaryDescription  : String
    var  address : String
    var  userName : String
    var  profile : String
    var  dob : String
    var  createdBy  : Int
    
    
    init(_ eventId:Int,_ diaryName:String,_ diaryDescription:String,_ address:String,_ userName:String ,_ profile:String ,_ dob:String ,_ createdBy:Int){
        
       self.eventId = eventId
        self.diaryName = diaryName
        self.diaryDescription = diaryDescription
        self.address = address
        self.userName = userName
        self.profile = profile
        self.dob = dob
        self.createdBy = createdBy

    }
    

}
    
struct SearchBarView1: View {

    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    var onCommit: () ->Void = {print("onCommit")}

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                // Search text field
                ZStack (alignment: .leading) {
                    if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                        Text("")
                    }
                    TextField("", text: $searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: onCommit).foregroundColor(.primary)
                }
                // Clear button
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary) // For magnifying glass and placeholder test
            .background(Color(.white))
            .overlay(RoundedRectangle(cornerRadius: (16)).stroke(lineWidth: 1.0))
//            .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//
//            .cornerRadius(10.0)

            if showCancelButton  {
                // Cancel button
                Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
    }
}


extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
extension String {
    func replacingOccurrences(of: String, with: [Text]) -> Text {
        return self.components(separatedBy: of).enumerated().map({(i, s) in
            return i < with.count ? Text(s) + with[i] : Text(s)
        }).reduce(Text(""), { (r, t) in
            return r + t
        })
    }
}
//extension Text {
//    init(_ string: String, configure: ((inout AttributedString) -> Void)) {
//        var attributedString = AttributedString(string) /// create an `AttributedString`
//        configure(&attributedString) /// configure using the closure
//        self.init(attributedString) /// initialize a `Text`
//    }
//}


import SwiftUI
import UIKit

struct SearchTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: SearchTextField

        init(parent: SearchTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.parent.text = textField.text ?? ""
                self.parent.onTextChange?(self.parent.text)
            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            parent.onCommit?()
            return true
        }
    }

    @Binding var text: String
    var onCommit: (() -> Void)?
    var onTextChange: ((String) -> Void)?

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
//        textField.borderStyle = .roundedRect
        textField.placeholder = "Search"
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}

struct UIKLabel: UIViewRepresentable {

    typealias TheUIView = UILabel
    fileprivate var configuration = { (view: TheUIView) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> TheUIView { TheUIView() }
    func updateUIView(_ uiView: TheUIView, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
    }
}
//
//  SearchBarView.swift
//
//
//  Created by Alex Nagy on 17.01.2021.
//

import SwiftUI

@available(iOS 14.0, *)
public struct SearchBarViewNew: View {
    
    var title: String
    @Binding var text: String
    private var font: Font
    private var iconView: () -> AnyView
    private var showsCancelButton: Bool
    private var cancelButtonLabel: () -> AnyView
    private var showsClearSearchButton: Bool
    private var clearSearchButtonLabel: () -> AnyView
    private var textBackgroundView: () -> AnyView
    private var backgroundView: () -> AnyView
    private var spacing: CGFloat
    private var onEditingChanged: (Bool) -> Void
    private var onCommit: () -> Void
    private let onCancel: () -> Void
    
    public init(title: String = "Search",
         text: Binding<String>,
         onCancel: @escaping () -> ()) {
        self.title = title
        self._text = text
        self.font = .subheadline
        self.iconView = { AnyView(Image(systemName: "magnifyingglass").foregroundColor(.gray)) }
        self.showsCancelButton = true
        self.cancelButtonLabel = { AnyView(Text("Cancel")) }
        self.showsClearSearchButton = true
        self.clearSearchButtonLabel =  { AnyView(Image(systemName: "xmark.circle.fill").foregroundColor(Color(.systemGray3))) }
        self.textBackgroundView = { AnyView(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.secondarySystemBackground))) }
        self.backgroundView = { AnyView(Color(.systemBackground)) }
        self.spacing = 8
        self.onEditingChanged = {_ in}
        self.onCommit = {}
        self.onCancel = onCancel
    }
    
    public init(title: String = "Search",
         text: Binding<String>,
         font: Font = .subheadline,
         iconView: @escaping () -> AnyView = { AnyView(Image(systemName: "magnifyingglass").foregroundColor(.gray)) },
         showsCancelButton: Bool = true,
         cancelButtonLabel: @escaping () -> AnyView = { AnyView(Text("Cancel")) },
         showsClearSearchButton: Bool = true,
         clearSearchButtonLabel: @escaping () -> AnyView = { AnyView(Image(systemName: "xmark.circle.fill").foregroundColor(Color(.systemGray3))) },
         textBackgroundView: @escaping () -> AnyView = { AnyView(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.secondarySystemBackground))) },
         backgroundView: @escaping () -> AnyView = { AnyView(Color(.systemBackground)) },
         spacing: CGFloat = 8,
         onEditingChanged: @escaping (Bool) -> Void = {_ in},
         onCommit: @escaping () -> Void = {},
         onCancel: @escaping () -> () = {}) {
        self.title = title
        self._text = text
        self.font = font
        self.iconView = iconView
        self.showsCancelButton = showsCancelButton
        self.cancelButtonLabel = cancelButtonLabel
        self.showsClearSearchButton = showsClearSearchButton
        self.clearSearchButtonLabel = clearSearchButtonLabel
        self.textBackgroundView = textBackgroundView
        self.backgroundView = backgroundView
        self.spacing = spacing
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        self.onCancel = onCancel
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            
            HStack(spacing: 3) {
                iconView()
                TextField(title, text: $text, onEditingChanged: onEditingChanged, onCommit: onCommit).foregroundColor(.primary)
                if text != "", showsClearSearchButton {
                    Button {
                        text = ""
                    } label: {
                        clearSearchButtonLabel()
                    }
                }
            }
            .font(font)
            .padding(5)
            .background(
                textBackgroundView()
            )
            
            if showsCancelButton {
                Button {
                    onCancel()
                } label: {
                    cancelButtonLabel()
                }
            }
        }
        .padding()
        .background(backgroundView().ignoresSafeArea())
    }
}

