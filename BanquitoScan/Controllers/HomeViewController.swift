//
//  HomeViewController.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 24/01/2025.
//

import UIKit

class HomeViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let coreData: CoreDataManager = CoreDataManager.shared
    private var data: [Account] = []
    
    private let tableView = UITableView()
    
    private let stackView = UIStackView()
    
    private let button: UIButton =  {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .accent
        button.layer.cornerRadius = 10
        button.setTitle("Agregar nuevo", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let emptyListLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.text = "Sin cuentas agregadas"
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        title = "Inicio"
        
        setupTableView()
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        emptyListLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        
        view.addSubview(button)
        view.addSubview(tableView)
        view.addSubview(emptyListLabel)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 2),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3),
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 2),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyListLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyListLabel.topAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 8)
            
        ])
        
    }
}

// MARK: - SET UP TABLE VIEW

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountListCell.self, forCellReuseIdentifier: AccountListCell.reusedID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountListCell.reusedID, for: indexPath) as! AccountListCell
        let account = data[indexPath.row]
        cell.configure(with: account)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coreData.removeAccount(account: data[indexPath.row])
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if data.isEmpty {
                emptyListLabel.isHidden = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = data[indexPath.row]
        
        let accountInfo = BankAccountInfo(name: account.name, rut: account.rut ?? "", accountType: account.accountType ?? "", accountNumber: account.accountNumber!, bank: account.bank ?? "", email: account.email).formattedInfo()
        
        UIPasteboard.general.string = accountInfo
        showToast(message: "Datos copiados", type: .success)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController {
    
    // MARK: - LOAD DATA
    
    private func loadData() {
        let result = coreData.getAccounts()
        
        if !result.isEmpty {
            data = result
            tableView.reloadData()
            emptyListLabel.isHidden = true
        }
        
        
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


