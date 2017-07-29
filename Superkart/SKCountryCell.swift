//
//  SKCountryCell.swift
//  Superkart
//
//  Created by Alfredo Luco on 29-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit

class SKCountryCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var countryImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

}
