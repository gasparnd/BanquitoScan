//
//  BankAccount.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 25/02/2025.
//

import Foundation

struct BankAccountInfo {
    let name: String?
    let rut: String
    let accountType: String
    let accountNumber: String
    let bank: String
    let email: String?
    
    func formattedInfo() -> String {
        var nameValue = ""
        var emailValue = ""

        
        if let name = name {
            nameValue = name
        }
        if let email = email {
            emailValue = email
        }
        
        return """
        \(emailValue)
        \(nameValue)
        \(rut)
        \(accountType)
        \(accountNumber)
        \(bank)
        """.trimmingCharacters(in: .whitespaces)
    }
}
