//
//  Item.swift
//  Superkart
//
//  Created by Alfredo Luco on 26-03-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    //MARK: - Properties
    private dynamic var id: Int = 0
    public dynamic var name: String = ""
    public dynamic var cost: Int = 0
    
    //MARK: - Init
    convenience init(withId: Int, withName: String, withCost: Int) {
        self.init()
        self.id = withId
        self.name = withName
        self.cost = withCost
    }
    
    //MARK: - Methods
    public func getID()->Int{
        return self.id
    }
    
}
