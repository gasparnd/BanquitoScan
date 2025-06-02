//
//  ListOfAccountsRouter.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

protocol ListOfAccountsRouting: AnyObject {
    func scanNewAccount(image: UIImage) -> Void
}

final class ListOfAccountsRouter: ListOfAccountsRouting {
    var listOfAccountsViewController: ListOfAccountsView?
    var scanNewAccountRouter: ScanNewAccountRouting?
    var navigationController: UINavigationController?
    
    func showListOfAccounts(window: UIWindow?) {
//        let interactor = ListOfAccountsInteractor(databaseManeger: CoreDataManager.shared)
        let interactor = MockListOfAccountsInteractor()
        let presenter = ListOfAccountsPresenter(interactor: interactor, router: self)
        listOfAccountsViewController = ListOfAccountsView(presenter: presenter)
        presenter.ui = listOfAccountsViewController
        
        navigationController = UINavigationController(rootViewController: listOfAccountsViewController!)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func scanNewAccount(image: UIImage) {
        guard let listOfAccountsViewController, let navigationController else { return }
        
        scanNewAccountRouter = ScanNewAccountRouter()
        scanNewAccountRouter?.showScanNewAccountView(fromViewController: listOfAccountsViewController, navigationController: navigationController, withImage: image)
    }
}
