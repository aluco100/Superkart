//
//  UserManager.swift
//  Superkart
//
//  Created by Alfredo Luco on 30-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import AlamofireObjectMapper

class UserManager {
    
    //MARK: - Singleton
    class var sharedInstance: UserManager{
        struct Static{
            static let instance = UserManager()
        }
        return Static.instance
    }
    
    //MARK: - Current User
    public func currentUser()->User?{
        
        do {
            
            let realm = try Realm()
            return realm.objects(User.self).first
            
        } catch let error as NSError {
            
            print(error)
            return nil
            
        }
        
    }
    
    //MARK: - Register User
    public func registerUser(email: String, password: String, success: @escaping ()->Void, failure: @escaping (_ error: NSError)->Void){
        
        let params = [
            "email" : email,
            "password" : password
        ]
        
        Alamofire.request(URLsManager.Router.registerUser(parameters: params)).responseData(completionHandler: {
            response in
            
            if(response.response?.statusCode == 200){
                success()
            }else{
                failure(response.result.error! as NSError)
            }
            
        })
        
    }
    
    //MARK: - Login User
    public func loginUser(email: String, password: String, success: @escaping ()->Void, failure: @escaping (_ error: NSError)->Void){
        
        let params = [
            "email" : email,
            "password" : password
        ]
        
        Alamofire.request(URLsManager.Router.loginUser(parameters: params)).responseObject(completionHandler: {
            (response: DataResponse<User>) in
            
            if let user = response.result.value{
                
                do{
                    let realm = try Realm()
                    
                    do{
                        try realm.write {
                            realm.add(user, update: true)
                        }
                        success()
                    }catch let error as NSError{
                        print(error)
                        failure(error)
                    }
                    
                }catch let error as NSError{
                    print(error)
                    failure(error)
                }
                
            }
            
        })
        
    }
    
    //MARK: - Logout
    public func logout(){
        
        do {
            let realm = try Realm()
            
            do {
                try realm.write {
                    realm.delete(realm.objects(User.self))
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
    
}
