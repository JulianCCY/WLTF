//
//  DataController.swift
//  WLTF
//
//  Created by Chan Chung Yin on 11/4/2022.
//

import Foundation
import CoreData
import SwiftUI

// This file contains func to implement data management of CoreData (add, edit, delete)

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FoodModel")

    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data: \(error.localizedDescription)")
            }
        }
    }
    
    // save every update in CoreData
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("CoreData is updated successfully")
        } catch let Error {
            print("\(Error)")
        }
    }
    
    
    // For Fridge storage
    
    // fetch the food data for fridge
    func fetchFoodData() -> [Food] {
        let fetchRequest: NSFetchRequest<Food>
        fetchRequest = Food.fetchRequest()
        let context = container.viewContext
        let objects = try? context.fetch(fetchRequest)
        //objects!
        return objects!.sorted{$0.expiryDate! < $1.expiryDate!}
        
    }
    
    // add a single food into the fridge
    func addFood(name: String, category: String, amount: Double, unit: String, entryDate: String, expiryDate: Date, context: NSManagedObjectContext) {
        let newFood = Food(context: context)
        newFood.id = UUID()
        newFood.name = name
        newFood.category = category
        newFood.amount = amount
        newFood.unit = unit
        newFood.entryDate = entryDate
        newFood.expiryDate = expiryDate
        
        save(context: context)
    }
    
//    func editFood(food: Food, name: String, category: String, amount: Double, unit: String, context: NSManagedObjectContext) {
//        food.expiryDate = Date()
//        food.name = name
//        food.category = category
//        food.amount = amount
//        food.unit = unit
//
//        save(context: context)
//
//    }
    
    // delete all the food in the fridge
    func deleteAllFood(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Food")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try container.viewContext.execute(deleteRequest)
            save(context: context)
        } catch let error as NSError {
            print(error)
        }
    }
    
    // delete a single food in the fridge
    func deleteSingleFood(id: UUID, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Food")
        fetchRequest.predicate = NSPredicate.init(format: "id=%@", id.uuidString)
        do {
            let foods = try context.fetch(fetchRequest)
            for food in foods {
                context.delete(food as! NSManagedObject)
            }
            save(context: context)
        } catch {
            print(error)
        }
    }
    
    // For Shopping list
    
    // fetch all the To-buy item for shopping list
    func fetchShoppingData() -> [Shopping] {
        let fetchRequest: NSFetchRequest<Shopping>
        fetchRequest = Shopping.fetchRequest()
        let context = container.viewContext
        do {
            let objects = try context.fetch(fetchRequest)
            return objects
        } catch let Error {
            print(Error)
        }
        return []
     
    }
    
    // add a TO-BUY item to the shopping list
    func addToBuy(name: String, descr: String, context: NSManagedObjectContext) {
        let toBuy = Shopping(context: context)
        toBuy.id = UUID()
        toBuy.name = name
        toBuy.details = descr
        toBuy.checked = NSNumber()
        
        save(context: context)
    }
    
    // delete all the food in the list
    func removeWholeList(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> =
            NSFetchRequest(entityName: "Shopping")
        let deleteRequest =
            NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(deleteRequest)
            save(context: context)
        } catch let error as NSError {
            print(error)
        }
    }
    
    // delete a single item from the shopping list
    func removeSingleItem(id: UUID, context: NSManagedObjectContext){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Shopping")
        fetchRequest.predicate = NSPredicate.init(format: "id == %@", id.uuidString)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            save(context: context)
        } catch let error as NSError {
            print(error)
        }
    }
    
    // check if some food are already stored in the fridge and return the amount of them to shopping list
    // only check have or dun have, and then filter our expired
    func checkIfExist(foodName: String) -> Bool{
        let fetchRequest: NSFetchRequest<Food>
        fetchRequest = Food.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "name == %@", foodName)
        let context = container.viewContext
        do {
            let objects: [Food] = try context.fetch(fetchRequest)
            return objects.filter{checkExpired(expiryDate: $0.expiryDate!) == false}.count > 0 ? true : false
        } catch let error as NSError {
            print(error)
        }
        return false
    }
    
    //update checked status if user tap on the food on the list
    func updateCheckStatus(foodId: UUID, checked: NSNumber) {
        let fetchRequest: NSFetchRequest<Shopping>
        fetchRequest = Shopping.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id == %@", foodId.uuidString)
        let context = container.viewContext
        do {
            let objects: [Shopping] = try context.fetch(fetchRequest)
            objects[0].checked = checked == 0 ? 1 : 0
            save(context: context)
            print("check update")
        } catch let error as NSError {
            print(error)
        }
    }
    
}
