//
//  SKRegisterViewController.swift
//  Superkart
//
//  Created by Alfredo Luco on 30-07-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import SVProgressHUD

class SKRegisterViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    //MARK: - Global variables
    let userManager = UserManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = SKColors().backgroundColor
        self.emailTextField.backgroundColor = SKColors().alternativeColor
        self.passwordTextField.backgroundColor = SKColors().alternativeColor
        self.confirmPasswordTextField.backgroundColor = SKColors().alternativeColor
        self.navigationController?.navigationBar.barTintColor = SKColors().navColor
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - IBActios

    @IBAction func register(_ sender: Any) {
        
        if(self.emailTextField.text != "" && self.passwordTextField.text != "" && self.confirmPasswordTextField.text != ""){
            
            if(self.passwordTextField.text == self.confirmPasswordTextField.text){
                
                self.userManager.registerUser(email: self.emailTextField.text!, password: self.passwordTextField.text!, success: {
                    
                    SVProgressHUD.showSuccess(withStatus: "Registro exitoso")
                    self.navigationController?.popViewController(animated: true)
                    
                }, failure: { error in
                    print(error)
                    SVProgressHUD.showError(withStatus: "No se ha podido registrar. Por favor, intente nuevamente")
                })
                
            }else{
                SVProgressHUD.showError(withStatus: "La confirmación de la contraseña es incorrecta")
            }
            
        }else{
            SVProgressHUD.showError(withStatus: "Debe rellenar todos los campos")
        }
        
    }
}
