//
//  ScanNewAccountRouter.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

protocol ScanNewAccountRouting: AnyObject {
    func showScanNewAccountView(fromViewController: UIViewController, navigationController: UINavigationController, withImage image: UIImage)
}

final class ScanNewAccountRouter: ScanNewAccountRouting {
    var navigationController: UINavigationController?
    
    func showScanNewAccountView(fromViewController: UIViewController, navigationController navController: UINavigationController, withImage image: UIImage) {
        navigationController = navController
        let interactor = ScanNewAccountInteractor(database: CoreDataManager.shared)
        let presenter = ScanNewAccountPresenter(interactor: interactor, router: self)
        let view = ScanNewAccountView(presenter: presenter, image: image)
        presenter.ui = view
        
        navigationController?.pushViewController(view, animated: true)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
