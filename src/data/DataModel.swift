//
//  DataModel.swift
//  Boil Clock
//
//  Created by Katya on 07.05.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

public protocol DataModelProtocol
{
   func dataWasLoad()
   func dataNotLoad()
}

class DataModel: NSObject
{
    static let sharedInstance = DataModel()
    var delegate : DataModelProtocol?
    
    func createCategories()
    {
        let catecories =  CoreDataManager.sharedInstance.getAllCategories()
        if (catecories?.isEmpty)! == false
        {
            return
        }
        let productCategories : [Dictionary<String, Any>]  =  [["image_name": "cat_eggs", "type": NSNumber.init(value: 4), "color" : "#f2a482", "id" : Int16(0)],
                                                               ["image_name": "cat_groats", "type":NSNumber.init(value: 6), "color" : "#a0b7f1",  "id" : Int16(1)],
                                                               ["image_name": "cat_pasta", "type":NSNumber.init(value: 7), "color" : "#f4bd75", "id" : Int16(2)],
                                                               ["image_name": "cat_meat", "type":NSNumber.init(value: 0), "color" : "#ff89aa",  "id" : Int16(3)],
                                                               ["image_name": "cat_fish", "type":NSNumber.init(value: 2), "color" : "#70e0ed", "id" : Int16(4)],
                                                               ["image_name": "cat_veg", "type":NSNumber.init(value: 1), "color" : "#b5dd7a", "id" : Int16(5)],
                                                               ["image_name": "cat_seafood", "type":NSNumber.init(value: 3), "color" : "#d9a0f1",  "id" : Int16(6)],
                                                               ["image_name": "cat_mashr", "type":NSNumber.init(value: 5), "color" : "#7bdea8",  "id" : Int16(7)],
                                                               ["image_name": "cat_other", "type":NSNumber.init(value: 8), "color" : "#f794dc",  "id" : Int16(8)]]
        
        
        for dict in productCategories
        {
            CoreDataManager.sharedInstance.createCategories(dictionary: dict)
        }
    }
    
    func getAllDataFromServer(completion: () ->() )
    {
        ApiManager.sharedInstance.getAllCategory(success: { [unowned self] (categories: [ProductCategory], products: [Product] )  in
            if self.delegate != nil
            {
                self.delegate?.dataWasLoad()
            }
        })
        {
  
        }
    }
    
}
