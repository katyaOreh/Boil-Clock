//
//  ApiManager.swift
//  Boil Clock
//
//  Created by Katya on 21.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import Foundation
import Alamofire


class ApiManager: NSObject
{

    func getAllCategory() -> [Any]?
    {
        
        Alamofire.request("https://boilapi.apphb.com/api/categoties").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
        
        
//        Alamofire.request("https://boilapi.apphb.com/api/categoties").response { response in
//            print("Request: \(response.request)")
//            print("Response: \(response.response)")
//            print("Error: \(response.error)")
//            
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)")
//            }
//        }
        
        
        return nil
    }
}
