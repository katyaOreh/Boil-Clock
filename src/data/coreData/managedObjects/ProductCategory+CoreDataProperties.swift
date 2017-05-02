//
//  ProductCategory+CoreDataProperties.swift
//  Boil Clock
//
//  Created by Katya on 27.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import Foundation
import CoreData


extension ProductCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductCategory> {
        return NSFetchRequest<ProductCategory>(entityName: "ProductCategory");
    }

    @NSManaged public var color: String?
    @NSManaged public var id: Int16
    @NSManaged public var image_name: String?
    @NSManaged public var type: Int16
    @NSManaged public var title: String?
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension ProductCategory {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}
