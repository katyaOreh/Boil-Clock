//
//  CoreDataManager.swift
//  Boil Clock
//
//  Created by Katya on 23.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit
import CoreData



class CoreDataManager: NSObject
{
    // MARK: - Core Data stack
    
    static let sharedInstance = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer =
        {
            let container = NSPersistentContainer(name: "Boil_Clock")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError?
                {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext ()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges
        {
            do
            {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
        
    func updateProduct(dictionary : Dictionary< String, Any>) -> Product
    {
        let predicate =  NSPredicate.init(format: "id == %@", dictionary["id"] as! CVarArg)
        
        let product = self.findManagedObjectFromEntity(entityName: "Product", predicate: predicate, createNewIfAbsent: true) as! Product
        
        product.id                  = dictionary["id"] as! String?
        product.image_url           = dictionary["image"] as! String?
        product.product_description = dictionary["description"] as! String?
        product.title               = dictionary["title"] as! String?
        
        let dict =  dictionary["category"] as! Dictionary< String, Any>
        let categoryPredicate =  NSPredicate.init(format: "type == %@", dict["type"] as! CVarArg)
        let category = self.findManagedObjectFromEntity(entityName: "ProductCategory", predicate: categoryPredicate, createNewIfAbsent: true) as! ProductCategory
        
        product.category  = category
        
        var timers = NSMutableSet()
        
        for  dict in dictionary["timers"] as! [Dictionary<String, Any>]
        {
            let timer = createTamer(dict: dict)
            timers.add(timer)
        }
        
        product.timers = timers
        
        
        do {
            try self.persistentContainer.viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return product
    }
    
    
    func createTamer(dict: Dictionary <String, Any>) -> ProductTimer
    {
        
        let managedContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ProductTimer",  in: managedContext)!
        
        let timer =  NSManagedObject(entity: entity, insertInto: managedContext) as! ProductTimer
        
        timer.duration = dict["duration"] as! Int32
        timer.title    = dict["description"] as? String
        return timer
    }
    
    
    
    func updateCategory(dictionary : Dictionary< String, Any>) -> ProductCategory
    {
        let predicate =  NSPredicate.init(format: "type == %@", dictionary["type"] as! CVarArg)
        
        let productCategory = self.findManagedObjectFromEntity(entityName: "ProductCategory", predicate: predicate, createNewIfAbsent: true) as! ProductCategory
        
        productCategory.type = (dictionary["type"] as! Int16?)!
        productCategory.title  = dictionary["name"] as! String?
        
        if let imageName = dictionary["image_name"] as! String?
        {
            productCategory.image_name = imageName
        }
        
        if let color = dictionary["color"] as! String?
        {
            productCategory.color = color
        }
        
        if let id = dictionary["id"] as? Int16
        {
            if id > 0
            {
                productCategory.id = id
            }
        }
        
        do
        {
            try self.persistentContainer.viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return productCategory
    }

    
    
    
    
    func findManagedObjectFromEntity(entityName :String, predicate : NSPredicate, createNewIfAbsent: Bool) -> NSManagedObject?
    {
        
        let managedContext = self.persistentContainer.viewContext
        
        let results = selectObjectForName(name: entityName, filterPredicate: predicate, ascending: true)
        
        if results != nil && (results?.count)! > 0
        {
            return results?[0]
        }
        else if createNewIfAbsent
        {
            let entity = NSEntityDescription.entity(forEntityName: entityName,
                                                    in: managedContext)!
            
            return  NSManagedObject(entity: entity, insertInto: managedContext)
        }
        
        return nil
    }
    
    func selectObjectForName(name: String, filterPredicate: NSPredicate?, ascending:Bool) -> [NSManagedObject]?
    {
        let managedContext = self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: name)
        
        if let predicate = filterPredicate
        {
            fetchRequest.predicate = predicate
        }
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
    }
}
