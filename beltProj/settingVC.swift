//
//  settingVC.swift
//  beltProj
//
//  Created by Lu Yu on 7/25/17.
//  Copyright © 2017 Lu Yu. All rights reserved.
//

import Foundation
import UIKit

class settingVC: UIViewController {
    var set:Bool = false
    @IBOutlet weak var thSwitch: UISwitch!
    @IBAction func onOffSwitch(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if thSwitch.isOn {
            set = true
            userDefaults.set( true, forKey: "notshowcmp")
//            print("userdefault is",userDefaults.value(forKey: "notshowcmp"))
            print("set is",set)
            
        } else {
            set = false
            userDefaults.set( false, forKey: "notshowcmp")
            
            print("set is",set)
//            print("userdefault is",userDefaults.value(forKey: "notshowcmp"))
        }
    }
}

////To save the string
//let userDefaults = UserDefaults.standard
//userDefaults.set( "String", forKey: "Key")
//
////To retrieve from the key
//let userDefaults = UserDefaults.standard
//let value  = userDefaults.string(forKey: "Key")
//print(value)
