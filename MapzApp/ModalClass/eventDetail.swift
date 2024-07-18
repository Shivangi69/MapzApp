//
//  orderlistmodel.swift
//  Indemart
//
//  Created by Misha Infotech on 30/06/2021.
//
import Foundation

struct eventmodal {
    var  eventId : String
   
         var  userId : String
    var    longitude : String
    var    latitude : String
    var    diaryName : String
    var    diaryDescription  : String
    var    date : String
    var Files : NSArray
    var Notes : NSArray
    
    init(_ eventId:String,_ userId:String,_ longitude:String,_ latitude:String,_ diaryName:String,_ diaryDescription:String,_ date:String,Files:NSArray,Notes:NSArray){
       self.eventId  = eventId
       self.userId = userId
        self.longitude = longitude
        self.latitude = latitude
        self.diaryName = diaryName
        self.diaryDescription = diaryDescription
        self.date = date
        self.Files = Files
        self.Notes = Notes

       // self.rider_mobile = rider_mobile
       
    
    }
    
}
struct FilesModal {
    var  Id : String
    var    fileType : String
    var    file : String
   
    
    init(_ Id:String,_ fileType:String,_ file:String){
       self.Id  = Id
       self.fileType = fileType
        self.file = file
      
    }
    
}
struct NotesModal {
    var  Id : String
    var    noteText : String
    
    init(_ Id:String,_ noteText:String){
       self.Id  = Id
       self.noteText = noteText
       
    }
    
}
