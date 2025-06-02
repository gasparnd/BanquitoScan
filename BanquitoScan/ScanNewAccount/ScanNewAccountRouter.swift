//
//  ScanNewAccountRouter.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

protocol ScanNewAccountRouting: AnyObject {
    func showScanNewAccountView(fromViewController: UIViewController, navigationController: UINavigationController, withImage: Any)
}

final class ScanNewAccountRouter: ScanNewAccountRouting {
    
    func showScanNewAccountView(fromViewController: UIViewController, navigationController: UINavigationController, withImage: Any) {
        let view = ScanNewAccountView()
        
        navigationController.pushViewController(view, animated: true)
    }
}
