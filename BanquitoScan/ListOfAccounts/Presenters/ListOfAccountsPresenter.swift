//
//  ListOfAccountsPresenter.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

final class ListOfAccountsPresenter: ListOfAccountsPresentable {
    weak var ui: ListOfAccountsUI?
    
    var accounts: [AccountEntity] = []
    let interactor: ListOfAccountsInteractorProtocol
    let router: ListOfAccountsRouting
    
    init(interactor: ListOfAccountsInteractorProtocol, router: ListOfAccountsRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewAppear() {
        Task {
            accounts = await interactor.getAccounts()
            ui?.update(accounts: accounts)
        }
    }
    
    func onTapCell(at index: Int) {
        let account = accounts[index]
        let accountInfo = account.formattedInfo()
        copyInClipboard(string: accountInfo)
        triggerHapticFeedback(type: .success)
    }
    
    func onRemoveCell(at index: Int) {
        Task {
            let account = accounts[index]
            let result = await interactor.removeAccount(account: account)
            if result {
                accounts.remove(at: index)
                ui?.update(accounts: accounts)
            }
            
        }
    }
    
    func scanNewAccount(image: UIImage) {
        router.scanNewAccount(image: image)
    }
}
