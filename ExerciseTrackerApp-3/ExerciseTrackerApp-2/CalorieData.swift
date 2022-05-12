//
//  CalorieData.swift
//  ExerciseTrackerApp-2
//
//  Created by JPL-ST-SPRING2021 on 5/8/22.
//

import Foundation
import CoreData
import UIKit

struct Calorie{
    let calorieCount: Double
    //let calculatedCalorie: Double
}

class CalorieData{
    
    
    private var calories: [Calorie] = []
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "ExerciseTrackerDatabase")
        persistentContainer.loadPersistentStores{(_, error: Error?) in
            if let error = error {
                fatalError("ERROR: Persistance Storage not loaded")
            }
        }
        return persistentContainer
    }()
    
    //number of entries
    var count: Int{
        return calories.count;
    }
    
    //Return row data
    func item(forIndexPath indexPath: IndexPath) -> Calorie? {
        return calories[indexPath.row];
    }
    
    //Delete Entry
    func delete(atIndexPath indexPath: IndexPath){
        let request = CaloriesEntity.fetchRequest();

        //search for deleted entry
        let context = persistentContainer.viewContext
        if let result = try? context.fetch(request){
            for object in result{
                if(object.calorieCount == calories[indexPath.row].calorieCount){
                    context.delete(object) //delete entry
                    break;
                }
            }
        }
        
        //save updated state to CoreData
        do{
            try context.save();
            
        }catch{
            print(error)
        }
        
        calories.remove(at: indexPath.row);
    }
    
   
    //Insert Entries
    func insertWorkout(calorie: Calorie) -> IndexPath{
        calories.append(calorie);
        
        let context = persistentContainer.viewContext;
        let managedObject = CaloriesEntity(context: context)
        managedObject.calorieCount = calorie.calorieCount
   
        do{
            try context.save()
        }
        catch{
            print(error)
        }
        return IndexPath(row: calories.count - 1, section: 0)
    }
    
    //load core data entity to cells
    func getData(){
        let request = CaloriesEntity.fetchRequest();
        let context = persistentContainer.viewContext

        do{
            let result = try context.fetch(request)
            let calorieItem: [Calorie] = result.compactMap{(caloriesEntity: CaloriesEntity ) in
                let calorieCount = caloriesEntity.calorieCount

                return Calorie(calorieCount: calorieCount)
            }
            self.calories = calorieItem
        }catch{
            print(error)
        }
    }
    
    
}

