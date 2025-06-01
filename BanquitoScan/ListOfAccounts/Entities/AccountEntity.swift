//
//  AccountEntity.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation

struct AccountEntity: Equatable, Hashable {
    let id: UUID
    let name: String?
    let rut: String
    let accountType: String
    let accountNumber: String
    let bank: String
    let email: String?
    
    public init(id: UUID, name: String?, rut: String, accountType: String, accountNumber: String, bank: String, email: String?) {
        self.id = id
        self.name = name
        self.rut = rut
        self.accountType = accountType
        self.accountNumber = accountNumber
        self.bank = bank
        self.email = email
    }
}
