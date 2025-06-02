//
//  ScanNewAccountInteractorProtocol.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 02-06-25.
//

import Foundation
import UIKit

protocol ScanNewAccountInteractorProtocol {
    func extractText(from: UIImage) -> [String]
    func findAccountImage(from: [String]) -> AccountEntity?
    func saveAccount(account: AccountEntity) async -> Bool
}
