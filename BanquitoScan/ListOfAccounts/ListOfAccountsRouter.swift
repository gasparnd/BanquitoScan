//
//  ListOfAccountsRouter.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

protocol ListOfAccountsRouting: AnyObject {
    func scanNewAccount() -> Void
}

final class ListOfAccountsRouter {
    var listOfAccountsViewController: ListOfAccountsView?
    
    func showListOfAccounts(window: UIWindow?) {
        let interactor = ListOfAccountsInteractor(databaseManeger: CoreDataManager.shared)
        let presenter = ListOfAccountsPresenter(interactor: interactor)
        listOfAccountsViewController = ListOfAccountsView(presenter: presenter)
        presenter.ui = listOfAccountsViewController
        
        window?.rootViewController = listOfAccountsViewController
        window?.makeKeyAndVisible()
    }
}
