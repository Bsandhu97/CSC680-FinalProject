//
//  WorkoutLogs.swift
//  ExerciseTrackerApp-2
//
//  Created by JPL-ST-SPRING2021 on 4/24/22.
//

import Foundation
import CoreData
import UIKit

struct Workout{
    let title: String
    var bold: Bool
}

class WorkoutLogs{
    
    static let shared: WorkoutLogs = WorkoutLogs()
    private var workouts: [Workout] = []
    
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
        return workouts.count;
    }
    
    //Return row data
    func item(forIndexPath indexPath: IndexPath) -> Workout? {
        return workouts[indexPath.row];
    }
    
    //Delete Entry
    func delete(atIndexPath indexPath: IndexPath){
        let request = WorkoutsEntity.fetchRequest();

        //search for deleted entry
        let context = persistentContainer.viewContext
        if let result = try? context.fetch(request){
            for object in result{
                if(object.title == workouts[indexPath.row].title){
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
        
//        let deleteEntry = workouts[indexPath.row] as? NSManagedObject
//        {
//            context.delete(deleteEntry)
//        }
        
//        let context = persistentContainer.viewContext
//        let managedObject = WorkoutsEntity(context: context)
//        context.delete()
        
        workouts.remove(at: indexPath.row);
    }
    
    //Highlight Cell
    func workoutComplete(atIndexPath indexPath: IndexPath){
        let textBold = workouts[indexPath.row].bold;
        let context = persistentContainer.viewContext;
        let request = WorkoutsEntity.fetchRequest();
        
        if(textBold == false){
            workouts[indexPath.row].bold = true;
        }
        else{
            workouts[indexPath.row].bold = false;
        }
        
        if let result = try? context.fetch(request){
            for object in result{
                if(object.title == workouts[indexPath.row].title){
                    object.bold = workouts[indexPath.row].bold;
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
        
    }
    
    //Insert Entries
    func insertWorkout(workout: Workout) -> IndexPath{
        workouts.append(workout);
        
        let context = persistentContainer.viewContext;
        let managedObject = WorkoutsEntity(context: context)
        managedObject.title = workout.title;
        managedObject.bold = workout.bold;
      //  managedObject.timeSpent = workout.timeSpent;
        do{
            try context.save()
        }
        catch{
            print(error)
        }
        return IndexPath(row: workouts.count - 1, section: 0)
    }
    
    //load core data entity to cells
    func getData(){
        let request = WorkoutsEntity.fetchRequest();
        let context = persistentContainer.viewContext

        do{
            let result = try context.fetch(request)
            let workoutItem: [Workout] = result.compactMap{(workoutsEntry: WorkoutsEntity ) in
                guard let title = workoutsEntry.title else {
                    return nil
                }
                let bold = workoutsEntry.bold;
                //let timeSpent = workoutsEntry.timeSpent;
                return Workout(title: title, bold: bold)
            }
            self.workouts = workoutItem
        }catch{
            print(error)
        }
    }
    
    
}

