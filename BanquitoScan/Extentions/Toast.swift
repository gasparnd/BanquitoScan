//
//  Toast.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 27/02/2025.
//

import UIKit

enum ToastTypes: String {
    case success
    case error
    case normal
}

protocol ToastDelegate: AnyObject {
    func didShowToast(message: String, type: ToastTypes)
    
}

extension UIViewController {
    func showToast(message: String, type: ToastTypes) {
        var color: UIColor?
        var textColor: UIColor?
        
        switch type {
        case .success:
            color = UIColor.systemGreen
            textColor = .white
        case .error:
            color = UIColor.systemRed
            textColor = .white
        default:
            color = UIColor.systemGray
            textColor = .black
        }
        
        let toastView = UIView()
        toastView.backgroundColor = color
        toastView.layer.cornerRadius = 20
        toastView.clipsToBounds = true
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        let label = UILabel()
        label.text = message
        label.textColor = textColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        toastView.addSubview(label)
        self.view.addSubview(toastView)
        
        // Toas View constrainst
        NSLayoutConstraint.activate([
            toastView.topAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            toastView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 7),
            self.view.trailingAnchor.constraint(equalToSystemSpacingAfter: toastView.trailingAnchor, multiplier: 7),
            toastView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            toastView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // Label constrainst
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: toastView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: toastView.centerYAnchor)
        ])
        
        // Animation appears
        toastView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            toastView.alpha = 1
        }) { _ in
            // Disappears after 1.5 seconds
            UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseOut, animations: {
                toastView.alpha = 0
            }) { _ in
                toastView.removeFromSuperview()
            }
        }
    }
}

extension UIViewController: ToastDelegate {
    func didShowToast(message: String, type: ToastTypes) {
        self.showToast(message: message, type: type)
    }
}
