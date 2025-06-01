//
//  MockListOfAccountsInteractor.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation

final class MockListOfAccountsInteractor: ListOfAccountsInteractorProtocol {
    func getAccounts() async -> [AccountEntity] {
        let account1 = AccountEntity(
            name: "María López",
            rut: "18.456.789-0",
            accountType: "Cuenta Corriente",
            accountNumber: "12345678901",
            bank: "Banco de Chile",
            email: "maria.lopez@example.com"
        )
        
        let account2 = AccountEntity(
            name: "Juan Pérez",
            rut: "20.345.678-5",
            accountType: "Cuenta RUT",
            accountNumber: "203456785",
            bank: "BancoEstado",
            email: "juan.perez@correo.cl"
        )
        
        let account3 = AccountEntity(
            name: "Catalina Soto",
            rut: "16.234.567-K",
            accountType: "Cuenta Vista",
            accountNumber: "87564321098",
            bank: "Banco BCI",
            email: nil
        )
        
        let account4 = AccountEntity(
            name: "Felipe González",
            rut: "22.789.123-3",
            accountType: "Cuenta de Ahorro",
            accountNumber: "00987654321",
            bank: "Scotiabank Chile",
            email: "felipe.gonzalez@email.com"
        )
        return [account1, account2, account3, account4]
    }
}
