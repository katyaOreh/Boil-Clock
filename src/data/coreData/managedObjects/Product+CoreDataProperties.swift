//
//  Product+CoreDataProperties.swift
//  Boil Clock
//
//  Created by Katya on 27.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product");
    }

    @NSManaged public var duration: Double
    @NSManaged public var id: String?
    @NSManaged public var image_url: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var product_description: String?
    @NSManaged public var title: String?
    @NSManaged public var category: ProductCategory?
    @NSManaged public var timers: NSSet?

}

// MARK: Generated accessors for timers
extension Product {

    @objc(addTimersObject:)
    @NSManaged public func addToTimers(_ value: Timer)

    @objc(removeTimersObject:)
    @NSManaged public func removeFromTimers(_ value: Timer)

    @objc(addTimers:)
    @NSManaged public func addToTimers(_ values: NSSet)

    @objc(removeTimers:)
    @NSManaged public func removeFromTimers(_ values: NSSet)

}
