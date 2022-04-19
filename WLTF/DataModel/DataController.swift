//
//  DataController.swift
//  WLTF
//
//  Created by Chan Chung Yin on 11/4/2022.
//

import Foundation
import CoreData

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
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("CoreData is updated successfully")
        } catch let Error {
            print("\(Error)")
        }
    }
    
    // Fridge storage
    
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
    
    // Shopping list
    
    // add a TO-BUY item to the shopping list
    func addToBuy(name: String, descr: String, context: NSManagedObjectContext) {
        let toBuy = Shopping(context: context)
        toBuy.id = UUID()
        toBuy.name = name
        toBuy.details = descr
        
        save(context: context)
    }
    
    func clearWholeList() {
        
    }
    
    func fetchFoodData() -> [Food] {
        let fetchRequest: NSFetchRequest<Food>
        fetchRequest = Food.fetchRequest()
        let context = container.viewContext
        let objects = try? context.fetch(fetchRequest)
        return objects!
        
    }
}
