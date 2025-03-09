//
//  AccountInfoView.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 08/03/2025.
//

import UIKit

final class AccountInfoView: UIView {
    private let infoView = UIStackView()
    
    private let nameLabel = UILabel()
    private let rutLabel = UILabel()
    private let emailLabel = UILabel()
    private let accountTye = UILabel()
    private let accountNumer = UILabel()
    private let accountBank = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        rutLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        accountTye.translatesAutoresizingMaskIntoConstraints = false
        accountNumer.translatesAutoresizingMaskIntoConstraints = false
        accountBank.translatesAutoresizingMaskIntoConstraints = false
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.axis = .vertical
        infoView.spacing = 4
        
        infoView.addArrangedSubview(nameLabel)
        infoView.addArrangedSubview(rutLabel)
        infoView.addArrangedSubview(emailLabel)
        infoView.addArrangedSubview(accountTye)
        infoView.addArrangedSubview(accountNumer)
        infoView.addArrangedSubview(accountBank)
        
        addSubview(infoView)
        
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: topAnchor),
            infoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: bottomAnchor) 
        ])
    }
    
    func configure(with accountData: BankAccountInfo) {
        print("accountData: \(accountData)")
        if let nameVale = accountData.name {
            if !nameVale.isEmpty {
                nameLabel.text = "Nombre: \(nameVale)"
            }
        }
        if let emailVale = accountData.email {
            if !emailVale.isEmpty {
                emailLabel.text = "Email: \(emailVale)"
            }
        }
        
        rutLabel.text = "RUT: \(accountData.rut)"
        accountTye.text = "Tipo: \(accountData.accountType)"
        accountNumer.text = "Cuenta: \(accountData.accountNumber)"
        accountBank.text = "Banco: \(accountData.bank)"
    }
}
