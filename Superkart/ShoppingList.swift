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
    convenience init(withId: Int, withItems: List<Item>) {
        self.init()
        self.id = withId
        self.items = withItems
    }
    
    //MARK: - Methods
    public func getID()->Int{
        return self.id
    }
    
}
