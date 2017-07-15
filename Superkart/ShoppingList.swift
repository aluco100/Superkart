//
//  ShoppingList.swift
//  Superkart
//
//  Created by Alfredo Luco on 26-03-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    
    //MARK: - Properties
    private dynamic var id: Int = 0
    public var items: List<Item> = List<Item>()
    
    //MARK: - Init
//    required convenience init() {
//        self.init()
//    }
    
    override static func primaryKey()->String?{
        return "id"
    }
    
    //MARK: - Methods
    public func getID()->Int{
        return self.id
    }
    
}
