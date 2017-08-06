//
//  SKCardCell.swift
//  Superkart
//
//  Created by Alfredo Luco on 05-08-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit


class SKCardCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.backgroundColor = SKColors().backgroundColor
        self.titleLabel.textColor = UIColor.white
    }
    
    func setup(payment: Payment){
        self.titleLabel.text = payment.cardHolderNumber
        switch payment.cardType {
        case CardIOCreditCardType.mastercard.rawValue:
            self.iconImageView.image = CardIOCreditCardInfo.logo(for: CardIOCreditCardType.mastercard)
            break
        case CardIOCreditCardType.visa.rawValue:
            self.iconImageView.image = CardIOCreditCardInfo.logo(for: CardIOCreditCardType.visa)
            break
        default:
            self.iconImageView.image = CardIOCreditCardInfo.logo(for: CardIOCreditCardType.ambiguous)
            break
        }
    }

}
