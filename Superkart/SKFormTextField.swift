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
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15.0, height: 40.0))
        self.leftViewMode = .always
    }

}
