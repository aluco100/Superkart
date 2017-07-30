//
//  SKShoppingListCell.swift
//  Superkart
//
//  Created by Alfredo Luco on 15-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import FontAwesomeKit

class SKShoppingListCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Global Variables
    var item: Item!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        let image = FAKMaterialIcons.shoppingCartIcon(withSize: 30.0)
        image?.setAttributes([NSForegroundColorAttributeName: UIColor.white])
        self.iconImageView.image = image?.image(with: CGSize(width: 30.0, height: 30.0))
        self.backgroundColor = UIColor.clear
        self.titleLabel.textColor = UIColor.white
    }
    
    func setup(){
        if(self.item != nil){
            self.titleLabel.text = self.item.name
            if(self.item.quantity > 0){
                //code for stash label
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(String(describing: self.titleLabel.text!))")
                attributeString.addAttribute(NSBaselineOffsetAttributeName, value: 0, range: NSMakeRange(0, attributeString.length))
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
//                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                self.titleLabel.attributedText = attributeString
            }
        }
    }
}
