//
//  MockListOfAccountsInteractor.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation

final class MockListOfAccountsInteractor: ListOfAccountsInteractorProtocol {
    private var accounts: [AccountEntity] = [
        AccountEntity(
            name: "María López",
            rut: "18.456.789-0",
            accountType: "Cuenta Corriente",
            accountNumber: "12345678901",
            bank: "Banco de Chile",
            email: "maria.lopez@example.com"
        ),
        AccountEntity(
           name: "Juan Pérez",
           rut: "20.345.678-5",
           accountType: "Cuenta RUT",
           accountNumber: "203456785",
           bank: "BancoEstado",
           email: "juan.perez@correo.cl"
       ),
        AccountEntity(
            name: "Catalina Soto",
            rut: "16.234.567-K",
            accountType: "Cuenta Vista",
            accountNumber: "87564321098",
            bank: "Banco BCI",
            email: nil
        ),
        AccountEntity(
            name: "Felipe González",
            rut: "22.789.123-3",
            accountType: "Cuenta de Ahorro",
            accountNumber: "00987654321",
            bank: "Scotiabank Chile",
            email: "felipe.gonzalez@email.com"
        )
    ]
    
    func getAccounts() async -> [AccountEntity] {
      return accounts
    }
    
    func removeAccount(account: AccountEntity) async -> Bool {
        if let index = accounts.firstIndex(of: account) {
            accounts.remove(at: index)
        }
        return true
    }
}
