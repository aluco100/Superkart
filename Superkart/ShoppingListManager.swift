//
//  ShoppingListManager.swift
//  Superkart
//
//  Created by Alfredo Luco on 15-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingListManager {
    
    //MARK: - Singleton
    class var sharedInstance: ShoppingListManager{
        struct Static{
            static let instance = ShoppingListManager()
        }
        return Static.instance
    }
    
    //MARK: - find items
    public func findShoppingListItems()->[Item]?{
        
        do{
            let realm = try Realm()
            
            if let items = realm.objects(ShoppingList.self).first?.items{
                return Array(items)
            }
            
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    
    //MARK: - Add Item to list
    public func addAddItemToShoppingList(item: Item){
        
    }
    
}
