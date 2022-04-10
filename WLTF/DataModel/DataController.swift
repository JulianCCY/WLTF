//
//  DataController.swift
//  WLTF
//
//  Created by Chan Chung Yin on 8/4/2022.
//

import Foundation
import CoreData

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
            print("Food Added")
        } catch {
            print("Error occurred")
        }
    }
    
    func addFood(name: String, category: String, amount: Double, unit: String, exiryDate: Date, context: NSManagedObjectContext) {
        let newFood = Food(context: context)
        newFood.id = UUID()
        newFood.foodName = name
        newFood.category = category
        newFood.amount = amount
        newFood.unit = unit
        newFood.expiryDate = exiryDate
        
        save(context: context)
    }
    
    func editFood(food: Food, name: String, category: String, amount: Double, unit: String, context: NSManagedObjectContext) {
        food.expiryDate = Date()
        food.foodName = name
        food.category = category
        food.amount = amount
        food.unit = unit
        
        save(context: context)
        
    }
}
