//
//  WorkoutLogs.swift
//  ExerciseTrackerApp-2
//
//  Created by JPL-ST-SPRING2021 on 4/24/22.
//

import Foundation

class WorkoutLogs{
    
    private var workouts: [Workout] = [
        Workout(title: "Running ", isDone: false),
        Workout(title: "PushUps ", isDone: false),
        Workout(title: "Situps ", isDone: false),
    ]
    
    var count: Int{
        return workouts.count;
    }
    
    func item(forIndexPath indexPath: IndexPath) -> Workout? {
        return workouts[indexPath.row];
    }
    
    func delete(atIndexPath indexPath: IndexPath){
        workouts.remove(at: indexPath.row);
    }
    
    func workoutComplete(atIndexPath indexPath: IndexPath){
        workouts[indexPath.row].isDone = true;
    }
    
    func insertWorkout(workout: Workout) -> IndexPath{
        workouts.append(workout)
        
        return IndexPath(row: workouts.count - 1, section: 0)
    }
}
