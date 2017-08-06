//
//  PaymentManager.swift
//  Superkart
//
//  Created by Alfredo Luco on 29-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

class PaymentManager {
    
    //MARK: - Singleton
    class var sharedInstance: PaymentManager {
        struct Static{
            static let instance = PaymentManager()
        }
        return Static.instance
    }
    
    //MARK: - Add Credit Card
    
    public func addCreditCard(payment: Payment){
        
        do {
            let realm = try Realm()
            
            do {
                try realm.write {
                    realm.add(payment, update: true)
                }
            } catch let error as NSError {
                print(error)
                return
            }
            
        } catch let error as NSError {
            print(error)
            return
        }
    }
    
    public func findData(predicate: NSPredicate?)->[Payment]?{
        
        do {
            let realm = try Realm()
            
            return predicate != nil ? Array(realm.objects(Payment.self).filter(predicate!)) : Array(realm.objects(Payment.self))
            
        } catch let error as NSError {
            print(error)
            return nil
        }
        
    }
    
    public func removeCard(payment: Payment){
        
        do {
            let realm = try Realm()
            
            do {
                try realm.write {
                    realm.delete(payment)
                }
            } catch let error as NSError {
                print(error)
                return
            }
            
        } catch let error as NSError {
            print(error)
            return
        }
        
    }
    
    //MARK: - Find Credit Card
    
    public func findCreditCard(filter: NSPredicate?)->Payment?{
        do {
            let realm = try Realm()
            return filter != nil ? realm.objects(Payment.self).filter(filter!).first : realm.objects(Payment.self).first
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    //MARK: - Pay shopping kart
    
    public func payShoppingKart(amount: Int, token: String, success: @escaping ()->Void, failure: @escaping (_ error: NSError)->Void){
        
        let params : [String : Any] = [
            "stripeToken" : token,
            "amount" : amount,
            "currency" : "clp",
            "description" : "stripe test"
        ]
        
        Alamofire.request(URLsManager.Router.payShoppingKart(parameters: params)).validate(statusCode: 200..<300).responseJSON(completionHandler: { response in
            
            print(response.result.value as Any)
            
            if(response.response?.statusCode == 200){
                success()
            }else{
                failure(response.result.error! as NSError)
            }
            
        })
        
    }
    
}
