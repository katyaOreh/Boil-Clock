//
//  ProductTimer+CoreDataProperties.swift
//  Boil Clock
//
//  Created by Katya on 06.05.17.
//  Copyright © 2017 anka. All rights reserved.
//

import Foundation
import CoreData


extension ProductTimer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductTimer> {
        return NSFetchRequest<ProductTimer>(entityName: "ProductTimer")
    }

    @NSManaged public var duration: Int32
    @NSManaged public var product: Product?
    @NSManaged public var title: String?
}
