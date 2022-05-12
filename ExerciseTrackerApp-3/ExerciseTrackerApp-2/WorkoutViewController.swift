//
//  WorkoutViewController.swift
//  ExerciseTrackerApp-2
//
//  Created by JPL-ST-SPRING2021 on 4/24/22.
//

//import Foundation
import UIKit
import CoreData



class workoutCell: UITableViewCell{
    
}

class WorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    private let workouts = WorkoutLogs();
    
    var workoutCells: [Workout] = []

    
    override func viewDidLoad() {
        print("Transition Complete!!!!!!!!!!!!!!!!!!!!!");
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        print(workouts.count)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(workoutCell.self, forCellReuseIdentifier: "WorkoutTable")
//        guard container != nil else{
//            fatalError("WorkoutView needs a persistents container")
//        }
        tableView.reloadData();
        workouts.getData();
        
    }
    
    @IBAction func addWorkout(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Workout", message: "add a new workout", preferredStyle: .alert);
        alert.addTextField{ textField in
            textField.placeholder = "New Workout Entry"
        }
        
        let addEntry = UIAlertAction(title: "Save", style: .default) {
            [unowned self] _ in
            guard let title = alert.textFields?.first?.text else {
                return;
            }
            let newWorkoutEntry = Workout(title: title, bold: true);
            self.addNewWorkoutEntry(newWorkoutEntry)
            self.tableView.reloadData();
        }
        alert.addAction(addEntry);
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            _ in
        }
        alert.addAction(cancelAction);
        
        present(alert, animated: true, completion: nil);
    }
//
//    func createNewWorkout() -> Workout{
//        let newWorkout = NSEntityDescription.insertNewObject(forEntityName: "WorkoutEntity", into: workouts.persistentContainer.viewContext) as! Workout
//        return Workout
//    }
//
    private func addNewWorkoutEntry(_ workout: Workout){
//        let tempWorkout = Workout(title: "Hello", isDone: false)
        let indexPath = workouts.insertWorkout(workout: workout);
        print("ADDING " + workout.title);
        
        tableView.beginUpdates();
        tableView.reloadRows(at: [indexPath], with: .fade);
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates();
    }
    
//    func colorForIndex(index: Int) -> UIColor {
//        let itemCount = workouts.count - 1
//        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
//        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
//    }
    
//    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
//                            forRowAtIndexPath indexPath: NSIndexPath) {
//
//    }

    //Count?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("numRow CALLED!!!!!!!!!!!")
        print(workouts.count)
        return workouts.count;
    }
    
    //Load cell data, Highlight Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("IN THE CELL FOR ROW AT")
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTable", for: indexPath)
        let workoutLabels = workouts.item(forIndexPath: indexPath)
        cell.textLabel!.text = workoutLabels!.title;
        cell.textLabel!.isEnabled = workoutLabels!.bold;
        
        if(workoutLabels?.bold == false){
            cell.backgroundColor = UIColor.systemMint
        }
        else{
            cell.backgroundColor = UIColor.white
            //print("made it to the if statement")
        }
    
        print(workoutLabels!.title)
        print(workoutLabels!.bold)
        
//        setContentOffset 
//        insertRows(at: indexPath, with: UITableView.RowAnimation)
        return cell;
    }
    
    //Bold Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        workouts.workoutComplete(atIndexPath: indexPath);
        //print("SELECTED COMPLETE")
        
        self.tableView.beginUpdates();
        self.tableView.reloadRows(at: [indexPath], with: .top);
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

