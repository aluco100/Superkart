//
//  SKNumberFormatter.swift
//  Superkart
//
//  Created by Alfredo Luco on 17-06-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit

class SKNumberFormatter: NumberFormatter {

    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func currencyStyle(number: Int)->String{
        let numberFormatted = NSNumber(value: number)
        self.numberStyle = .currency
        return self.string(from: numberFormatted)!
    }
    
}
