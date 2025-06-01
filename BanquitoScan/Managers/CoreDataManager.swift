//
//  CoreDataManager.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 08/03/2025.
//

import CoreData

final class CoreDataManager: DatabaseProtocol {
    
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
    
    
    func get(account: AccountEntity) async -> AccountEntity? {
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "rut == [c] %@ AND bank == [c] %@", account.rut, account.bank)
        do {
            let accountExist = try context.fetch(fetchRequest)
            
            if let accountExist = accountExist.first {
                return mapAccountEntity(accountExist)
            } else {
                return nil
            }
        } catch {
            print("Error al obtener cuentas: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getAll() async -> [AccountEntity] {
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        do {
            let accounts: [Account] = try CoreDataManager.shared.context.fetch(fetchRequest)
            return accounts.map { account in
                return mapAccountEntity(account)
            }
        } catch {
            print("Error al obtener cuentas: \(error.localizedDescription)")
            return []
        }
    }
    
    func save(account: AccountEntity) async -> Bool {
        let accountExist = await get(account: account)
        guard accountExist != nil else {
            return false
        }
        
        let account = Account(context: CoreDataManager.shared.context)
        account.name = account.name
        account.bank = account.bank
        account.rut = account.rut
        account.email = account.email
        account.accountType = account.accountType
        account.accountNumber = account.accountNumber
        
        saveContext()
        return true
    }
    
    func update(account: AccountEntity) async -> Bool {
        // TODO: Update an account
        return false
    }
    
    func delete(account entity: AccountEntity) async -> Bool {
        let account = parseAccountEntiy(entity)
        
        context.delete(account)
        saveContext()
        return true
    }
    
    // MARK: - Helpers
    
    func parseAccountEntiy(_ accountEntity: AccountEntity) -> Account {
        var account: Account!
        account = Account(context: context)
        account.id = accountEntity.id
        account.name = accountEntity.name
        account.bank = accountEntity.bank
        account.rut = accountEntity.rut
        account.email = accountEntity.email
        account.accountType = accountEntity.accountType
        account.accountNumber = accountEntity.accountNumber
        return account
    }
    
    func mapAccountEntity(_ account: Account) -> AccountEntity {
        let id = account.id ?? UUID()
        let name = account.name ?? ""
        let email = account.email ?? ""
        let rut = account.rut ?? ""
        let accountType = account.accountType ?? ""
        let accountNumber = account.accountNumber ?? ""
        let bank = account.bank ?? ""
        
        return AccountEntity(id: id, name: name, rut: rut, accountType: accountType, accountNumber: accountNumber, bank: bank, email: email)
    }
}
