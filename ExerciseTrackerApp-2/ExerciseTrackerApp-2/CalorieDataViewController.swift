//
//  CalorieDataViewController.swift
//  ExerciseTrackerApp-2
//
//  Created by JPL-ST-SPRING2021 on 5/8/22.
//

import Foundation
import UIKit
import CoreData

class calorieCell: UITableViewCell{
    
}

class CalorieDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let calories = CalorieData();
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(workoutCell.self, forCellReuseIdentifier: "CaloriesTable");
        tableView.reloadData();
        calories.getData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("numRow CALLED!!!!!!!!!!!")
        print(calories.count)
        return calories.count;
    }
    
    //Load cell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("IN THE CELL FOR ROW AT")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaloriesTable", for: indexPath)
        let caloriesLabels = calories.item(forIndexPath: indexPath)
        cell.textLabel!.text = String(caloriesLabels!.calorieCount);
    
        print(caloriesLabels!.calorieCount)

        return cell;
    }
    
    //Delete func
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            calories.delete(atIndexPath: indexPath);
            tableView.deleteRows(at: [indexPath], with: .fade);
            tableView.reloadData();
        }
    }
     
    
    
}

