//
//  ListOfAccountsPresenter.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation

final class ListOfAccountsPresenter: ListOfAccountsPresentable {
    weak var ui: ListOfAccountsUI?
    
    var accounts: [AccountEntity] = []
    let interactor: ListOfAccountsInteractorProtocol
    
    init(interactor: ListOfAccountsInteractorProtocol) {
        self.interactor = interactor
    }
    
    func onViewAppear() {
        Task {
            accounts = await interactor.getAccounts()
            ui?.update(accounts: accounts)
        }
    }
     
    func onTapCell(at index: Int) {
        
    }
    
    
}
