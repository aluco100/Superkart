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
    
    public func hasItem(item: Item)->Bool{
        let realm = try! Realm()
        let list = realm.objects(ShoppingList.self).first!
        for i in list.items{
            if(i.getID() == item.getID()){
                return true
            }
        }
        return false
    }
    
    //MARK: - Add Item to list
    public func addAddItemToShoppingList(item: Item){
        
        do{
            let realm = try Realm()
            
            do{
                if let list = realm.objects(ShoppingList.self).first{
                    try realm.write {
                        list.items.append(item)
                        realm.add(list, update: true)
                    }
                }else{
                    let list = ShoppingList()
                    
                    try realm.write {
                        list.items.append(item)
                        realm.add(list, update: true)
                    }
                    
                }
            }catch let error as NSError{
                print(error)
            }
            
        }catch let error as NSError{
            print(error)
        }
        
    }
    
    public func removeItemToShoppingList(item: Item){
        
        do{
            let realm = try Realm()
            
            if let list = realm.objects(ShoppingList.self).first{
                
                for (index, element) in list.items.enumerated(){
                    if(element.getID() == item.getID()){
                        do{
                            try realm.write {
                                list.items.remove(at: index)
                                realm.add(list, update: true)
                            }
                        }catch let error as NSError{
                            print(error)
                        }
                        break
                    }
                }
                
            }
            
        }catch let error as NSError{
            print(error)
        }
        
    }
    
}
