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
    
    private let coreData: CoreDataManager = CoreDataManager.shared
    
    private let loader = UIActivityIndicatorView(style: .medium)
    
    private let imageView = UIImageView()
    private var image = UIImage()
    
    private let accountInfoView = AccountInfoView()
    
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
        accountInfoView.translatesAutoresizingMaskIntoConstraints = false
        accountInfoView.isHidden = true
        view.addSubview(accountInfoView)
        
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
            accountInfoView.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 3),
            accountInfoView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            button.topAnchor.constraint(equalToSystemSpacingBelow: accountInfoView.bottomAnchor, multiplier: 3),
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            button.heightAnchor.constraint(equalToConstant: 40),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 4)
        ])
    }
    
    func startLoading() {
        accountInfoView.isHidden = true
        loader.startAnimating()
    }
    
    func stopLoading() {
        loader.stopAnimating()
        accountInfoView.isHidden = false
    }
    
    private func updateUI(_ info: BankAccountInfo?) {
        guard let accountData = info else {
            stopLoading()
            let alert = UIAlertController(title: "Lo sentimos", message: "No se pudo extraer la información de la imagen. Intenta nuevamente con una imagen más clara y bien iluminada.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
            return
        }
        
        
        bankAccountInfo = accountData
        accountInfoView.configure(with: accountData)
        
        stopLoading()
        
        button.isHidden = false
    }
    
}

// MARK: - ACTIONS

extension DetailsViewController {
    @objc func didTapButton() {
        let info = bankAccountInfo?.formattedInfo()
        UIPasteboard.general.string = info
        copyInClipboard(string: info!)
        showToast(message: "Datos copiados", type: .success)
        coreData.crearAccount(with: bankAccountInfo!)
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
