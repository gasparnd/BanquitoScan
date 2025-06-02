//
//  ScanNewAccountInteractor.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 02-06-25.
//

import Foundation
import UIKit

final class ScanNewAccountInteractor: ScanNewAccountInteractorProtocol {
    private let scanner = BankAccountScanner()
    private let validator = ValidateAndParseBankData.shared
    private let rutValidator = RutValidator.shared
    
    private var database: DatabaseProtocol
    
    init(database: DatabaseProtocol) {
        self.database = database
    }
    
    func extractText(from image: UIImage) -> [String] {
        var extractText: [String] = []
        
        scanner.extractBankAccountInfo(from: image) { result in
            if !result.isEmpty {
                extractText = result
            }
        }
        
        return extractText
    }
    
    func findAccountImage(from textLines: [String]) -> AccountEntity? {
        var name: String = ""
        var rut: String = ""
        var accountType: String = ""
        var accountNumber: String = ""
        var bank: String = ""
        var email: String = ""
        
        for line in textLines {
            print("Start: \(line)")
            if line.contains("@") {
                print("It is email")
                email = line.trimmingCharacters(in: .whitespaces).lowercased()
            } else if let formatedAccountType = validator.validateAccountType(line) {
                print("It is account type")
                accountType = formatedAccountType
            } else if let formatedRut = validator.validateRut(line) {
                print("It is rut")
                rut = formatedRut
            } else if let formatedAccountNumber = validator.validateAccountnumber(line) {
                print("It is account number")
                accountNumber = formatedAccountNumber
            } else if let formatedBank = validator.validateBank(line) {
                print("It is bank")
                bank = formatedBank
            } else  {
                print("It is name")
                name = "\(name) \(line.trimmingCharacters(in: .whitespaces).lowercased().capitalized)"
            }
            print("End")
        }
        
        if accountType == "Cuenta Rut"  {
            if !accountNumber.isEmpty {
                let number = Int(accountNumber) ?? 0
                let verifyDigit = rutValidator.getVerifyDigit(number)
                rut = rutValidator.formatRut(rut: accountNumber, dv: verifyDigit)
            } else if !rut.isEmpty {
                let separatedRut = rutValidator.separateRut(rut: rut)
                
                guard let rutData = separatedRut else {
                    return nil
                }
                accountNumber = "\(rutData.0)"
            }
            
        } else {
            let parsedAccountnumber = validator.parseAccountNumer(accountNumber)
            if let parsedData = parsedAccountnumber {
                accountNumber = parsedData
            }
        }
        
        
        
        if rut.isEmpty || accountType.isEmpty || accountNumber.isEmpty  || bank.isEmpty {
            return nil
        }
        
        return AccountEntity(id: UUID(), name: name, rut: rut, accountType: accountType, accountNumber: accountNumber, bank: bank, email: email)
    }
    
    func saveAccount(account: AccountEntity) async -> Bool {
        let saved = await database.save(account: account)
        return saved
    }
    
    
}
