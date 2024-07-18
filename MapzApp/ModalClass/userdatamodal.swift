//
//  userDataModal.swift
//  MapzApp
//
//  Created by Misha Infotech on 10/09/2021.
//

import Foundation


struct Profilemodalclassss {
   
    var  userId : String
    var  longitude : String
    var  latitude : String
    var  diaryName : String
    var  diaryDescription  : String
    var  date : String
    var Files : NSArray
    var Notes : NSArray
    
   
    init(_ userId:String,_ longitude:String,_ latitude:String,_ diaryName:String,_ diaryDescription:String,_ date:String,_ Files:NSArray,_ Notes:NSArray){
       self.userId = userId
        self.longitude = longitude
        self.latitude = latitude
        self.diaryName = diaryName
        self.diaryDescription = diaryDescription
        self.date = date
        self.Files = Files
        self.Notes = Notes
    }
    
}
