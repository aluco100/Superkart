//
//  SKShoppingListViewController.swift
//  Superkart
//
//  Created by Alfredo Luco on 15-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import SearchTextField

class SKShoppingListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: - IBOutlets
    @IBOutlet weak var shoppingListTableView: UITableView!
    @IBOutlet weak var searchTextField: SearchTextField!
    
    //MARK: - Global Variables
    let itemManager: ItemManager = ItemManager.sharedInstance
    let shoppingListManager: ShoppingListManager = ShoppingListManager.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.filterStrings(self.itemManager.findItemsToBuy().map({$0.name}))
        self.navigationController?.navigationBar.barTintColor = SKColors().navColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.view.backgroundColor = SKColors().backgroundColor
        self.shoppingListTableView.backgroundColor = SKColors().backgroundColor
        self.shoppingListTableView.delegate = self
        self.shoppingListTableView.dataSource = self
        self.shoppingListTableView.separatorStyle = .none
        
        //search text
        self.searchTextField.layer.cornerRadius = 4.0
        self.searchTextField.backgroundColor = SKColors().navColor
        self.searchTextField.layer.borderColor = UIColor.white.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let shoppingListItems = self.shoppingListManager.findShoppingListItems(){
            return shoppingListItems.count
        }
        return 0
    }
    
    //MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingListIdentifier", for: indexPath) as? SKShoppingListCell{
            cell.item = self.shoppingListManager.findShoppingListItems()![indexPath.row]
            cell.setup()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete: UITableViewRowAction = UITableViewRowAction(style: .default, title: "Eliminar", handler: {
            (rowAction: UITableViewRowAction, indexPath: IndexPath) in
            
            self.shoppingListManager.removeItemToShoppingList(item: self.shoppingListManager.findShoppingListItems()![indexPath.row])
            self.shoppingListTableView.reloadData()
            
        })
        
        return [delete]
        
    }
    
    //MARK: - IBActions
    @IBAction func addItem(_ sender: Any) {
        
        if(self.searchTextField.text != ""){
            
            if let item = self.itemManager.findItems(filter: NSPredicate(format: "name BEGINSWITH %@", self.searchTextField.text!))?.first{
                if(!self.shoppingListManager.hasItem(item: item)){
                    self.shoppingListManager.addAddItemToShoppingList(item: item)
                    self.shoppingListTableView.reloadData()
                }
            }
            
        }else{
            let alert = UIAlertController(title: "Error", message: "Debes Seleccionar un producto", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        self.searchTextField.resignFirstResponder()
        
    }

}
