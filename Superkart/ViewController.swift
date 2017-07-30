//
//  ViewController.swift
//  Superkart
//
//  Created by Alfredo Luco on 05-03-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import SVProgressHUD

class ViewController: UIViewController,FBSDKLoginButtonDelegate {

    @IBOutlet var fbButton: FBSDKLoginButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = SKColors().backgroundColor
        
        self.fbButton.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if ((error) != nil) {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // Navigate to other view
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //logout
    }
    
    //MARK: - IBActions
    
    @IBAction func register(_ sender: Any) {
        self.performSegue(withIdentifier: "registerSegue", sender: self)
    }
    
    @IBAction func manualLogin(_ sender: Any) {
        
        if(self.usernameTextField.text != "" && self.passwordTextField.text != ""){
            
            let userManager = UserManager.sharedInstance
            userManager.loginUser(email: self.usernameTextField.text!, password: self.passwordTextField.text!, success: {
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                
                UIApplication.shared.keyWindow?.rootViewController = mainStoryboard.instantiateInitialViewController()
                
            }, failure: { error in
                print(error)
                SVProgressHUD.showError(withStatus: "Ocurrió un error. Por favor, intentelo nuevamente")
            })
            
        }else{
            SVProgressHUD.showError(withStatus: "Debe colocar su email y contraseña")
        }
        
        
        
    }
        

}

