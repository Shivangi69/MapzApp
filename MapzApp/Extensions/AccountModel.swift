//
//  AccountModel.swift
//  SwiftUI Skeleton App
//
//  Created by PW486 on 2019/09/15.
//  Copyright © 2019 PW486. All rights reserved.
//

struct Account: Codable,Identifiable,Hashable{
    var id: Int
    var email: String
    var name: String
    var imei: String
    var ccode: String
    var mobile: String
    var rdate: String
    var password: String
    var status: String
    var pin: String
    var wallet: String
    init(_ id:Int,_ name:String,_ email:String,_ imei:String,_ ccode:String,_ mobile:String,_ rdate:String,_ password:String,_ status:String,_ pin:String,_ wallet:String){
       self.id  = id
       self.name = name
        self.imei = imei
        self.email = email
        self.ccode = ccode
        self.mobile = mobile
        self.rdate = rdate
        self.password = password
        self.status = status
        self.pin = pin
        self.wallet = wallet


     }
}

//struct Account: Codable {
//  var id: Int
//  var catname: String
//  var catimg: String
//  var count: Int
// // var updatedAt: String
//}
