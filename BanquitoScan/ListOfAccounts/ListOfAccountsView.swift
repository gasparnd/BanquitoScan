//
//  ListOfAccountsView.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 01-06-25.
//

import Foundation
import UIKit

final class ListOfAccountsView: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private var presenter: ListOfAccountsPresenter
    
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
    private let buttonView = UIView()
    
    private let emptyListLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.text = "Sin cuentas agregadas"
        
        return label
    }()
    
    init(presenter: ListOfAccountsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Banquito Scan"
        navigationItem.largeTitleDisplayMode = .always
        setupTableView()
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewAppear()
    }
    
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        emptyListLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        
        view.addSubview(tableView)
        view.addSubview(emptyListLabel)
        
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyListLabel.topAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 3),
            emptyListLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
    }
    
    private func createTableHeader() -> UIView {
        let container = UIView()
        container.backgroundColor = .clear
        
        let button = UIButton(type: .system)
        button.backgroundColor = .accent
        button.layer.cornerRadius = 10
        button.setTitle("Agregar nuevo", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        container.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: container.leadingAnchor, multiplier: 2),
            container.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 2),
            button.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return container
    }
    
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
    
    // This create the ImagePicker with the selected soruceType (gallery or camera roll)
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
            picker.dismiss(animated: true)
            presenter.scanNewAccount(image: selectedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true)
            presenter.scanNewAccount(image: originalImage)
        }
    }
    
}

// MARK: - SET UP TABLE VIEW

extension ListOfAccountsView: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountListCell.self, forCellReuseIdentifier: AccountListCell.reusedID)
        
        let header = createTableHeader()
        let screenWidth = view.bounds.width
        let headerHeight: CGFloat = 70
        header.frame = CGRect(x: 0, y: 0, width: screenWidth, height: headerHeight)
        
        tableView.tableHeaderView = header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountListCell.reusedID, for: indexPath) as! AccountListCell
        let account = presenter.accounts[indexPath.row]
        cell.configure(with: account)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            presenter.onRemoveCell(at: indexPath.row)
            if presenter.accounts.isEmpty {
                emptyListLabel.isHidden = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(at: indexPath.row)
        showToast(message: "Datos copiados", type: .success)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension ListOfAccountsView: ListOfAccountsUI {
    func update(accounts: [AccountEntity]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
