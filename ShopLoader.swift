//
//  ShopLoader.swift
//  Rage Squares 2
//
//  Created by Owen Vnek on 7/5/18.
//  Copyright © 2018 Nio. All rights reserved.
//

import Foundation
import SpriteKit

class ShopLoader {
    
    private var shop_items: [String: [ShopItem]]
    private var unlocked: [String: Bool]!
    var unlocked_packs: [String]
    var shop: ShopViewController!
    public static let packs: [String] = ["standard", "owen", "leo", "john", "lukas"]
    public static let shop: ShopLoader = ShopLoader()
    
    private init() {
        shop_items = [:]
        unlocked_packs = []
        for pack: String in ShopLoader.packs {
            shop_items[pack] = []
        }
        create_shop()
        reload()
        select()
    }
    
    private func create_shop() {
        create_standard_pack()
        create_owen_pack()
        create_john_pack()
        create_lukas_pack()
        create_leo_pack()
    }
    
    private func create_standard_pack() {
        var items: [ShopItem]
        items = []
        items.append(ShopItem(name: "Square", image_name: "square", cost: 0))
        items.append(ShopItem(name: "Ninja", image_name: "green_ninja", cost: 2000000))
        items.append(ShopItem(name: "Assassin", image_name: "red_assassin", cost: 4000000))
        items.append(ShopItem(name: "Radioactive", image_name: "radioactive", cost: 1000000))
        items.append(ShopItem(name: "Spooker", image_name: "spooker", cost: 4000000))
        items.append(ShopItem(name: "Feline", image_name: "feline", cost: 80000))
        items.append(ShopItem(name: "Volcano", image_name: "volcano", cost: 40000))
        items.append(ShopItem(name: "Sea Creature", image_name: "sea_creature", cost: 350000))
        for index: Int in 0..<items.count {
            items[index].pack = "standard"
            items[index].index = index
        }
        items[0].purchased = true
        shop_items["standard"] = items
    }
    
    private func create_owen_pack() {
        var items: [ShopItem]
        items = []
        items.append(ShopItem(name: "JG Wentworth", image_name: "wentworth", cost: 50000))
        items.append(ShopItem(name: "Len Berman", image_name: "len_berman", cost: 100000))
        items.append(ShopItem(name: "Todd Schnitt", image_name: "schnitt", cost: 200000))
        items.append(ShopItem(name: "Cure Todd", image_name: "cure_todd", cost: 75000))
        items.append(ShopItem(name: "John Thomas", image_name: "john_thomas", cost: 250000))
        items.append(ShopItem(name: "\"Hey Leo\"", image_name: "hey_leo2", cost: 10000))
        items.append(ShopItem(name: "Dom", image_name: "dom", cost: 20000))
        items.append(ShopItem(name: "Dr. Phil", image_name: "dr_phil", cost: 10000000))
        items.append(ShopItem(name: "Vic Dibitetto", image_name: "vic_dibitetto", cost: 230000))
        for index: Int in 0..<items.count {
            items[index].pack = "owen"
            items[index].index = index
        }
        shop_items["owen"] = items
    }
    
    private func create_john_pack() {
        var items: [ShopItem]
        items = []
        items.append(ShopItem(name: "Choking Guy", image_name: "choking_guy", cost: 10000))
        items.append(ShopItem(name: "Incredible Fella", image_name: "incredible_fella2", cost: 1000000))
        items.append(ShopItem(name: "Major World", image_name: "major_world", cost: 2000000))
        items.append(ShopItem(name: "Kevin Edwards", image_name: "where_the_milk_at", cost: 30000))
        items.append(ShopItem(name: "Mark Malone", image_name: "mark_malone", cost: 5000))
        items.append(ShopItem(name: "Incredibler Fella", image_name: "incredibler_fella", cost: 3000000))
        items.append(ShopItem(name: "Jeff", image_name: "jeff_wlah", cost: 15000))
        items.append(ShopItem(name: "Swolopoly", image_name: "swolopoly", cost: 80000))
        items.append(ShopItem(name: "Ahumanonfire", image_name: "ahumanonfire", cost: 4500000))
        for index: Int in 0..<items.count {
            items[index].pack = "john"
            items[index].index = index
        }
        shop_items["john"] = items
    }
    
    private func create_lukas_pack() {
        var items: [ShopItem]
        items = []
        items.append(ShopItem(name: "Frank The Tank", image_name: "frank_the_tank", cost: 1000000))
        items.append(ShopItem(name: "Mets", image_name: "mets", cost: 10000))
        items.append(ShopItem(name: "Dolphins", image_name: "dolphins", cost: 180000))
        items.append(ShopItem(name: "Minkah Fitzpatrick", image_name: "minkah", cost: 150000))
        items.append(ShopItem(name: "Albert Wilson", image_name: "albert_wilson", cost: 80000))
        for index: Int in 0..<items.count {
            items[index].pack = "lukas"
            items[index].index = index
        }
        shop_items["lukas"] = items
    }
    
