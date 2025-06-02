//
//  ListOfAccountsPresenterProtocol.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

protocol ListOfAccountsUI: AnyObject {
    func update(accounts: [AccountEntity])
}

protocol ListOfAccountsPresentable: AnyObject {
    var accounts: [AccountEntity] { get }
    func onViewAppear()
    func onTapCell(at index: Int)
    func onRemoveCell(at index: Int)
    func scanNewAccount(image: UIImage)
}
