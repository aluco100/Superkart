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
import Stripe
import SVProgressHUD

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
            cell.setup()
            self.total_value += Int(cell.productQuantityStepper.value) * cell.item!.cost
            self.shoppingTotalToPay.text = SKNumberFormatter().currencyStyle(number: self.total_value)
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
        

    @IBAction func payShoppingCart(_ sender: Any) {
        
        let confirmation = UIAlertController(title: "Confirmación de compra", message: nil, preferredStyle: .alert)
        confirmation.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { action in
            if let card = PaymentManager.sharedInstance.findCreditCard(filter: nil){
                
                //fixture
                let cardParams: STPCardParams = STPCardParams()
                cardParams.number = "4242424242424242"
                cardParams.expMonth = UInt(10)
                cardParams.expYear = UInt(19)
                cardParams.cvc = "422"
//                cardParams.number = card.getCreditCardNumber()
//                cardParams.expMonth = UInt(card.expiration_month)
//                cardParams.expYear = UInt(card.expiration_year)
//                cardParams.cvc = card.cvv
                
                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
                //send card information to stripe to get back a token
                self.getStripeToken(card: cardParams)
                
            }
        }))
        confirmation.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: nil))
        self.present(confirmation, animated: true, completion: nil)
        
        
    }
    
    func getStripeToken(card:STPCardParams) {
        // get stripe token for current card
        STPAPIClient.shared().createToken(withCard: card) { token, error in
            if let token = token {
                print(token)
//                SVProgressHUD.showSuccess(withStatus: "Stripe token successfully received: \(token)")
                self.postStripeToken(token: token)
            } else {
                print(error as Any)
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            }
        }
    }
    
    // charge money from backend
    func postStripeToken(token: STPToken) {
        //Set up these params as your backend require
//        let params: [String: Any] = ["stripeToken": token.tokenId, "amount": 10]
        
        let paymentManager = PaymentManager.sharedInstance
        paymentManager.payShoppingKart(amount: self.total_value, token: token.tokenId, success: {
            
            SVProgressHUD.showSuccess(withStatus: "Transaccion exitosa")
            
        }, failure: { error in
            print(error)
            
            SVProgressHUD.showError(withStatus: "No se ha podido realizar la compra")
            
        })

        
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
