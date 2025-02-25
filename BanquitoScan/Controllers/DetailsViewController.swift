//
//  DetailsViewController.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 19/02/2025.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var bankAccountInfo: BankAccountInfo? = nil
    let scanner = BankAccountScanner()
    
    let loader = UIActivityIndicatorView(style: .medium)
    
    let imageView = UIImageView()
    var image = UIImage()
    
    let infoView = UIStackView()
    
    let nameLabel = UILabel()
    let rutLabel = UILabel()
    let emailLabel = UILabel()
    let accountTye = UILabel()
    let accountNumer = UILabel()
    let accountBank = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
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
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 270),
            imageView.heightAnchor.constraint(equalToConstant: 270),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
            loader.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 4),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoView.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 4),
            infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
        nameLabel.text = "Nombre: \(accountData.name)"
        rutLabel.text = "RUT: \(accountData.rut)"
        emailLabel.text = "Enail: \(String(describing: accountData.email))"
        accountTye.text = "Tipo: \(accountData.accountType)"
        accountNumer.text = "Cuenta: \(accountData.accountNumber)"
        accountBank.text = "Banco: \(accountData.bank)"
        stopLoading()
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
