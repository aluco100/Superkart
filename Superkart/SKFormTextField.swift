//
//  SKFormTextField.swift
//  Superkart
//
//  Created by Alfredo Luco on 30-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit

class SKFormTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4.0
        self.layer.borderColor = SKColors().navColor.cgColor
        self.backgroundColor = UIColor.white
    }

}
