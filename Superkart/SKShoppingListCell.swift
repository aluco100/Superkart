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
        self.iconImageView.image = image?.image(with: CGSize(width: 30.0, height: 30.0))
        
    }
    
    func setup(){
        if(self.item != nil){
            self.titleLabel.text = self.item.name
        }
    }
}
