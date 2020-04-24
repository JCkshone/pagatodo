//
//  CoreManager.swift
//  ceiba-test
//
//  Created by Jc on 23/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreManager {
    var appDelegate: AppDelegate?
    
    init(delegate: AppDelegate) {
        self.appDelegate = delegate
    }
    
    
    func createData(users: [User]){
         guard let appDelegate = appDelegate else { return }
         let managedContext = appDelegate.persistentContainer.viewContext
         let userEntity = NSEntityDescription.entity(forEntityName: "UserEntity", in: managedContext)!
         for item in users {
            
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            
            user.setValue(item.id, forKey: "id")
            user.setValue(item.name, forKey: "name")
            user.setValue(item.email, forKey: "email")
            user.setValue(item.phone, forKey: "phone")
            user.setValue(item.address.geo.lat, forKey: "lat")
            user.setValue(item.address.geo.lng, forKey: "lng")
         }
         
         do {
             try managedContext.save()
            
         } catch let error as NSError {
             print("Could not save. \(error), \(error.userInfo)")
         }
     }
    
    func getAll() ->[ [String: Any] ] {
        guard let appDelegate = appDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        var items: [ [String: Any] ] = []
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            for data in result as! [NSManagedObject] {
                var dic: [String: Any] = [:]
                for attribute in data.entity.attributesByName {
                    if let value = data.value(forKey: attribute.key) {
                        dic[attribute.key] = value
                    }
                }
                items.append(dic)
            }
        } catch {
            print("Failed")
        }
        
        return items
    }
}
