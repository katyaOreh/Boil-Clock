//
//  ProductType.swift
//  Boil Clock
//
//  Created by Katya on 15.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

class ProductType: NSObject
{
    let name : String
    let color : UIColor
    let imageName : String
    
    
    init (name : String, color: UIColor, imageName: String)
    {
        self.name = name
        self.color = color
        self.imageName = imageName
    }

}
