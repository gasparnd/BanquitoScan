//
//  ScanNewAccountRouter.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

protocol ScanNewAccountRouting: AnyObject {
    func showScanNewAccountView(fromViewController: UIViewController, withImage: Any)
}

final class ScanNewAccountRouter: ScanNewAccountRouting {
    
    func showScanNewAccountView(fromViewController: UIViewController, withImage: Any) {
        let view = ScanNewAccountView()
        
        fromViewController.present(view, animated: true)
    }
}
