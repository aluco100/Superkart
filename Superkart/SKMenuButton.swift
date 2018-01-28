//
//  SKMenuButton.swift
//  Superkart
//
//  Created by Alfredo Luco on 15-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import FontAwesomeKit

class SKMenuButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        let menu = FAKMaterialIcons.menuIcon(withSize: 30.0)
        menu!.addAttribute(NSAttributedStringKey.foregroundColor.rawValue, value: UIColor.white)
        self.setImage(menu?.image(with: CGSize(width: 30.0, height: 30.0)), for: .normal)
        self.setTitle("", for: .normal)
        self.tintColor = UIColor.white
    }

}
