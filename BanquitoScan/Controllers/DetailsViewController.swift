//
//  DetailsViewController.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 19/02/2025.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var bankAccountInfo: BankAccountInfo? = nil
    private let scanner = BankAccountScanner()
    
    private let loader = UIActivityIndicatorView(style: .medium)
    
    private let imageView = UIImageView()
    private var image = UIImage()
    
    private let infoView = UIStackView()
    
    private let nameLabel = UILabel()
    private let rutLabel = UILabel()
    private let emailLabel = UILabel()
    private let accountTye = UILabel()
    private let accountNumer = UILabel()
    private let accountBank = UILabel()
    
    private let button: UIButton =  {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .accent
        button.layer.cornerRadius = 8
        button.setTitle("Copiar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalles"
        navigationItem.largeTitleDisplayMode = .never
        startLoading()
        style()
    }
    
    func style() {
        // Image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        // Loader
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        view.addSubview(loader)
        
        // Labels
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
        infoView.addArrangedSubview(accountTye)
        infoView.addArrangedSubview(accountNumer)
        infoView.addArrangedSubview(accountBank)
        infoView.isHidden = true
        
        view.addSubview(infoView)
        
        // Copy Button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.isHidden = true
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 270),
            imageView.heightAnchor.constraint(equalToConstant: 270),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
            loader.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 4),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoView.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 4),
            infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalToSystemSpacingBelow: infoView.bottomAnchor, multiplier: 3),
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            button.heightAnchor.constraint(equalToConstant: 40),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 4)
        ])
    }
    
    func startLoading() {
        infoView.isHidden = true
        loader.startAnimating()
    }
    
    func stopLoading() {
        loader.stopAnimating()
        infoView.isHidden = false
    }
    
    private func updateUI(_ info: BankAccountInfo?) {
        guard let accountData = info else { return }
        var name = ""
        var email = ""

        
        if let nameVale = accountData.name {
            name = "Nombre: \(nameVale)"
        }
        if let emailVale = accountData.email {
            email = "Email: \(emailVale)"
        }
        
        bankAccountInfo = accountData
        nameLabel.text = name
        rutLabel.text = "RUT: \(accountData.rut)"
        emailLabel.text = email
        accountTye.text = "Tipo: \(accountData.accountType)"
        accountNumer.text = "Cuenta: \(accountData.accountNumber)"
        accountBank.text = "Banco: \(accountData.bank)"
        stopLoading()
        button.isHidden = false
    }
    
}

// MARK: - ACTIONS

extension DetailsViewController {
    @objc func didTapButton() {
        let info = bankAccountInfo?.formattedInfo()
        UIPasteboard.general.string = info
    }
}

// MARK: - Configure View with image
extension DetailsViewController {
    struct ViewModel {
        let image: UIImage
    }
    
    func configure(with vm: ViewModel) {
        imageView.image = vm.image
        
        scanner.extractBankAccountInfo(from: vm.image) { info in
            DispatchQueue.main.async {
                self.bankAccountInfo = info
                self.updateUI(info)
            }
        }
    }
}
