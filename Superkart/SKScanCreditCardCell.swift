//
//  SKScanCreditCardCell.swift
//  Superkart
//
//  Created by Alfredo Luco on 29-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import FontAwesomeKit

protocol SKScanCreditDelegate: class {
    func didScan()
}

class SKScanCreditCardCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var firstLayerView: UIView!
    @IBOutlet weak var secondLayerView: UIView!
    @IBOutlet weak var creditCardImageView: UIImageView!
    
    weak var delegate: SKScanCreditDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = SKColors().backgroundColor
        self.firstLayerView.backgroundColor = UIColor.clear
        self.firstLayerView.layer.cornerRadius = 4.0
        self.firstLayerView.layer.borderWidth = 1.0
        self.firstLayerView.layer.borderColor = SKColors().navColor.cgColor
        self.secondLayerView.backgroundColor = UIColor.clear
        self.secondLayerView.layer.cornerRadius = 4.0
        self.secondLayerView.layer.borderWidth = 1.0
        self.secondLayerView.layer.borderColor = SKColors().navColor.cgColor
        
        let creditCard = FAKFontAwesome.creditCardIcon(withSize: self.creditCardImageView.frame.size.height)
        creditCard?.setAttributes([NSForegroundColorAttributeName : SKColors().alternativeColor])
        let size = CGSize(width: (self.creditCardImageView.frame.size.width), height: (self.creditCardImageView.frame.size.height))
        self.creditCardImageView.image = creditCard?.image(with: size)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didToogle))
        self.creditCardImageView.addGestureRecognizer(tapGesture)
        self.creditCardImageView.isUserInteractionEnabled = true
        
    }
    
    func didToogle(){
        if(self.delegate != nil){
            self.delegate?.didScan()
        }
    }
}
