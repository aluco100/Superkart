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
    
    var storage: [String] = []
    
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
        self.view.backgroundColor = SKColors().backgroundColor
        
        //nav bar settings
        self.navigationController?.navigationBar.barTintColor = SKColors().navColor
        
        
        let config = FAKMaterialIcons.settingsIcon(withSize: 30.0)
        config!.addAttribute(NSForegroundColorAttributeName, value: UIColor.white)
        self.shoppingConfigurations.setImage(config!.image(with: CGSize(width: 30.0, height: 30.0)), for: .normal)
        self.shoppingConfigurations.setTitle("", for: .normal)
        
        let photo = FAKMaterialIcons.shoppingCartPlusIcon(withSize: 30.0)
        photo!.addAttributes([NSForegroundColorAttributeName : UIColor.white])
        self.shoppingTakePhoto.setImage(photo!.image(with: CGSize(width: 30.0, height: 30.0)), for: .normal)
        self.shoppingTakePhoto.setTitle("", for: .normal)
        self.shoppingTakePhoto.addTarget(self, action: #selector(scanProduct), for: .touchUpInside)
        
        //TableView Config
        
        self.shoppingTableView.backgroundColor = SKColors().backgroundColor
        self.shoppingTableView.delegate = self
        self.shoppingTableView.dataSource = self
        
        //Shopping Pay Container
        self.shoppingPayContainer.backgroundColor = SKColors().main_green
        
    }
    
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
        self.storage.append(code)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productIdentifier", for: indexPath)
        
        cell.textLabel!.text = self.storage[indexPath.row]
        
        return cell
        
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
