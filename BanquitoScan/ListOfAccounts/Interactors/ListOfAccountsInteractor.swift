//
//  ListOfAccountsInteractor.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation

final class ListOfAccountsInteractor: ListOfAccountsInteractorProtocol  {
    private let databaseManeger: DatabaseProtocol
    
    init(databaseManeger: DatabaseProtocol) {
        self.databaseManeger = databaseManeger
    }
    
    func getAccounts() async -> [AccountEntity] {
        let accounts: [AccountEntity] = await databaseManeger.getAll()
        return accounts
    }
}
