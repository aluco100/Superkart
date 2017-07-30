//
//  SKFormButton.swift
//  Superkart
//
//  Created by Alfredo Luco on 30-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit

class SKFormButton: UIButton {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4.0
        self.layer.borderColor = SKColors().backgroundColor.cgColor
        self.backgroundColor = SKColors().navColor
    }

}
