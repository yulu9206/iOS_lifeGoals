//
//  ViewController.swift
//  beltProj
//
//  Created by Lu Yu on 7/25/17.
//  Copyright © 2017 Lu Yu. All rights reserved.
//

import UIKit

class detailVC: UIViewController {
    var indexPath: NSIndexPath?
    var theGoal: Goal?
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var ttl: UITextField!
    var goalTime = Date()
//
//    @IBOutlet weak var ttl: UITextField!
//    @IBOutlet weak var info: UITextField!
//    @IBOutlet weak var time: UIDatePicker!
//    @IBOutlet weak var cancelButton: UIButton!
//    @IBOutlet weak var saveButton: UIButton!
//    @IBOutlet weak var Button: UIButton!
//    
    func populateGoal() {
        if let Goal = theGoal {
            ttl.text = Goal.ttl
            date.date = (Goal.date!) as Date
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        populateGoal()
        // Do any additional setup after loading the view, typically from a nib.
    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    @IBAction func timeChange(_ sender: UIDatePicker) {
        goalTime = sender.date
        print (goalTime)
        
    }


}

