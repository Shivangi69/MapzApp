//
//  RequestAPI.swift
//  SwiftUI Skeleton App
//
//  Created by PW486 on 2019/09/15.
//  Copyright © 2019 PW486. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON
import SSSwiftUILoader
struct RequestAPI {
  static func call(_ path: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping (Result<JSON>) -> Void) {
    //    public static final String URL_BASE = "https://mapzapp.swadhasoftwares.com";
///http://167.86.105.98:7723
    SSLoader.shared.startloader("Loading...", config: .defaultSettings)
    let baseURL = URL(string: "http://167.86.105.98:7723/api/" + path)
      
   //http://grocery.swadhasoftwares.com/api/login.php
    let url = baseURL!//.appendingPathComponent(path)
    let accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
    let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
print("urlllll------",url)
   

    Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { res in
      switch res.result {
      case .success:
        print("Response",res.response!)
        print("Result",res.result)
        print("Result value",res.data!)
        print("request value",res.request!)
        print("dwdedf",res.value!)
        if let value = res.result.value{
          let json = JSON(value)
            SSLoader.shared.stopLoader()

            completion(.success(json))
       }
      case let .failure(error):
        print(error.localizedDescription)
        SSLoader.shared.stopLoader()

        completion(.failure(error))
      }
    }
  }
}
