//
//  Item.swift
//  Superkart
//
//  Created by Alfredo Luco on 26-03-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class Item: Object,Mappable  {
    
    //MARK: - Properties
    private dynamic var id: Int = 0
    public dynamic var name: String = ""
    public dynamic var cost: Int = 0
    public dynamic var barcode: Int = 0
    public dynamic var quantity: Int = 0
    
    //MARK: - Init
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    //MARK: - Mapping
    func mapping(map: Map) {
        id<-map["idItem"]
        name<-map["name"]
        cost<-map["price"]
        barcode<-map["barcode"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //MARK: - Methods
    public func getID()->Int{
        return self.id
    }
    
}
