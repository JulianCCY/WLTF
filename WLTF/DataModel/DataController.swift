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
// For food in the fridge, item in shopping list and the receipts/ingredients in dish

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
        return quicksortForExpiryDate(objects!)
    }
    
    //quicksort
    // I love alogrithms
    // average complexity Big O of log n
    func quicksortForExpiryDate(_ objects: [Food]) -> [Food] {
        // early return
        guard objects.count > 1 else { return objects}
        let pivot = objects[0]
        let earlier = objects.suffix(from: 1).filter{$0.expiryDate! < pivot.expiryDate!}
        let later = objects.suffix(from: 1).filter{$0.expiryDate! > pivot.expiryDate!}
        return quicksortForExpiryDate(earlier) + [pivot] + quicksortForExpiryDate(later)
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
    
    
    // For Sticky notes on Fridge door
    
    //separate 3 arrays (expired, 1 days left, 3 days left), so boris can add the food in the memo on the fridge door
    func fetchGoingToBeExpired() -> [[Food]] {
        let fetchRequest: NSFetchRequest<Food>
        fetchRequest = Food.fetchRequest()
        let context = container.viewContext
        let objects: [Food] = try! context.fetch(fetchRequest)
        let expired = objects.filter{calcExpiryColor(date: $0.expiryDate!) == "expired"}.sorted{$0.expiryDate! < $1.expiryDate!}
        let oneDay = objects.filter{calcExpiryColor(date: $0.expiryDate!) == "1day"}.sorted{$0.expiryDate! < $1.expiryDate!}
        let threeDay = objects.filter{calcExpiryColor(date: $0.expiryDate!) == "3days"}.sorted{$0.expiryDate! < $1.expiryDate!}
        return [expired, oneDay, threeDay]
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
    
    //update checked status
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
    
    //update the list item
    func updateShoppingListItem(foodId: String, foodName: String, description: String) {
        let fetchRequest: NSFetchRequest<Shopping>
        fetchRequest = Shopping.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id == %@", foodId)
        let context = container.viewContext
        do {
            let objects: [Shopping] = try context.fetch(fetchRequest)
            objects[0].name = foodName
            objects[0].details = description
            save(context: context)
            print("update ok")
        } catch let error as NSError {
            print(error)
        }
    }
    
    // For receipt dishes and ingredients
    
    // fetch dish
    func fetchAllDishes() -> [Dishes]{
        let fetchRequest: NSFetchRequest<Dishes>
        fetchRequest = Dishes.fetchRequest()
        let context = container.viewContext
        let object = try? context.fetch(fetchRequest)
        return object!
    }
    
    // fetcha all ingredient
    func fetchAllIngredient() -> [Ingredients]{
        let fetchRequest: NSFetchRequest<Ingredients>
        fetchRequest = Ingredients.fetchRequest()
        let context = container.viewContext
        let object = try? context.fetch(fetchRequest)
        return object!
    }
    
    // add dishes
    func addDish(dishName: String, portion: Int, note: String, ingredients: [String], context: NSManagedObjectContext) {
        
        // dish part
        let newDish = Dishes(context: context)
        newDish.id = UUID()
        newDish.dishName = dishName
        newDish.note = note
        newDish.portion = Int16(portion)
        save(context: context)
        
        // ingredient part
        ingredients.forEach{
            let relatedIngredients = Ingredients(context: context)
            relatedIngredients.dishId = newDish.id
            relatedIngredients.name = $0
            save(context: context)
        }
    }
    
    // delete dish -> delete ingredient at the same
    func deleteDish(dishId: UUID, context: NSManagedObjectContext) {
        // 1. delete the receipt
        let dishFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dishes")
        dishFetchRequest.predicate = NSPredicate.init(format: "id == %@", dishId.uuidString)
        
        // 2. delete the related ingredients
        let ingredFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Ingredients")
        ingredFetchRequest.predicate = NSPredicate.init(format: "dishId == %@", dishId.uuidString)
        let ingredDeleteFetchRequest = NSBatchDeleteRequest(fetchRequest: ingredFetchRequest)
        
        do {
            let dish = try context.fetch(dishFetchRequest)
            for d in dish {
                context.delete(d as! NSManagedObject)
            }
            save(context: context)
            
            try container.viewContext.execute(ingredDeleteFetchRequest)
            save(context: context)
        } catch {
            print(error)
        }
        
    }
    
    func deleteAllDishes() {
        
    }
    
    // edit dish
    func editDish() {
        
        func addIngredientToDish(dishId: String, ingredients: [String]) {
            
        }
        
        func removeIngredientToDish() {
            
        }
    }
    
    
    
    // check enough to cook
    func checkIfEnoughIngredient() {
        
    }
    
    // add ingredient to shopping list
    func addToBuyFromDish() {
        
    }
    
    // For settings
    func fetchFridgeName() -> String{
        let fetchRequest: NSFetchRequest<Settings>
        fetchRequest = Settings.fetchRequest()
        let context = container.viewContext
        do {
            let objects = try context.fetch(fetchRequest).first
            return objects?.fridgeName == nil ? "" : objects!.fridgeName!
        } catch let error as NSError {
            print(error)
        }
        return ""
    }
    
    func updateFridgeName(newFridgeName: String) {
        let fetchRequest: NSFetchRequest<Settings>
        fetchRequest = Settings.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let context = container.viewContext
        
        do {
            let objects = try context.fetch(fetchRequest).first
            objects?.fridgeName = newFridgeName
            save(context: context)
            print("update ok")
        } catch let error as NSError {
            print(error)
        }
        
    }
}
