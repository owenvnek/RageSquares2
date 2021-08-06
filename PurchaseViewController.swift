//
//  PurchaseViewController.swift
//  Rage Squares 2
//
//  Created by Owen Vnek on 7/3/18.
//  Copyright © 2018 Nio. All rights reserved.
//

import Foundation
import UIKit

class PurchaseViewController: UIViewController {
    
    var shop_item: ShopItem!
    private var triangles: Int!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var cost_label: UILabel!
    @IBOutlet weak var triangles_label: UILabel!
    
    override func viewDidLoad() {
        image.image = shop_item.image
        name_label.text = shop_item.id
        cost_label.text = "Cost: \(shop_item.cost)"
        triangles = UserDefaults.standard.value(forKey: "triangles")! as! Int
        triangles_label.text = "Trangles: \(triangles!)"
    }
    
    @IBAction func purchase(_ sender: Any) {
        if triangles >= shop_item.cost {
            UserDefaults.standard.set(triangles - shop_item.cost, forKey: "triangles")
            ShopLoader.shop.buy(pack: shop_item.pack, index: shop_item.index)
            performSegue(withIdentifier: "purchased", sender: self)
        } else {
            let alertController = UIAlertController(title: "Rage Squares 2", message:
                "You cannot afford that item.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc: ShopViewController = segue.destination as? ShopViewController {
            vc.reload()
        }
    }
    
}
