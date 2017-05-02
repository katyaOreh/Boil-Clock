//
//  Timer+CoreDataProperties.swift
//  Boil Clock
//
//  Created by Katya on 27.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import Foundation
import CoreData


extension Timer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timer> {
        return NSFetchRequest<Timer>(entityName: "Timer");
    }

    @NSManaged public var duration: Int32
    @NSManaged public var product: Product?

}
