//
//  SKMenuItemTableViewCell.swift
//  Superkart
//
//  Created by Alfredo Luco on 10-06-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import FontAwesomeKit

class SKMenuItemTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Global variables
    var iconType: FAKFontAwesome!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Setup

    func setup(){
        
        self.contentView.backgroundColor = SKColors().navColor
        
        self.iconType.setAttributes([NSForegroundColorAttributeName: UIColor.white])
        self.iconImageView.image = self.iconType.image(with: CGSize(width: 30.0, height: 30.0))
        
        
        self.titleLabel.textColor = UIColor.white
        
    }
    
}
