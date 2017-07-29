//
//  PaymentManager.swift
//  Superkart
//
//  Created by Alfredo Luco on 29-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift

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
    
}
