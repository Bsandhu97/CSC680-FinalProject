//
//  WorkoutViewController.swift
//  ExerciseTrackerApp-2
//
//  Created by JPL-ST-SPRING2021 on 4/24/22.
//

//import Foundation
import UIKit

struct Workout {
    let title: String
    var isDone: Bool
}

class workoutCell: UITableViewCell{
    
}

class WorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    private let workouts = WorkoutLogs();
    
    var workoutCells: [Workout] = []
    
    @IBAction func addWorkout(_ sender: UIButton) {
        let tempWorkout = Workout(title: "Hello", isDone: false)
        let indexPath = workouts.insertWorkout(workout: tempWorkout);
        print("ADDING " + tempWorkout.title);
        
        tableView.beginUpdates();
        //self.tableView.reloadRows(at: [workoutIndexPath], with: .fade);
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates();
        
    }
    
    override func viewDidLoad() {
        print("Transition Complete!!!!!!!!!!!!!!!!!!!!!");
        //super.viewDidLoad()
        print(workouts.count)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(workoutCell.self, forCellReuseIdentifier: "WorkoutTable")
        tableView.reloadData();
        
    }
    
    //Count?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numRow CALLED!!!!!!!!!!!")
        print(workouts.count)
        return workouts.count;
    }
    
    //cell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("IN THE CELL FOR ROW AT")
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTable", for: indexPath)
        let workoutLabels = workouts.item(forIndexPath: indexPath)
        cell.textLabel!.text = workoutLabels!.title;
//        guard let cell = tableView.cellForRow(at: indexPath) else {
//            return UITableViewCell()
//        }
        print(workoutLabels!.title)
        return cell;
    }
    
    
    
    //Mark Done
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        workouts.workoutComplete(atIndexPath: indexPath);
        
        self.tableView.beginUpdates();
        self.tableView.reloadRows(at: [indexPath], with: .fade);
        self.tableView.endUpdates();
    }
    
    //Delete func
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            workouts.delete(atIndexPath: indexPath);
            tableView.deleteRows(at: [indexPath], with: .fade);
            tableView.reloadData();
        }
    }
     
    
    
}

