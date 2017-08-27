//
//  SKLabel.swift
//  Superkart
//
//  Created by Alfredo Luco on 27-08-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit

class SKLabel: UILabel {

    //MARK: - Enums
    enum labelColor: Int {
        case yellow
    }
    
    //MARK: - Awake From NIB
    override func awakeFromNib() {
        super.awakeFromNib()
        switch colorAdapter {
        case .yellow:
            self.textColor = SKColors().main_yellow
            break
        }
    }
    
    //MARK: - Adapters
    var colorAdapter: labelColor = .yellow
    
    //MARK: - IBInspectables
    @IBInspectable var colorText: Int{
        get{
            return self.colorAdapter.rawValue
        }
        set(newValue){
            self.colorAdapter = labelColor(rawValue: newValue) ?? .yellow
        }
    }
    

}
