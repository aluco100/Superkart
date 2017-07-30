//
//  AppDelegate.swift
//  Superkart
//
//  Created by Alfredo Luco on 05-03-17.
//  Copyright © 2017 aluco. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import IQKeyboardManagerSwift
import RealmSwift
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        self.updateItems()
        self.migrations()
        self.rootView()
        Stripe.setDefaultPublishableKey("pk_test_orBdY6TxcwYxo8f7HswiWYaF")
        IQKeyboardManager.sharedManager().enable = true
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().tintColor = SKColors().navColor
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func rootView(){
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if(!self.isLogged()){
            let viewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
            let navigation = UINavigationController(rootViewController: viewController)
            self.window!.rootViewController = navigation
        }else{
            self.window?.rootViewController = storyboard.instantiateInitialViewController()
        }
        
    }
    
    func isLogged()->Bool{
        
        let userManager = UserManager()
        
        if (userManager.currentUser() != nil){
            return true
        }
        return false
    }
    
    func migrations(){
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 2,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                
        })
        Realm.Configuration.defaultConfiguration = config
        
    }

    func updateItems(){
        let itemManager = ItemManager.sharedInstance
        itemManager.updateItems(success: {
            print("success")
        }, failure: {
            error in
            print("error")
        })
    }

}

