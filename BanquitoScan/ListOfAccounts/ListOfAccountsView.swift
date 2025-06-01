//
//  ListOfAccountsView.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

final class ListOfAccountsView: UIViewController {
    private var presenter: ListOfAccountsPresenter
    
    init(presenter: ListOfAccountsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewAppear()
    }
}

extension ListOfAccountsView: ListOfAccountsUI {
    func update(accounts: [AccountEntity]) {
        
    }
    
    
}
