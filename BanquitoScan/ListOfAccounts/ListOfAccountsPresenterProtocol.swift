//
//  ListOfAccountsPresenterProtocol.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation

protocol ListOfAccountsPresentable: AnyObject {
    var accounts: [Account] { get }
    func onViewAppear()
    func onTapCell(at index: Int)
}
