//
//  DetailsViewController.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 19/02/2025.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let imageView = UIImageView()
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        navigationItem.largeTitleDisplayMode = .never
        style()
    }
    
    func style() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 270),
            imageView.heightAnchor.constraint(equalToConstant: 270),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4)
        ])
    }
    
    
}

// MARK: - Configure View with image
extension DetailsViewController {
    struct ViewModel {
        let image: UIImage
    }
    
    func configure(with vm: ViewModel) {
        imageView.image = vm.image
    }
}
