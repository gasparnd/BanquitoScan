//
//  AccountListCell.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 08/03/2025.
//

import UIKit

final class AccountListCell: UITableViewCell {
    
    static let reusedID = "accountCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let bankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        bankLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bankLabel)
        
        NSLayoutConstraint.activate([
              nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
              nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
              nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
              
              bankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
              bankLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
              bankLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
              bankLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8) // ✅ Fija el bottom para que la celda tenga una altura bien definida
          ])
        
    }
    
    func configure(with account: Account) {
        nameLabel.text = account.name
        bankLabel.text = account.bank
    }
}
