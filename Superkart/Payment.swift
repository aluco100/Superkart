//
//  Payment.swift
//  Superkart
//
//  Created by Alfredo Luco on 29-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import Foundation
import RealmSwift

class Payment: Object {
    
    //MARK: - Properties
    private dynamic var card_number: String = ""
    public dynamic var expiration_month: Int = 0
    public dynamic var expiration_year: Int = 0
    public dynamic var cvv: String = ""
    public dynamic var cardType: Int = 0
    public dynamic var cardHolderNumber: String = ""
    
    //MARK: - Init
    convenience init(cardNumber: String,cardHolderNumber: String, expirationMonth: Int, expirationYear: Int, CVV: String, cardType: Int) {
        self.init()
        self.card_number = cardNumber
        self.expiration_month = expirationMonth
        self.expiration_year = expirationYear
        self.cvv = CVV
        self.cardType = cardType
        self.cardHolderNumber = cardHolderNumber
    }
    
    //MARK: - Realm methods
    
    override static func primaryKey()->String?{
        return "card_number"
    }
    
    //MARK: - Methods
    public func getCreditCardNumber()->String{
        return self.card_number
    }
    
}
