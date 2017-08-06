//
//  SKCardViewController.swift
//  Superkart
//
//  Created by Alfredo Luco on 05-08-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import FontAwesomeKit

class SKCardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: - IBOutlets
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var cardTableView: UITableView!
    
    //MARK: - Global Variables
    let paymentManager: PaymentManager = PaymentManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addIcon = FAKFontAwesome.plusIcon(withSize: 20)
        addIcon?.setAttributes([NSForegroundColorAttributeName : UIColor.white])
        self.scanButton.setImage(addIcon?.image(with: CGSize(width: 20.0, height: 20.0)), for: .normal)
        self.scanButton.addTarget(self, action: #selector(addCard), for: .touchUpInside)
        
        self.cardTableView.separatorStyle = .none
        self.cardTableView.estimatedRowHeight = 60.0
        self.cardTableView.rowHeight = UITableViewAutomaticDimension
        self.cardTableView.backgroundColor = SKColors().backgroundColor
        
        self.navigationController?.navigationBar.barTintColor = SKColors().navColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.view.backgroundColor = SKColors().backgroundColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.cardTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentManager.findData(predicate: nil)!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cardIdentifier", for: indexPath) as? SKCardCell{
            cell.setup(payment: self.paymentManager.findData(predicate: nil)![indexPath.row])
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete: UITableViewRowAction = UITableViewRowAction(style: .default, title: "Eliminar", handler: {
            (rowAction: UITableViewRowAction, indexPath: IndexPath) in
            
            
            self.paymentManager.removeCard(payment: self.paymentManager.findData(predicate: nil)![indexPath.row])
            self.cardTableView.reloadData()
            
        })
        
        return [delete]
        
    }
    
    
    //MARK: - Selectors
    
    func addCard(){
        self.performSegue(withIdentifier: "scanSegue", sender: self)
    }
    
}
