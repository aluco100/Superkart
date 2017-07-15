//
//  ItemManager.swift
//  Superkart
//
//  Created by Alfredo Luco on 10-06-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import AlamofireObjectMapper

class ItemManager {
    
    //MARK: - Singleton
    class var sharedInstance: ItemManager {
        
        struct Static {
            
            static let instance = ItemManager()
            
        }
        
        return Static.instance
    }
    
    //MARK: - Get Items
    
    public func updateItems(success: @escaping () ->Void, failure: @escaping (_ error: NSError)->Void){
        
    
        Alamofire.request(URLsManager.Router.getItems(parameters: nil)).responseArray(completionHandler: {
            (response: DataResponse<[Item]>) in
            
            if let array = response.result.value{
                
                let realm = try! Realm()
                
                for item in array{
                    
                    try! realm.write {
                        realm.add(item, update: true)
                    }
                    
                }
                
                success()
                
            }else{
                print(response.response as Any)
                failure(response.result.error! as NSError)
            }
            
        })
        
    }
    
    public func getItem(barcode: String, success: @escaping ()->Void, failure: @escaping (_ error: NSError)->Void){
        
        let params = [
            "barcode" : barcode
        ]
        
        Alamofire.request(URLsManager.Router.getItem(parameters: params)).responseObject(completionHandler: {
            (response: DataResponse<Item>) in
            
            if let item = response.result.value{
                
                let realm = try! Realm()
                
                try! realm.write {
                    realm.add(item, update: true)
                }
                success()
            }else{
                print(response.response as Any)
                failure(response.result.error! as NSError)
            }
            
        })
        
    }
    
    //MARK: - Find Item
    
    public func findItem(barcode: String)->Item?{
        
        let realm = try! Realm()
        
        if let item = realm.objects(Item.self).filter("barcode = \(barcode)").first{
            return item
        }
        return nil
    }
    
    public func findItems(filter: NSPredicate?)->[Item]?{
        do{
            let realm =  try Realm()
            
            return filter != nil ? Array(realm.objects(Item.self).filter(filter!)) : Array(realm.objects(Item.self))
            
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    
    public func findItemsToBuy()->[Item]{
        let realm = try! Realm()
        
        return Array(realm.objects(Item.self).filter("quantity>0"))
        
    }
    
    public func updateItem(item: Item, quantity: Int?){
        let realm = try! Realm()
        
        try! realm.write {
            if(quantity != nil){
                item.quantity = quantity!
            }
            realm.add(item, update: true)
        }
        
    }
    
}
