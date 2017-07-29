//
//  SKCreditCardCell.swift
//  Superkart
//
//  Created by Alfredo Luco on 29-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit

class SKCreditCardCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet weak var CVVTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.expirationDateTextField.isEnabled = false
        self.CVVTextField.isEnabled = false
        self.selectionStyle = .none
    }
    
    //MARK: - Setup
    func setup(payment: Payment){
        self.expirationDateTextField.text = "\(payment.expiration_month)/\(payment.expiration_year)"
        self.CVVTextField.text = payment.cvv
    }
}
