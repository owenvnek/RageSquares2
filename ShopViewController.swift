//
//  Shop.swift
//  Rage Squares 2
//
//  Created by Owen Vnek on 7/3/18.
//  Copyright © 2018 Nio. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ShopViewController: UICollectionViewController {
    
    private var selected_shop_item: ShopItem!
    
    override func viewDidLoad() {
        collectionView?.reloadData()
        ShopLoader.shop.shop = self
    }
    
    func reload() {
        collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ShopCell
        let item: ShopItem
        let pack: String
        let index: Int
        pack = ShopLoader.shop.unlocked_packs[indexPath.section]
        index = indexPath.row
        item = ShopLoader.shop.get(pack: pack, index: index)!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shop_cell", for: indexPath) as! ShopCell
        cell.image.image = item.image
        cell.name.text = item.id
        if item.purchased {
            cell.cost.text = "Purchased"
        } else {
            cell.cost.text = "\(item.cost)"
        }
        if item.selected {
            cell.selected_indicator.isHidden = false
        } else {
            cell.selected_indicator.isHidden = true
        }
        cell.sendSubview(toBack: cell.selected_indicator)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let item: ShopItem
        let pack: String
        let index: Int
        pack = ShopLoader.shop.unlocked_packs[indexPath.section]
        index = indexPath.row
        item = ShopLoader.shop.get(pack: pack, index: index)!
        if item.purchased {
            ShopLoader.shop.unselect()
            UserDefaults.standard.set(ShopLoader.shop.unlocked_packs[indexPath.section], forKey: "selected_pack")
            UserDefaults.standard.set(indexPath.row, forKey: "selected_skin")
            performSegue(withIdentifier: "go_back", sender: self)
            item.selected = true
        } else {
            selected_shop_item = item
            performSegue(withIdentifier: "purchase_screen", sender: self)
        }
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pack: String
        pack = ShopLoader.shop.unlocked_packs[section]
        return ShopLoader.shop.get_count(pack: pack)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ShopLoader.shop.get_unlocked_pack_count()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc: PurchaseViewController = segue.destination as? PurchaseViewController {
            vc.shop_item = selected_shop_item
        }
    }
    
}
