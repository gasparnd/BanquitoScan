//
//  ScanNewAccountView.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

final class ScanNewAccountView: UIViewController {
    private var presenter: ScanNewAccountPresenter
    
    init(presenter: ScanNewAccountPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalles"
        navigationItem.largeTitleDisplayMode = .never
        
    }
}

extension ScanNewAccountView: ScanNewAccountUI {
    func update(witn account: AccountEntity?) {
        
    }
}
