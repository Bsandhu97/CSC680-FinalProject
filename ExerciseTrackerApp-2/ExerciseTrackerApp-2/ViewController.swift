//
//  ViewController.swift
//  ExerciseTrackerApp-2
//
//  Created by JPL-ST-SPRING2021 on 4/24/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var workout: UIButton!

    @IBAction func workoutTransition(_ sender: Any) {
        print("Workout Pressed");
        self.performSegue(withIdentifier: "WorkoutPageSegue", sender: self)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.destination is WorkoutViewController else {
            return
        }
    }
    
}

