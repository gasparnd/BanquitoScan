//
//  ActionButtonsView.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 11/03/2025.
//

import UIKit

class ActionButtonsView: UIView {
    
    let coreData: CoreDataManager = CoreDataManager.shared
    
    var accountInfo: BankAccountInfo?
    
    private let saveButton: UIButton =  {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .accent
        button.layer.cornerRadius = 10
        button.setTitle("Guardar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let copyButton: UIButton =  {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "doc.on.doc")
        
        button.setImage(image, for: .normal)
        button.backgroundColor = UIColor.accent.withAlphaComponent(0.3)
        button.layer.cornerRadius = 10
        button.setTitleColor(.accent, for: .normal)
        
        return button
    }()
    
    private let shareButton: UIButton =  {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "square.and.arrow.up")
        
        button.setImage(image, for: .normal)
        button.backgroundColor = UIColor.accent.withAlphaComponent(0.3)
        button.layer.cornerRadius = 10
        button.setTitleColor(.accent, for: .normal)
        
        return button
    }()
    
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func configure(with info: BankAccountInfo) {
        accountInfo = info
    }
}

extension ActionButtonsView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // Copy button
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.addTarget(self, action: #selector(didTapCopyButton), for: .touchUpInside)
        
        // Share button
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        
        // Save button
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        stackView.addArrangedSubview(copyButton)
        stackView.addArrangedSubview(shareButton)
        
        addSubview(stackView)
        addSubview(saveButton)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            copyButton.topAnchor.constraint(equalTo: topAnchor),
            copyButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            copyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            copyButton.heightAnchor.constraint(equalToConstant: 35),
            
            shareButton.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: shareButton.trailingAnchor, multiplier: 1),
            shareButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            shareButton.heightAnchor.constraint(equalToConstant: 35),
            
            saveButton.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            saveButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: saveButton.trailingAnchor, multiplier: 1),
            saveButton.heightAnchor.constraint(equalToConstant: 35),
            
        ])
    }
    
}

// MARK: - ACTIONS
extension ActionButtonsView {
    @objc func didTapCopyButton() {
        copyInClipboard(string: accountInfo!.formattedInfo())
        triggerHapticFeedback(type: .success)
    }
    
    @objc func didTapSaveButton() {
        coreData.crearAccount(with: accountInfo!)
        triggerHapticFeedback(type: .warning)
    }
    
    @objc func didTapShareButton() {
        
    }
   
}
