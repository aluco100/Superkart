//
//  SKLaunchViewController.swift
//  Superkart
//
//  Created by Alfredo Luco on 27-08-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit

class SKLaunchViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var registerButton: SKFormButton!
    @IBOutlet weak var loginButton: SKFormButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = SKColors().backgroundColor
        self.registerButton.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        self.loginButton.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
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
    
    //MARK: - Selectors
    func goToRegister(){
        self.performSegue(withIdentifier: "registerSegue", sender: self)
    }
    
    func goToLogin(){
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }

}

extension UIImage{
    
    func alpha(_ value:CGFloat)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}
