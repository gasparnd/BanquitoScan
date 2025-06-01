//
//  ListOfAccountsInteractorProtocol.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation

protocol ListOfAccountsInteractorProtocol: AnyObject {
    func getAccounts() -> [AccountEntity]
}
