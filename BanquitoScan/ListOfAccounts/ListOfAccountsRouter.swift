//
//  ListOfAccountsRouter.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

protocol ListOfAccountsRouting: AnyObject {
    func scanNewAccount(image: Any) -> Void
}

final class ListOfAccountsRouter: ListOfAccountsRouting {
    var listOfAccountsViewController: ListOfAccountsView?
    var scanNewAccountRouter: ScanNewAccountRouting?
    
    func showListOfAccounts(window: UIWindow?) {
//        let interactor = ListOfAccountsInteractor(databaseManeger: CoreDataManager.shared)
        let interactor = MockListOfAccountsInteractor()
        let presenter = ListOfAccountsPresenter(interactor: interactor, router: self)
        listOfAccountsViewController = ListOfAccountsView(presenter: presenter)
        presenter.ui = listOfAccountsViewController
        scanNewAccountRouter = ScanNewAccountRouter()
        
        window?.rootViewController = listOfAccountsViewController
        window?.makeKeyAndVisible()
    }
    
    func scanNewAccount(image: Any) {
        guard let listOfAccountsViewController else { return }
        scanNewAccountRouter?.showScanNewAccountView(fromViewController: listOfAccountsViewController, withImage: image)
    }
}
