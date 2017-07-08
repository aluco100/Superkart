//
//  SKShoppingViewController.swift
//  Superkart
//
//  Created by Alfredo Luco on 26-03-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import BarcodeScanner
import FontAwesomeKit

class SKShoppingViewController: UIViewController, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate, UITableViewDelegate, UITableViewDataSource {

    
    //MARK: - IBOutlets
    @IBOutlet var shoppingConfigurations: UIButton!
    @IBOutlet var shoppingTakePhoto: UIButton!
    @IBOutlet var shoppingTableView: UITableView!
    @IBOutlet var shoppingTotalToPay: UILabel!
    @IBOutlet var shoppingPay: UIButton!
    @IBOutlet weak var shoppingPayContainer: UIView!
    
    var storage: [Item] = []
    var total_value: Int = 0
    var itemManager: ItemManager = ItemManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.storage = self.itemManager.findItemsToBuy()
        
        self.setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setup(){
        //background color
        self.view.backgroundColor = SKColors().backgroundColor
        
        //nav bar settings
        self.navigationController?.navigationBar.barTintColor = SKColors().navColor
        
        
        let menu = FAKMaterialIcons.menuIcon(withSize: 30.0)
        menu!.addAttribute(NSForegroundColorAttributeName, value: UIColor.white)
        self.shoppingConfigurations.setImage(menu!.image(with: CGSize(width: 30.0, height: 30.0)), for: .normal)
        self.shoppingConfigurations.setTitle("", for: .normal)
        
        let photo = FAKFontAwesome.barcodeIcon(withSize: 30.0)
        photo!.addAttributes([NSForegroundColorAttributeName : UIColor.white])
        self.shoppingTakePhoto.setImage(photo!.image(with: CGSize(width: 30.0, height: 30.0)), for: .normal)
        self.shoppingTakePhoto.setTitle("", for: .normal)
        self.shoppingTakePhoto.addTarget(self, action: #selector(scanProduct), for: .touchUpInside)
        
        //TableView Config
        
        self.shoppingTableView.backgroundColor = SKColors().backgroundColor
        self.shoppingTableView.separatorStyle = .none
        self.shoppingTableView.estimatedRowHeight = 100.0
        self.shoppingTableView.rowHeight = UITableViewAutomaticDimension
        self.shoppingTableView.delegate = self
        self.shoppingTableView.dataSource = self
        
        //Shopping Pay Container
        self.shoppingPayContainer.backgroundColor = SKColors().main_green
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "updateItemList"), object: nil, queue: nil, using: updateValue)
        
    }
    
    //MARK: - Scanner
    
    func scanProduct(){
        
        let scanner: BarcodeScannerController = BarcodeScannerController()
        scanner.codeDelegate = self
        scanner.errorDelegate = self
        scanner.dismissalDelegate = self
        
        self.present(scanner, animated: true, completion: nil)
        
    }
    
    func barcodeScanner(_ controller: BarcodeScannerController, didReceiveError error: Error) {
        controller.resetWithError(message: "Producto no encontrado")
    }
    
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        print(code)
        
        if let item = self.itemManager.findItem(barcode: code){
            self.itemManager.updateItem(item: item, quantity: 1)
            self.storage.append(item)
        }else{
            self.itemManager.getItem(barcode: code, success: {
                let item = self.itemManager.findItem(barcode: code)!
                self.itemManager.updateItem(item: item, quantity: 1)
                self.storage.append(item)
            }, failure: {
                error in
                //despues que hacer con esto
                print(error)
            })
        }
        
        self.shoppingTableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
    
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "productIdentifier", for: indexPath) as? SKProductCell{
            cell.item = self.storage[indexPath.row]
            self.total_value += Int(cell.productQuantityStepper.value) * cell.item!.cost
            self.shoppingTotalToPay.text = SKNumberFormatter().currencyStyle(number: self.total_value)
            cell.setup()
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete: UITableViewRowAction = UITableViewRowAction(style: .default, title: "Eliminar", handler: {
            (rowAction: UITableViewRowAction, indexPath: IndexPath) in
            
            
            self.itemManager.updateItem(item: self.storage[indexPath.row], quantity: 0)
            self.storage = self.itemManager.findItemsToBuy()
            self.shoppingTableView.reloadData()
            
        })
        
        return [delete]
        
    }
    
    func updateValue(notification: Notification)->Void{
        self.total_value = 0
        self.shoppingTableView.reloadData()
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
