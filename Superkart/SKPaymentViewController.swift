//
//  SKPaymentViewController.swift
//  Superkart
//
//  Created by Alfredo Luco on 29-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import Stripe
import SVProgressHUD

class SKPaymentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,SKScanCreditDelegate,CardIOPaymentViewControllerDelegate {
    
    //MARK: - IBOUtlets
    @IBOutlet weak var creditCardTableView: UITableView!
    
    var card: Payment? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creditCardTableView.backgroundColor = SKColors().backgroundColor
        self.creditCardTableView.separatorStyle = .none
        self.creditCardTableView.estimatedRowHeight = 100.0
        self.creditCardTableView.rowHeight = UITableViewAutomaticDimension
        
        //nav bar settings
        self.navigationController?.navigationBar.barTintColor = SKColors().navColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CardIOUtilities.preload()
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
        return 2
    }
    
    //MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "scanIdentifier", for: indexPath) as? SKScanCreditCardCell{
                cell.delegate = self
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "creditCardIdentifier", for: indexPath) as? SKCreditCardCell{
                if(self.card != nil){
                    cell.setup(payment: self.card!)
                }
                return cell
            }
//        case 2:
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "countryIdentifier", for: indexPath) as? SKCountryCell{
//                return cell
//            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    //MARK: - Scan Credit Delegate
    
    func didScan() {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC!.modalPresentationStyle = .formSheet
        present(cardIOVC!, animated: true, completion: nil)
        
    }
    
    //MARK: - CardIO Methods
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        print("user canceled")
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            print(str)
            
            //dismiss scanning controller
            paymentViewController?.dismiss(animated: true, completion: nil)
            
            //create Stripe card
            let card: STPCardParams = STPCardParams()
            card.number = info.cardNumber
            card.expMonth = info.expiryMonth
            card.expYear = info.expiryYear
            card.cvc = info.cvv
            
            let payment = Payment(cardNumber: info.cardNumber,cardHolderNumber: info.redactedCardNumber, expirationMonth: Int(info.expiryMonth), expirationYear: Int(info.expiryYear), CVV: info.cvv,cardType: info.cardType.rawValue)
            let paymentManager = PaymentManager.sharedInstance
            paymentManager.addCreditCard(payment: payment)
            self.card = payment
            let alert = UIAlertController(title: "Tarjeta Agregada", message: "Su tarjeta de credito \(info.redactedCardNumber!) ha sido agregada exitosamente", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            self.creditCardTableView.reloadData()
        }
    }
    
}
