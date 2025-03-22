//
//  CoreDataManager.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 08/03/2025.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "AccountsData")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error al cargar Core Data: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error al guardar Core Data: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func crearAccount(with accountInfo: BankAccountInfo) -> Account? {
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "rut == [c] %@ AND bank == [c] %@", accountInfo.rut, accountInfo.bank)
        
        do {
            let accountExist = try context.fetch(fetchRequest)

            if accountExist.isEmpty == false {
                return nil
            } else {
                let account = Account(context: CoreDataManager.shared.context)
                account.name = accountInfo.name
                account.bank = accountInfo.bank
                account.rut = accountInfo.rut
                account.email = accountInfo.email
                account.accountType = accountInfo.accountType
                account.accountNumber = accountInfo.accountNumber
                
                saveContext()
                return account
            }
            
        } catch {
            print("Error al obtener cuentas: \(error.localizedDescription)")
            return nil
        }
        
    }
    
    func getAccounts() -> [Account] {
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        do {
            return try CoreDataManager.shared.context.fetch(fetchRequest)
        } catch {
            print("Error al obtener cuentas: \(error.localizedDescription)")
            return []
        }
    }
    
    func removeAccount(account: Account) {
        context.delete(account)
        saveContext()
    }
}
