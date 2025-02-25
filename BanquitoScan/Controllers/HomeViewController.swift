//
//  HomeViewController.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 24/01/2025.
//

import UIKit

class HomeViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let stackView = UIStackView()
    
    private let button: UIButton =  {
        let button = UIButton()
        
        button.backgroundColor = .white
        button.setTitle("Add new Account", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        title = "Home"
        style()
        layout()
    }
}

extension HomeViewController {
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        stackView.addArrangedSubview(button)
        
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    // MARK: - ACTIONS
    
    @objc func didTapButton() {
        let alert = UIAlertController(title: "Seleccionar Imagen", message: "Elige una opción", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Tomar Foto", style: .default) { _ in
            self.openImagePicker(sourceType: .camera)
        }
        
        let galleryAction = UIAlertAction(title: "Abrir Galería", style: .default) { _ in
            self.openImagePicker(sourceType: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    // This create the ImagePicjer with the selected soruceType (gallery or camera roll)
    func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            print("El tipo de fuente no está disponible en este dispositivo.")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            seeDetails(image: selectedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            seeDetails(image: originalImage)
        }
        
        picker.dismiss(animated: true)
    }
    
    func seeDetails(image: UIImage) {
        let vc = DetailsViewController()
        let vm = DetailsViewController.ViewModel(image: image)
        vc.configure(with:vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


