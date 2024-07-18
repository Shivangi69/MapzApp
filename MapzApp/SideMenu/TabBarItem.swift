//
//  TabBarItem.swift
//  CustomTabBar
//
//  Created by Satyadev Chauhan on 23/03/21.
//

import Foundation

enum TabBarItem: CaseIterable {
    case home
    case search
    case Add
    case Friends
case Notification
   
    var title: String {
        switch self {
        case .home:     return ""
        case .search: return ""
        case .Add: return ""
        case .Friends: return ""
        case .Notification: return ""
      
        }
    }
    
    var imageName: String {
        switch self {
        case .home:     return "home"
        case .search: return "search"
        case .Add: return "icons8-plus-25"
        case .Friends: return "icons8-menu-rounded-100"
        case .Notification:   return "noti"
       
        }
    }
}

