//
//  SKFormButton.swift
//  Superkart
//
//  Created by Alfredo Luco on 30-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import FontAwesomeKit

class SKFormButton: UIButton {

    //MARK: - Enums
    enum color: Int {
        case green
        case lightBlue
    }
    
    enum mode: Int {
        case register
        case login
    }
    
    //MARK: - Awake From NIB
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = UIColor.white
        self.layer.cornerRadius = 4.0
        
        switch colorAdapter {
        case .green:
            self.backgroundColor = SKColors().main_green
            break
        case .lightBlue:
            self.backgroundColor = SKColors().navColor
            break
        }
        
        switch modeAdapter {
        case .register:
            let icon = FAKFontAwesome.userIcon(withSize: 30.0)
            icon?.setAttributes([NSAttributedStringKey.foregroundColor : UIColor.white])
            self.setImage(icon?.image(with: CGSize(width: 30.0, height: 30.0)), for: .normal)
            break
        case .login:
            let icon = FAKFontAwesome.shoppingCartIcon(withSize: 30.0)
            icon?.setAttributes([NSAttributedStringKey.foregroundColor : UIColor.white])
            self.setImage(icon?.image(with: CGSize(width: 30.0, height: 30.0)), for: .normal)
            break
        }
        self.imageEdgeInsets.right = 16.0
    }
    
    //MARK: - Adapters
    var colorAdapter: color = .green
    var modeAdapter: mode = .register
    
    //MARK: - IBInspectables
    @IBInspectable var buttonColor: Int{
        get{
            return self.colorAdapter.rawValue
        }
        set(newValue){
            self.colorAdapter = color(rawValue: newValue) ?? .green
        }
    }
    
    @IBInspectable var buttonMode: Int{
        get{
            return self.modeAdapter.rawValue
        }
        set(newValue){
            self.modeAdapter = mode(rawValue: newValue) ?? .register
        }
    }

}
