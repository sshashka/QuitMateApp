//
//  DetectingMoodViewController.swift
//  QuitMate
//
//  Created by Саша Василенко on 18.04.2023.
//

import UIKit

final class MoodClassifierViewController: UIViewController, UINavigationControllerDelegate {
    var presenter: MoodClassifierModulePresenterProtocol?
    
    private let imagePicker: UIImagePickerController = {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.cameraDevice = .front
        vc.cameraCaptureMode = .photo
        return vc
    }()
    
    private let resultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: FontsEnum.poppinsMedium.rawValue, size: 18)
        return label
    }()
    
    private let doneButton: StandartButton = StandartButton(text: "Done")
    
    private let tryAgainButton: StandartButton = StandartButton(text: "Try again")
    
    private let manualMoodSelectionButton: StandartButton = StandartButton(text: "Specify manualy")
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doneButton, tryAgainButton, manualMoodSelectionButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacings.spacing10
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [resultsLabel, UIView.spacer(for: .vertical), buttonsStackView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        view.backgroundColor = .systemBackground
        present(imagePicker, animated: true)
        
        doneButton.addTarget(self, action: #selector(doneButtonDidTap), for: .touchUpInside)
        manualMoodSelectionButton.addTarget(self, action: #selector(manualSelectionButtonDidTap), for: .touchUpInside)
    }
}

private extension MoodClassifierViewController {
    func setupView() {
        view.addSubview(rootStackView)
    }
    
    @objc func doneButtonDidTap() {
        
    }
    
    @objc func manualSelectionButtonDidTap() {
        presenter?.switchToManualClassifierDidTap()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Spacings.spacing30),
            rootStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Spacings.spacing30),
            rootStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Spacings.spacing30),
            // Fix this
            doneButton.heightAnchor.constraint(equalToConstant: 51.6),
            tryAgainButton.heightAnchor.constraint(equalToConstant: 51.6),
            manualMoodSelectionButton.heightAnchor.constraint(equalToConstant: 51.6)
        ])
    }
}

extension MoodClassifierViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        guard let imageData = image.pngData() else { return }
        presenter?.userDidTakePicture(image: imageData)
        imagePicker.dismiss(animated: true)
        setupView()
        setupConstraints()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
}

extension MoodClassifierViewController: MoodClassifierViewControllerProtocol {
    func classifierServiceDidSendResult(result: String) {
        resultsLabel.text = "Your mood has been classified as \(result.lowercased())"
    }
    
    func showValidationFailureAlert(message: String) {
        print(message)
    }
}