    private func create_leo_pack() {
        var items: [ShopItem]
        items = []
        items.append(ShopItem(name: "Jack A Boy", image_name: "jack", cost: 400000))
        items.append(ShopItem(name: "Mexican Trump", image_name: "mexican_trump", cost: 500000))
        items.append(ShopItem(name: "Pewdiepie", image_name: "pewdiepie", cost: 2000))
        items.append(ShopItem(name: "Jeff", image_name: "jeff", cost: 5000000))
        for index: Int in 0..<items.count {
            items[index].pack = "leo"
            items[index].index = index
        }
        shop_items["leo"] = items
    }
    
    func reload() {
        load_unlocked()
        load_bought()
        choose_unlocked_packs()
    }
    
    private func load_unlocked() {
        unlocked = UserDefaults.standard.value(forKey: "skins_unlocked") as? [String : Bool]
        if unlocked == nil {
            unlocked = [:]
            unlocked["standard"] = true
            save()
            unlocked = UserDefaults.standard.value(forKey: "skins_unlocked") as! [String : Bool]
            shop_items["standard"]![0].purchased = true
        }
    }
    
    func did_unlock(pack: String) -> Bool {
        let got: Bool?
        got = unlocked[pack]
        if got == nil {
            return false
        }
        return got!
    }
    
    private func load_bought() {
        for pack_name: String in ShopLoader.packs {
            let bought: [Bool]?
            let count: Int
            bought = UserDefaults.standard.value(forKey: "did_buy_\(pack_name)") as? [Bool]
            if bought != nil {
                count = (shop_items[pack_name]?.count)!
                for index: Int in 0..<count {
                    if index < (bought?.count)! {
                        shop_items[pack_name]![index].purchased = bought![index]
                    }
                }
            }
        }
    }
    
    func save() {
        save_unlocked()
        save_bought()
    }
    
    private func save_unlocked() {
        for pack: String in ShopLoader.packs {
            if unlocked[pack] == nil {
                unlocked[pack] = false
            }
        }
        UserDefaults.standard.set(unlocked, forKey: "skins_unlocked")
    }
    
    private func save_bought() {
        for pack: String in ShopLoader.packs {
            var purchased: [Bool]
            purchased = []
            for item: ShopItem in shop_items[pack]! {
                purchased.append(item.purchased)
            }
            UserDefaults.standard.set(purchased, forKey: "did_buy_\(pack)")
        }
    }
    
    private func choose_unlocked_packs() {
        unlocked_packs = []
        for pack: String in ShopLoader.packs {
            if unlocked[pack] != nil {
                if unlocked[pack]! {
                    unlocked_packs.append(pack)
                }
            }
        }
    }
    
    func get_unlocked_pack_count() -> Int {
        return unlocked_packs.count
    }
    
    func unlock_pack(pack: String) {
        unlocked[pack] = true
        save()
        reload()
        if shop != nil {
            shop.collectionView?.reloadData()
        }
    }
    
    func buy(pack: String, index: Int) {
        shop_items[pack]![index].purchased = true
        save()
    }
    
    func get(pack: String, index: Int) -> ShopItem? {
        let count: Int
        count = shop_items[pack]!.count
        if index < count {
            return shop_items[pack]![index]
        } else {
            fatalError("Trying to get invalid shop item")
        }
    }
    
    func unselect() {
        let shop_item: ShopItem
        var selected_skin: Int?
        var selected_pack: String?
        selected_skin = UserDefaults.standard.value(forKey: "selected_skin") as? Int
        if selected_skin == nil {
            selected_skin = 0
        }
        selected_pack = UserDefaults.standard.value(forKey: "selected_pack") as? String
        if selected_pack == nil {
            selected_pack = "standard"
        }
        shop_item = ShopLoader.shop.get(pack: selected_pack!, index: selected_skin!)!
        shop_item.selected = false
    }
    
    private func select() {
        let shop_item: ShopItem
        var selected_skin: Int?
        var selected_pack: String?
        selected_skin = UserDefaults.standard.value(forKey: "selected_skin") as? Int
        if selected_skin == nil {
            selected_skin = 0
        }
        selected_pack = UserDefaults.standard.value(forKey: "selected_pack") as? String
        if selected_pack == nil {
            selected_pack = "standard"
        }
        shop_item = get(pack: selected_pack!, index: selected_skin!)!
        shop_item.selected = true
    }
    
    func get_count(pack: String) -> Int {
        return shop_items[pack]!.count
    }
    
}

class ShopItem {
    
    var image: UIImage
    var cost: Int
    var id: String
    var purchased: Bool
    var index: Int
    var pack: String
    var selected: Bool
    
    init(name: String, image_name: String, cost: Int) {
        id = name
        image = UIImage(named: image_name)!
        self.cost = cost
        purchased = false
        selected = false
        index = -1
        pack = "no pack"
    }
    
}

//TODO: fix bullet issue?, more skins, bg
