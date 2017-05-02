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
    static let sharedInstance = ApiManager()
    
    let baseURL = "https://boilapi.apphb.com/api/"
    
    
    func getAllCategory(success: @escaping ([ProductCategory], [Product]) -> Void, failure: () -> Void)
    {
        Alamofire.request(baseURL + "categories").responseJSON
            { response in
                
            if let json = response.result.value
            {

                var categories = [ProductCategory]()
                for  dict in json as! [Dictionary<String, Any>]
                {
                   let category =  CoreDataManager.sharedInstance.updateCategory(dictionary: dict)
                    categories.append(category)
                }
                self.getAllProduct(success: { (products :[Product]) in
                    success(categories, products)
                }, failure: { 
                    
                })
   
            }
        }
    }
    
    
    func getAllProduct(success: @escaping ([Product]) -> Void, failure: () -> Void)
    {
        Alamofire.request(baseURL + "products").responseJSON
            { response in
                
                if let json = response.result.value
                {
                    
                    var products = [Product]()
                    for  dict in json as! [Dictionary<String, Any>]
                    {
                        let product =  CoreDataManager.sharedInstance.updateProduct(dictionary: dict)
                        products.append(product)
                    }
                    success(products)
                    
                }
        }
    }
}
