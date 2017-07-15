//
//  SKShoppingListViewController.swift
//  Superkart
//
//  Created by Alfredo Luco on 15-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import SearchTextField

class SKShoppingListViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var shoppingListTableView: UITableView!
    @IBOutlet weak var searchTextField: SearchTextField!
    
    //MARK: - Global Variables
    let itemManager: ItemManager = ItemManager.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.filterStrings(self.itemManager.findItemsToBuy().map({$0.name}))
        self.navigationController?.navigationBar.barTintColor = SKColors().navColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
