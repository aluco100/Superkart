//
//  User.swift
//  Superkart
//
//  Created by Alfredo Luco on 26-03-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class User: Object,Mappable {
    
    //MARK: - Properties
    private dynamic var id: Int = 0
    public dynamic var mail: String = ""
    private dynamic var password: String = ""
    public dynamic var shoppingList: ShoppingList? = nil
    
    //MARK: - Init
    required convenience init?(map: Map) {
        self.init()
    }
    
    //MARK: - Mapping
    func mapping(map: Map) {
        id<-map["idUser"]
        mail<-map["email"]
        password<-map["password"]
    }
        
    //MARK: - Realm Methods
    override static func primaryKey()->String?{
        return "id"
    }
    
    //MARK: - Methods
    public func getID()->Int{
        return self.id
    }
    
}
