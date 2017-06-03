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

class ViewController: UIViewController,FBSDKLoginButtonDelegate {

    @IBOutlet var fbButton: FBSDKLoginButton!
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
    
    @IBAction func manualLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
        

}

