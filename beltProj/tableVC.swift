//
//  tableVC.swift
//  beltProj
//
//  Created by Lu Yu on 7/25/17.
//  Copyright © 2017 Lu Yu. All rights reserved.
//

import UIKit
import CoreData

class tableVC: UITableViewController {

//    let sectionTitles = ["Incomplete", "Complete"]
//    var incomGoals = [Goal]()
//    var cmpGoals = [Goal]()
    var allGoals = [Goal]()
    var notshowcmp: Bool = false
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    func diffGoals() {
//        let userDefaults = UserDefaults.standard
//        if let notShowCmp = UserDefaults.value(forKey: "notshowcmp") {
//            print(notShowCmp)
//        }
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var Goal:Goal?
        Goal = allGoals[indexPath.row]
        Goal?.cmp = true
        do {
            try context.save()
            print("\(String(describing: Goal)) completed")
        } catch {
            print("Error in completing \(String(describing: Goal))")
        }
        fetchAllGoals()
//        diffGoals()
        tableView.reloadData()
        
    }
//    
    func fetchAllGoals() {
//        let userDefaults = UserDefaults.standard
        //let value  = userDefaults.string(forKey: "Key")
//        let filter: Bool? = userDefaults.object(forKey: "notshowcmp") as? Bool
//        if let value = filter {
//            print("value is", value)
//            notshowcmp = (userDefaults.value(forKey: "notshowcmp") != nil)
//            print("not show cmp is",notshowcmp)
//        }
        var results = [Goal]()
        allGoals = []
        let fec:NSFetchRequest = Goal.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fec.sortDescriptors = [sortDescriptor]
        do {
            results = try context.fetch(fec)
        } catch {
            print(error)
        }
        if notshowcmp {
            for goal in results {
                if goal.cmp == false {
                    allGoals.append(goal)
                }
            }
        } else {
            allGoals = results
        }
        print("fetched", allGoals.count)
        for goal in allGoals {
            print(goal.cmp)
        }
        
    }
//    func diffGoals() {
//        cmpGoals = [Goal]()
//        incomGoals = [Goal]()
//        for Goal in allGoals {
//            if Goal.cmp == false {
//                incomGoals.append(Goal)
//            } else {
//                cmpGoals.append(Goal)
//            }
//        }
//    }
//    func editGoal(sender: GoalCellVC){
//        let indexPath = tableView.indexPath(for: sender)
//        performSegue(withIdentifier: "editSegue", sender: indexPath)
//        //        print("perform run")
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editSegue" {
            let nav = segue.destination as! UINavigationController
           
            let viewController = nav.topViewController as! detailVC
            let indexPath = sender as! NSIndexPath
            viewController.theGoal = allGoals[indexPath.row]
            viewController.indexPath = indexPath
        }
    }
    
    
    @IBAction func saveSegue(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! detailVC
        var theGoal: Goal?
        if let indexPath = controller.indexPath {
            theGoal = allGoals[indexPath.row]
        } else {
            theGoal = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context) as? Goal
            theGoal?.cmp = false
        }
        do {
            theGoal?.ttl = controller.ttl.text
            theGoal?.date = controller.goalTime as NSDate
            try context.save()
//            print("success to save:\(String(describing: theGoal))")
        } catch {
            print("Failure to save: \(error)")
        }
        
        fetchAllGoals()
//        diffGoals()
        tableView.reloadData()
        print ("inside save unwind")
    }

    @IBAction func cancelSegue(_ segue: UIStoryboardSegue) {
        print ("inside cancel unwind")
    }
    @IBAction func doneSegue(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! settingVC
        notshowcmp = controller.set
        
        fetchAllGoals()
        tableView.reloadData()
//        print ("inside done unwind")
    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllGoals()
//        diffGoals()
    }


   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let formatter = DateFormatter()
        formatter.dateStyle = .short
//        var data = [Goal]()
//        if indexPath.section == 0 {
//            data = incomGoals
//        } else {
//            data = cmpGoals
//        }
        let GoalTime = formatter.string(from: allGoals[indexPath.row].date! as Date)
        cell.textLabel?.text = GoalTime
        cell.detailTextLabel?.text = allGoals[indexPath.row].ttl
        if allGoals[indexPath.row].cmp {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGoals.count
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style:.default, title:"EDIT"){(action, indext) in
            self.performSegue(withIdentifier: "editSegue", sender: indexPath)
//            print ("edit selected")
        }
        editAction.backgroundColor = UIColor.blue
        let deleteAction = UITableViewRowAction(style:.destructive, title:"DELETE"){(action, indext) in
            let alertController = UIAlertController(title: "Warning", message: "Remove Item?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                print ("cancel seleted")
            }
            alertController.addAction(cancelAction)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { action in
                var deleteGoal: Goal?
                deleteGoal = self.allGoals[indexPath.row]
//                if indexPath.section == 0 {
//                    deleteGoal = incomGoals.remove(at: indexPath.row)
//                } else {
//                    deleteGoal = cmpGoals.remove(at: indexPath.row)
//                }
                self.context.delete(deleteGoal!)
                do {
                    try self.context.save()
                    print("\(String(describing: deleteGoal)) deleted")
                } catch {
                    print("Error in deleting \(String(describing: deleteGoal))")
                }
//                tableView.deleteRows(at: [indexPath], with: .fade)
                self.fetchAllGoals()
//                diffGoals()
                tableView.reloadData()

            }
            alertController.addAction(yesAction)
            
            self.present(alertController, animated: true) {
                // ...
            }
//            print ("delete selected")
        }
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction, editAction]
    }

    
}
