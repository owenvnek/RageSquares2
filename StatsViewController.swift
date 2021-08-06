//
//  StatsViewController.swift
//  Rage Squares 2
//
//  Created by Owen Vnek on 7/3/18.
//  Copyright © 2018 Nio. All rights reserved.
//

import Foundation
import UIKit

class StatsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var triangles: UILabel!
    @IBOutlet weak var high_score: UILabel!
    @IBOutlet weak var cheat_code_box: UITextField!
    
    override func viewDidLoad() {
        load_values()
        cheat_code_box.delegate = self
    }
    
    @IBAction func enter_cheat_code(_ sender: Any) {
        let code: String
        code = cheat_code_box.text!
        if code == "dr_phil" {
            let alertController = UIAlertController(title: "Rage Squares 2", message:
                "Owen's pack unlocked", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            ShopLoader.shop.unlock_pack(pack: "owen")
            present(alertController, animated: true, completion: nil)
        } else if code == "jj_pub" {
            let alertController = UIAlertController(title: "Rage Squares 2", message:
                "John's pack unlocked", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            ShopLoader.shop.unlock_pack(pack: "john")
            present(alertController, animated: true, completion: nil)
        } else if code == "tank1555" {
            let alertController = UIAlertController(title: "Rage Squares 2", message:
                "Lukas's pack unlocked", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            ShopLoader.shop.unlock_pack(pack: "lukas")
            present(alertController, animated: true, completion: nil)
        } else if code == "leoleoleo123" {
            let alertController = UIAlertController(title: "Rage Squares 2", message:
                "Leo's pack unlocked", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            ShopLoader.shop.unlock_pack(pack: "leo")
            present(alertController, animated: true, completion: nil)
        } else if code == "triangles_plz" {
            let alertController = UIAlertController(title: "Rage Squares 2", message:
                "You have been given 10000000 triangles", preferredStyle: UIAlertControllerStyle.alert)
            var triangles: Int?
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            triangles = UserDefaults.standard.value(forKey: "triangles") as? Int
            if triangles == nil {
                triangles = 0
            }
            triangles! += 10000000
            UserDefaults.standard.set(triangles, forKey: "triangles")
            load_values()
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Rage Squares 2", message:
                "Unknown code", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func load_values() {
        let hs: Int? = UserDefaults.standard.value(forKey: "high score") as? Int
        if let high_score_value = hs {
            high_score.text = "High Score: \(high_score_value)"
        } else {
            UserDefaults.standard.set(0, forKey: "high score")
            high_score.text = "High Score: 0"
        }
        let tri: Int? = UserDefaults.standard.value(forKey: "triangles") as? Int
        if let triangles_value = tri {
            triangles.text = "Triangles: \(triangles_value)"
        } else {
            UserDefaults.standard.set(0, forKey: "triangles")
            triangles.text = "Triangles: 0"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cheat_code_box.resignFirstResponder()
        return false
    }
    
}
