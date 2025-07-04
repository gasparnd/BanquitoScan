//
//  ScanNewAccountPresenter.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 02-06-25.
//

import Foundation
import UIKit

protocol ScanNewAccountUI: AnyObject {
    func update(with account: AccountEntity?)
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
       interactor.extractText(from: image) { [weak self] result in
           guard !result.isEmpty else {
               self?.router.goBack()
               return
           }
           self?.parseTexts(result)
        }
        
        
       
    }
    
    private func parseTexts(_ texts: [String])  {
        let resposne = interactor.findAccountImage(from: texts)
        guard let accountEntity = resposne else {
            router.goBack()
            return
        }
        account = accountEntity
        ui?.update(with: accountEntity)
    }
    
    func saveAccountInfo(_ account: AccountEntity) {
        Task {
            let saved = await interactor.saveAccount(account: account)
        }
    }
    
    
}
