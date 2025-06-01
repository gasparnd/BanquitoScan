//
//  DatabaseProtocol.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation

protocol DatabaseProtocol: AnyObject {
    func getAll() async -> [AccountEntity]
    func get(account: AccountEntity) async -> AccountEntity?
    func save(account: AccountEntity) async -> Bool
    func update(account: AccountEntity) async -> Bool
    func delete(account: AccountEntity) async -> Bool
}
