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
    
    // init the container from the FoodModel which contains all the entities we need
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
            // save the changes
            try context.save()
            print("CoreData is updated successfully")
        } catch let Error {
            print("\(Error)")
        }
    }
    
    
    //***********************For Fridge storage***********************
    
    // fetch the food data for fridge
    func fetchFoodData() -> [Food] {
        let fetchRequest: NSFetchRequest<Food>
        fetchRequest = Food.fetchRequest()
        let context = container.viewContext
        let objects = try? context.fetch(fetchRequest)
        return quicksortForExpiryDate(objects!)
    }
    
    // Using quicksort to sort the food array by the expiry date
    func quicksortForExpiryDate(_ objects: [Food]) -> [Food] {
        // early return
        guard objects.count > 1 else { return objects}
        let pivot = objects[0]
        let earlier = objects.suffix(from: 1).filter{$0.expiryDate! < pivot.expiryDate!}
        let later = objects.suffix(from: 1).filter{$0.expiryDate! > pivot.expiryDate!}
        // keep doing recurion until the array is completely sorted
        return quicksortForExpiryDate(earlier) + [pivot] + quicksortForExpiryDate(later)
    }
    
    // add a single food into the fridge
    func addFood(name: String, category: String, amount: Double, unit: String, entryDate: String, expiryDate: Date, context: NSManagedObjectContext) {
        let newFood = Food(context: context)
        newFood.id = UUID()
        newFood.name = name
        newFood.category = category
        newFood.amount = amount
        newFood.remaining = 100
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
    
    
    // edit the comsumed bar in the food detail screen
    func consumeFood(id: UUID, remaining: Double, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Food>
        fetchRequest = Food.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id == %@", id.uuidString)
        
        let context = container.viewContext
        
        do {
            let object: [Food] = try context.fetch(fetchRequest)
            object[0].remaining = remaining
            save(context: context)
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    // ***********************For Sticky notes on Fridge door***********************
    
    //separate 3 arrays (expired, 1 days left, 3 days left), will be used on the sticky on the fridge door
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
    
    
    // ***********************For Shopping list***********************
    
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
    
    // add a stored item from food detail to the shopping list
    func fromDetailsAddToBuy(name: String, context: NSManagedObjectContext) {
        let toBuy = Shopping(context: context)
        toBuy.id = UUID()
        toBuy.name = name
        toBuy.details = ""
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
    // show food's existence, validation check: expired food will be filtered out
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
    
    // update the checked status of a food in shopping list
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
    
    // edit name or description of the item in the shopping list
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
    
    // ***********************For receipt dishes and ingredients***********************
    
    // fetch all the dishes on dish main screen
    func fetchAllDishes() -> [Dishes] {
        let fetchRequest: NSFetchRequest<Dishes>
        fetchRequest = Dishes.fetchRequest()
        let context = container.viewContext
        let object = try? context.fetch(fetchRequest)
        return object!
    }
    
    func fetchRelatedIngredient(dishId: UUID) -> [Ingredients]{
        let fetchRequest: NSFetchRequest<Ingredients>
        fetchRequest = Ingredients.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "dishId == %@", dishId.uuidString)
        
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
    func addDish(dishName: String, portion: Int, note: String, ingredients: [String], img: String, context: NSManagedObjectContext) {
        
        // dish part
        let newDish = Dishes(context: context)
        newDish.id = UUID()
        newDish.dishName = dishName
        newDish.note = note
        newDish.portion = Int16(portion)
        newDish.dishImg = img
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
    
    // delete all the receipt
    func deleteAllDishes(context: NSManagedObjectContext) {
        
        // get two delete requests from dishes and ingredients
        let deleteAllDishes: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dishes")
        let deleteAllIngredients: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Ingredients")
        
        let deleteRequest1 = NSBatchDeleteRequest(fetchRequest: deleteAllDishes)
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: deleteAllIngredients)
        
        do {
            // delete all data in both entities
            try container.viewContext.execute(deleteRequest1)
            try container.viewContext.execute(deleteRequest2)
            save(context: context)
        } catch let error {
            print(error)
        }
    }
    
    // show notification if the ingredient remains less inside the fridge
    func checkRemainingFromDish(name: String) -> Bool {
        let fetchRequest: NSFetchRequest<Food>
        fetchRequest = Food.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "name == %@", name)
        
        let context = container.viewContext
        
        do {
            let objects: [Food] = try context.fetch(fetchRequest)
            return objects[0].remaining >= 30 ? true : false
        } catch let error as NSError {
            print(error)
        }
        
        return false
    }
    
    
    
    // // ***********************For the fridge name :) ***********************
    
    // show the name of the fridge on the fridge door
    func fetchFridgeName() -> String {
        let fetchRequest: NSFetchRequest<Fridge>
        fetchRequest = Fridge.fetchRequest()
        let context = container.viewContext
        
        do {
            
            let objects = try context.fetch(fetchRequest)
            // when first time in use, the default name is your fridge
            return objects.isEmpty ? "Your Fridge" : objects[0].name!
            
        } catch let error as NSError{
            print(error)
        }
        
        return "Your Fridge"
    }
    
    // edit the name of the fridge
    func updateFridgeName(newFridgeName: String) {
        let fetchRequest: NSFetchRequest<Fridge>
        fetchRequest = Fridge.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let context = container.viewContext
        let objects: [Fridge] = try! context.fetch(fetchRequest)
        
        // when first time in use, we'll add a new name
        if objects.isEmpty == true {
            let newName = Fridge(context: context)
            newName.name = newFridgeName
            save(context: context)
        } else {
            do {
                // edit the name if it already has one
                let newObject = try context.fetch(fetchRequest).first
                newObject?.name = newFridgeName
                save(context: context)
            } catch let error {
                print(error)
            }
        }
    }
    
    // *********************** For Speech Recognition ***********************
    
    // for dish recommentation
    func dishRecommendation() -> String {
        // get all cookable dishes (user has sufficient ingredients)
        let dishRec = fetchAllDishes().compactMap{$0}.filter{fetchRelatedIngredient(dishId: $0.id!).map{$0.name!}.allSatisfy{checkIfExist(foodName: $0) == true}}.map{$0.dishName}
        
        // early return if user doesn't buy any food
        guard fetchFoodData().count > 0 else { return "Sorry, I guess you don't have any food in the fridge, I suggest you to go for a grocery shopping" }
        
        // early return if user doesn't make any recipe
        guard dishRec.count > 0 else { return "Sorry, I guess you didn't make any recipe" }
        
        // early return if user only has only one recipe or only have one cookable dish
        // so no random is needed
        guard dishRec.count > 1 else { return "I guess you only can cook \(dishRec[0]!), you don't have any choice" }
        
        
        // early return if user only has two cookable dishes, so random pick is also not needed in this case
        guard dishRec.count > 2 else { return "You only have two choices, you can choose either \(dishRec[0]!) or \(dishRec[1]!), or maybe both of them"}
        
        // if number of cookable dishes > 2
        let dish = dishRec.randomElement()!
        
        let ans = ["I'd recommend to cook \(String(describing: dish!))", "What about \(String(describing: dish!))? You have enough ingredient", "Would you like to have \(String(describing: dish!))", "Ummmmmmmm, let me think......, would you like to make \(String(describing: dish!))?"]
        
        return ans.randomElement()!
    }
    
    // check if the user can cook some thing
    func checkCookable(dish: String) -> String {
        // yup, you have enough ingredient to cook
        // Sorry, ingredient is missing / are missing
        
        // early return if user doesn't buy any food
        guard checkFridgeEmpty() == false else { return "Sorry, I guess you can't cook anything, I can't find anything you can eat in the fridge, I suggest you to go for a grocery shopping"}
        
        // early return if user doesn't make any recipe
        guard fetchAllDishes().isEmpty == false else { return "Sorry, you don't make any recipe here, please feel free to create one"}
        
        // early return if the recipe doesn't exist
        guard fetchAllDishes().compactMap({$0.dishName?.lowercased()}).contains(dish) else { return "Sorry, I cannot find this recipe"}
        
        let dishName = fetchAllDishes().compactMap({$0.dishName}).filter{$0.lowercased() == dish}[0]
        
        let fetchRequest: NSFetchRequest<Dishes>
        fetchRequest = Dishes.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "dishName == %@", dishName)
        let context = container.viewContext
        let object = try? context.fetch(fetchRequest)
        
        let dishId = object![0].id
        
        // if user has all the ingredients and all of them are sufficient
        if fetchRelatedIngredient(dishId: dishId!).compactMap({$0.name}).allSatisfy({checkIfExist(foodName: $0) == true && checkRemainingFromDish(name: $0) == true}) {
            return "Yup, you have enough ingredient to cook it!"
        
        // if user has all ingredients needed, but one or some of them is(are) not sufficient (remaining less than 30%)
        } else if fetchRelatedIngredient(dishId: dishId!).compactMap({$0.name}).allSatisfy({checkIfExist(foodName: $0) == true}) {
            let warningItem = fetchRelatedIngredient(dishId: dishId!).compactMap({$0.name}).filter{checkRemainingFromDish(name: $0) == false}
            
            if warningItem.count == 1 { return "Yup, you have all the ingredients you need, but you don't have much \(warningItem[0]) left" }
            if warningItem.count == 2 { return "Yes, you have enough ingredients, but you don't have much \(warningItem[0]) and \(warningItem[1]) left"}
            if warningItem.count > 2 {
                return "You have all the ingredients you need, but it may not be enough for you to cook, so please check again"
            }
            
        // if user doesn't have all the ingredients needed
        } else if fetchRelatedIngredient(dishId: dishId!).compactMap({$0.name}).allSatisfy({checkIfExist(foodName: $0) == false}){
            return "Sorry, you don't have all the ingredients you need, I suggest you go for a grocery shopping or cook something else"
            
        // if user doesn't have one or some of the ingrdients
        } else if fetchRelatedIngredient(dishId: dishId!).compactMap({$0.name}).allSatisfy({checkIfExist(foodName: $0) == true}) == false {
            let missingItem = fetchRelatedIngredient(dishId: dishId!).compactMap({$0.name}).filter{checkIfExist(foodName: $0) == false}
            
            if missingItem.count == 1 { return "I am sorry, you are missing \(missingItem[0])"}
            if missingItem.count == 2 { return "I am sorry, you are missing \(missingItem[0]) and \(missingItem[1])"}
            if missingItem.count > 2 {
                return "I am sorry, you don't have \(missingItem.prefix(missingItem.count-1).joined(separator: ", "))) and \(missingItem[missingItem.count-1]) in your fridge"
            }
            
        }

        return "Sorry, I don't know, um.....I can't help"
    }
    
    // check if the fridge is empty
    private func checkFridgeEmpty() -> Bool{
        let fetchRequest: NSFetchRequest<Food>
        fetchRequest = Food.fetchRequest()
        let context = container.viewContext
        let objects = try? context.fetch(fetchRequest)
        return objects!.filter{checkExpired(expiryDate: $0.expiryDate!) == false}.count == 0 ? true : false
    }
}
