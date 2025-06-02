//
//  ScanNewAccountPresenterProtocol.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 02-06-25.
//

import Foundation
import UIKit

protocol ScanNewAccountPresentable: AnyObject {
    var account: AccountEntity? { get }
    func getAccountInfo(from: UIImage) -> Void
    func saveAccountInfo(_ account: AccountEntity) async -> Void
}
