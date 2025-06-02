//
//  ScanNewAccountPresenter.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 02-06-25.
//

import Foundation
import UIKit

protocol ScanNewAccountUI: AnyObject {
    func update(witn account: AccountEntity?)
}

final class ScanNewAccountPresenter: ScanNewAccountPresentable {
    
    
    weak var ui: ScanNewAccountUI?
    
    var account: AccountEntity?
    private var interactor: ScanNewAccountInteractorProtocol
    private var router: ScanNewAccountRouting
    
    init(interactor: ScanNewAccountInteractorProtocol, router: ScanNewAccountRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    func getAccountInfo(from image: UIImage) -> Void {
        let texts: [String] = interactor.extractText(from: image)
        guard !texts.isEmpty else {
            ui?.update(witn: nil)
            return
        }
        
        let account = interactor.findAccountImage(from: texts)
        
        guard let accountEntity = account else {
            ui?.update(witn: nil)
            return
        }
        
        ui?.update(witn: account)
    }
    
    func saveAccountInfo(_ account: AccountEntity) {
        Task {
            let saved = await interactor.saveAccount(account: account)
        }
    }
    
    
}
