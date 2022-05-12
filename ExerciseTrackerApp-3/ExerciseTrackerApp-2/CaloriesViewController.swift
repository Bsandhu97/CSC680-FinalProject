//
//  CaloriesViewController.swift
//  ExerciseTrackerApp-2
//
//  Created by JPL-ST-SPRING2021 on 4/26/22.
//

import Foundation
import CoreData
import UIKit

struct Calories{
    let caloriesCount: Double
}

class CaloriesViewController: UIViewController{
    
    var savedCalories: Int = 0;
    var userHeightFeet: Double = 0;
    var userHeightInches: Double = 0;
//    var dataSource = [String]();
//    var selectedButton = UIButton();
//    let tableView = UITableView();
    
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var feetSelection: UIButton!
    @IBOutlet weak var inchesSelection: UIButton!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var calculatedLabel: UILabel!
    @IBOutlet weak var genderMale: UISwitch!
    @IBOutlet weak var feetTextField: UITextField!
    @IBOutlet weak var inchesTextField: UITextField!
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "ExerciseTrackerDatabase")
        persistentContainer.loadPersistentStores{(_, error: Error?) in
            if let error = error {
                fatalError("ERROR: Persistance Storage not loaded")
            }
        }
        return persistentContainer
    }()
    
    private var calories: [Calories] = []
    
    @IBAction func CalorieDataTransition(_ sender: Any) {
        print("Calorie Data Pressed");
       //        self.performSegue(withIdentifier: "WorkoutPageSegue", sender: self)
    }
    
    @IBAction func enteredData(_ sender: Any) {
        guard let dailyCalories = Double(caloriesTextField.text!) else{
            caloriesLabel.text = "ERROR: Not a valid entry";
            return;
        }
        
        let request = CaloriesEntity.fetchRequest();
        let context = persistentContainer.viewContext;
        
//        if let result = try? context.fetch(request){
//            for object in result{
//                context.delete(object) //delete entry
//
//            }
//        }
        
        let managedObject = CaloriesEntity(context: context)
        managedObject.calorieCount = dailyCalories;
        
        do{
            try context.save()
        }
        catch{
            print(error)
        }
        caloriesLabel.text = "Last Entered Daily Calories:  \(dailyCalories)";
    }

    @IBAction func calculateCalories(_ sender: Any) {
        guard let feet = Double(feetTextField.text!) else {
            calculatedLabel.text = "ERROR Feet input not valid";
            return;
        }
        let inches = Double(inchesTextField.text!) ?? 0;
        
        let cmHeight = convertHeightToCm(feet: feet, inches: inches);
        
        guard let userWeight = Double(weightTextField.text!) else{
            calculatedLabel.text = "ERROR: Weight is not a valid entry";
            return;
        }
        guard let userAge = Int(ageTextField.text!) else{
            calculatedLabel.text = "ERROR Age is not a valid entry";
            return;
        }
        
        let total = calculatedCalories(cmHeight: cmHeight, userWeight: userWeight, userAge: userAge)
//
//        let request = CaloriesEntity.fetchRequest();
//        let context = persistentContainer.viewContext;
//
//        if let result = try? context.fetch(request){
//            for object in result{
//                context.delete(object) //delete entry
//            }
//        }
//
//        let managedObject = CaloriesEntity(context: context)
//        managedObject.calorieCount = total;
//
//        do{
//            try context.save()
//        }
//        catch{
//            print(error)
//        }
        calculatedLabel.text = "Daily Calories Intake Calculated: \(total)";
    }
    
    override func viewDidLoad() {
        //print("Transition Complete!!!!!!!!!!!!!!!!!!!!!");
        super.viewDidLoad()
    
        //Daily Calories PlaceHolder Text
        caloriesTextField.attributedPlaceholder = NSAttributedString(
        string: "Enter Daily Calories",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        loadLastCalories();
        
        //Weight PlaceHolder Text
        weightTextField.attributedPlaceholder = NSAttributedString(
        string: "Enter Weight",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )

        //Age PlaceHolder Text
        ageTextField.attributedPlaceholder = NSAttributedString(
        string: "Enter Your Age",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )

        //Height-Feet PlaceHolder Text
        feetTextField.attributedPlaceholder = NSAttributedString(
        string: "Enter Feet",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        //Height Inches PlaceHolder Text
        inchesTextField.attributedPlaceholder = NSAttributedString(
        string: "Enter Inches",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
    }
    
   
    
    func convertHeightToCm(feet :Double, inches :Double) -> Double {
        let feetCm = feet * 30.48
        let inchesCm = inches * 2.54
        let totalCm = feetCm + inchesCm;
        return totalCm;
    }
    
    func calculatedCalories( cmHeight :Double, userWeight :Double, userAge :Int) -> Double{
        let partOne = 10 * userWeight;
        let partTwo = 6.25 * cmHeight;
        let partThree = 5 * userAge;
        
        if(genderMale.isOn){
            let totalCalcualtedCalories = partOne + partTwo - Double(partThree) + 5;
            
            return totalCalcualtedCalories;
        }
        else{
            let totalCalcualtedCalories = partOne + partTwo - Double(partThree) - 161;
            
            return totalCalcualtedCalories;
        }
    }
    
    func loadLastCalories() {
        let request = CaloriesEntity.fetchRequest();
        let context = persistentContainer.viewContext
        //calories.append(calorie);
        
        do{
            let result = try context.fetch(request)
            let calorieItem: [Calories] = result.compactMap{(dailyCalorieEntry: CaloriesEntity) in
                let caloriesCounts = dailyCalorieEntry.calorieCount
                return Calories(caloriesCount: caloriesCounts)
            }
            self.calories = calorieItem;
           
        }catch{
            print(error)
        }
        let calorieNum = (calories.count - 1)
        if(calorieNum <= -1){
            caloriesLabel.text = "Last Entered Daily Calories: No Data";
        }
        else{
            caloriesLabel.text = "Last Entered Daily Calories:  \(calories[calorieNum].caloriesCount)";
        }
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.destination is CalorieDataViewController else {
                return
            }
        }
    
}

