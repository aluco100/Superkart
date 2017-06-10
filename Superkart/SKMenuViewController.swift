//
//  SKMenuViewController.swift
//  Superkart
//
//  Created by Alfredo Luco on 10-06-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import ECSlidingViewController
import FontAwesomeKit

class SKMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: - IBOutlets
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    //MARK: - Global Variables
    var items: [String] = ["Compras", "Métodos de Pago", "Lista de Compras", "Cerrar Sesión"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = SKColors().navColor
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuTableView.rowHeight = UITableViewAutomaticDimension
        self.menuTableView.estimatedRowHeight = 75.0
        self.menuTableView.separatorStyle = .none
        self.menuTableView.backgroundColor = SKColors().navColor
        
        self.rightConstraint.constant = self.slidingViewController().anchorRightPeekAmount
        
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
        return self.items.count
    }
    
    //MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "menuIdentifier", for: indexPath) as? SKMenuItemTableViewCell{
            cell.titleLabel.text = self.items[indexPath.row]
            
            switch self.items[indexPath.row] {
            case "Compras":
                cell.iconType = FAKFontAwesome.shoppingCartIcon(withSize: 30.0)
                break
            case "Métodos de Pago":
                cell.iconType = FAKFontAwesome.moneyIcon(withSize: 30.0)
                break
            case "Lista de Compras":
                cell.iconType = FAKFontAwesome.shoppingBasketIcon(withSize: 30.0)
                break
            case "Cerrar Sesión":
                cell.iconType = FAKFontAwesome.userTimesIcon(withSize: 30.0)
                break
            default:
                break
            }
            
            cell.setup()
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.items[indexPath.row] {
        case "Compras":
            self.performSegue(withIdentifier: "shoppingSegue", sender: self)
            break
        case "Métodos de Pago":
//            self.performSegue(withIdentifier: "", sender: self)
            break
        case "Lista de Compras":
//            self.performSegue(withIdentifier: "", sender: self)
            break
        case "Cerrar Sesión":
            //TODO: Close Session
            break
        default:
            break
        }

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwindToMenuViewController(segue: UIStoryboardSegue){
        
        self.slidingViewController().anchorTopViewToRight(animated: true)
        
        if(self.slidingViewController().currentTopViewPosition == .anchoredRight){
            self.slidingViewController().resetTopView(animated: true)
        }
    }
    
}
