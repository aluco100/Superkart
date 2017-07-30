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
import HexColors

class ViewController: UIViewController {

    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = SKColors().backgroundColor
        
        // Do any additional setup after loading the view, typically from a nib.
        self.fbButton.layer.borderWidth = 1.0
        self.fbButton.layer.borderColor = UIColor("#627aac")!.cgColor
        self.fbButton.layer.cornerRadius = 4.0
        self.fbButton.tintColor = UIColor.white
        self.fbButton.backgroundColor = UIColor("#3B5998")!
        self.fbButton.addTarget(self, action: #selector(loginFacebook), for: .touchUpInside)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
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
    
    func loginFacebook(){
        let loginManager = LoginManager()
        
        
        loginManager.logIn([ .publicProfile, .email ], viewController: self) { loginResult in
            
            switch loginResult {
                
            case .failed(let error):
                
                print(error)
                SVProgressHUD.showError(withStatus: "No se ha podido iniciar con Facebook")
                
            case .cancelled:
                
                print("User cancelled login.")
                
            case .success( let permisions, _, let accessToken):
                
                SVProgressHUD.show(withStatus: "Verificando usuario, por favor espere")
                
                let userMgr : UserManager = UserManager.sharedInstance
                print(permisions)
                
                let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: accessToken.authenticationToken, version: nil, httpMethod: "GET")
                req?.start(completionHandler: { (_, result, error) in
                    if(error == nil)
                    {
                        let user = result as! [String : Any]
//                        print("result \(result)")
                        userMgr.registerUser(email: user["email"] as! String, password: "", success: {
                            
                            userMgr.loginUser(email: user["email"] as! String, password: "", success: {
                                
                                SVProgressHUD.showSuccess(withStatus: "Inicio exitoso. Bienvenido!")
                                
                                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                
                                UIApplication.shared.keyWindow?.rootViewController = mainStoryboard.instantiateInitialViewController()
                                
                            }, failure: { error in
                                print(error)
                                SVProgressHUD.showError(withStatus: "No se ha podido iniciar con facebook")
                            })
                            
                        }, failure: { error in
                            print(error)
                            SVProgressHUD.showError(withStatus: "No se ha podido iniciar con facebook")
                        })
                    }
                    else
                    {
                        SVProgressHUD.showError(withStatus: "No se ha podido iniciar con facebook")
                    }
                })
                
            }
        }

    }
        
    //MARK: - IBActions
    
    @IBAction func register(_ sender: Any) {
        self.performSegue(withIdentifier: "registerSegue", sender: self)
    }
    
    @IBAction func manualLogin(_ sender: Any) {
        
        if(self.usernameTextField.text != "" && self.passwordTextField.text != ""){
            
            SVProgressHUD.show(withStatus: "Verificando usuario, por favor espere")
            
            let userManager = UserManager.sharedInstance
            userManager.loginUser(email: self.usernameTextField.text!, password: self.passwordTextField.text!, success: {
                
                SVProgressHUD.showSuccess(withStatus: "Inicio exitoso. Bienvenido!")
                
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

