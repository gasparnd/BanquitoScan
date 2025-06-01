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
    
    public func formattedInfo() -> String {
        var nameValue = ""
        var emailValue = ""
        
        
        if let name = name {
            nameValue = name.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if let email = email {
            emailValue = email.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return """
        \(nameValue)
        \(rut)
        \(accountType)
        \(accountNumber)
        \(bank)
        \(emailValue)
        """.trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
}
