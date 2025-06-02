//
//  ScanNewAccountView.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

final class ScanNewAccountView: UIViewController {
    private var presenter: ScanNewAccountPresenter
    private var image: UIImage
    
    private let loader = UIActivityIndicatorView(style: .medium)
    private let imageView = UIImageView()
    private let accountInfoView = AccountInfoView()
    private let buttonsView = ActionButtonsView()
    
    init(presenter: ScanNewAccountPresenter, image: UIImage) {
        self.presenter = presenter
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalles"
        navigationItem.largeTitleDisplayMode = .never
        startLoading()
        style()
        scanImge()
        
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
        
        // Buttons
        buttonsView.isHidden = true
        
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 270),
            imageView.heightAnchor.constraint(equalToConstant: 270),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
            loader.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 4),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountInfoView.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 3),
            accountInfoView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            buttonsView.topAnchor.constraint(equalToSystemSpacingBelow: accountInfoView.bottomAnchor, multiplier: 3),
            buttonsView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: buttonsView.trailingAnchor, multiplier: 3)
        ])
    }
    
    func startLoading() {
        accountInfoView.isHidden = true
        buttonsView.isHidden = true
        loader.startAnimating()
    }
    
    func stopLoading() {
        loader.stopAnimating()
    }
    
    func scanImge() {
        presenter.getAccountInfo(from: image)
    }
}

extension ScanNewAccountView: ScanNewAccountUI {
    func update(witn account: AccountEntity?) {
        DispatchQueue.main.async {
//            self.bankAccountInfo = info
//            self.updateUI(info)
        }
    }
}

//extension DetailsViewController {
//    struct ViewModel {
//        let image: UIImage
//    }
//    
//    func configure(with vm: ViewModel) {
//        imageView.image = vm.image
//        
//        scanner.extractBankAccountInfo(from: vm.image) { info in
//            DispatchQueue.main.async {
//                self.bankAccountInfo = info
//                self.updateUI(info)
//            }
//        }
//    }
//}
