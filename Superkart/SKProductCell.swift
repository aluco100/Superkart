//
//  SKProductCell.swift
//  Superkart
//
//  Created by Alfredo Luco on 17-06-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import FontAwesomeKit

class SKProductCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productQuantityStepper: UIStepper!
    
    //MARK: - Global Variables
    var item: Item!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.productNameLabel.textColor = UIColor.white
        self.productPriceLabel.textColor = UIColor.white
        self.productQuantityLabel.textColor = UIColor.white
        self.productQuantityStepper.tintColor = UIColor.white
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        let shoppingBasket = FAKFontAwesome.shoppingBasketIcon(withSize: 50.0)
        shoppingBasket?.setAttributes([NSForegroundColorAttributeName: UIColor.white])
        self.iconImageView.image = shoppingBasket?.image(with: CGSize(width: 50.0, height: 50.0))
        self.productQuantityLabel.text = "Cantidad: 1"
        self.productQuantityStepper.value = 1
        self.productQuantityStepper.addTarget(self, action: #selector(self.quantityProducts(sender:)), for: .touchUpInside)
    }
    
    func setup(){
        
        if (self.item != nil) {
            self.productNameLabel.text = self.item.name
            self.productPriceLabel.text = "\(SKNumberFormatter().currencyStyle(number: self.item.cost))"
        }
        
    }
    
    func quantityProducts(sender: UIStepper){
        self.productQuantityLabel.text = "Cantidad: \(Int(sender.value))"
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            let nc = NotificationCenter.default
            nc.post(name: NSNotification.Name(rawValue: "updateItemList"), object: nil, userInfo: nil)
        })
        CATransaction.commit()
    }
}
