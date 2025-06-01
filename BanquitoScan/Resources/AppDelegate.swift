//
//  AppDelegate.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 24/01/2025.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    var listOfAccountsRouter = ListOfAccountsRouter()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        listOfAccountsRouter.showListOfAccounts(window: window)
//        window?.makeKeyAndVisible()
//        window?.backgroundColor = .systemBackground
//        
//        let vc = HomeViewController()
//        let navController = UINavigationController(rootViewController: vc)
//        navController.navigationBar.prefersLargeTitles = true
//        vc.navigationItem.largeTitleDisplayMode = .always
//        window?.rootViewController = navController
        
        return true
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.saveContext()
    }
    
}

