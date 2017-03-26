//
//  User.swift
//  Superkart
//
//  Created by Alfredo Luco on 26-03-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    //MARK: - Properties
    private dynamic var id: Int = 0
    public dynamic var mail: String = ""
    private dynamic var password: String = ""
    public dynamic var shoppingList: ShoppingList? = nil
    
    //MARK: - Init
    convenience init(withId: Int, withMail: String, withPassword: String, withShopping: ShoppingList){
        //convenience init of super class
        self.init()
        //init 
        self.id = withId
        self.mail = withMail
        self.password = withPassword
        self.shoppingList = withShopping
    }
    
    //MARK: - Methods
    public func getID()->Int{
        return self.id
    }
    
}
