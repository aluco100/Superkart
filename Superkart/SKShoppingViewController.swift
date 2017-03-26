//
//  SKShoppingViewController.swift
//  Superkart
//
//  Created by Alfredo Luco on 26-03-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import VCMaterialDesignIcons

class SKShoppingViewController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet var shoppingNavBar: UINavigationBar!
    @IBOutlet var shoppingConfigurations: UIButton!
    @IBOutlet var shoppingTakePhoto: UIButton!
    @IBOutlet var shoppingTableView: UITableView!
    @IBOutlet var shoppingTotalToPay: UILabel!
    @IBOutlet var shoppingPay: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setup(){
        //background color
        self.view.backgroundColor = SKColors().defaultColor
        
        //nav bar settings
        self.shoppingNavBar.backgroundColor = SKColors().defaultColor
        
        
        let config = VCMaterialDesignIcons.icon(withCode: "\(VCMaterialDesignIconCode().md_settings)", fontSize: 20.0)
        
        config!.addAttribute(NSForegroundColorAttributeName, value: UIColor.white)
        
        self.shoppingConfigurations.setImage(config!.image(), for: .normal)
        self.shoppingConfigurations.titleLabel!.text = ""
        
        let photo = VCMaterialDesignIcons.icon(withCode: "\(VCMaterialDesignIconCode().md_camera)", fontSize: 20.0)
        
        photo!.addAttribute(NSForegroundColorAttributeName, value: UIColor.white)
        
        self.shoppingTakePhoto.setImage(photo!.image(), for: .normal)
        self.shoppingTakePhoto.titleLabel!.text = ""
        
        //TableView Config
        
        self.shoppingTableView.backgroundColor = SKColors().defaultColor
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
