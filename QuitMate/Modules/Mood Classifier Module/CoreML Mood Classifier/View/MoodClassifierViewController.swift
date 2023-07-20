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
        tryAgainButton.addTarget(self, action: #selector(tryAgainButtonDidTap), for: .touchUpInside)
    }
}

private extension MoodClassifierViewController {
    func setupView() {
        view.addSubview(rootStackView)
    }
    
    @objc func doneButtonDidTap() {
        presenter?.doneButtonDidTap()
    }
    
    @objc func manualSelectionButtonDidTap() {
        presenter?.switchToManualClassifierDidTap()
    }
    
    @objc func tryAgainButtonDidTap() {
        present(imagePicker, animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Spacings.spacing30),
            rootStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Spacings.spacing30),
            rootStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Spacings.spacing30),
            // Fix this
            doneButton.heightAnchor.constraint(equalToConstant: LayoutConstants.uiButtonHeight),
            tryAgainButton.heightAnchor.constraint(equalToConstant: LayoutConstants.uiButtonHeight),
            manualMoodSelectionButton.heightAnchor.constraint(equalToConstant: LayoutConstants.uiButtonHeight)
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
        presenter?.switchToManualClassifierDidTap()
    }
}

extension MoodClassifierViewController: MoodClassifierViewControllerProtocol {
    func classifierServiceDidSendResult(result: String) {
        resultsLabel.text = "Your mood has been classified as \(result.lowercased())"
    }
    // Add actions handling
    func showValidationFailureAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default)
        let dismissAction = UIAlertAction(title: "Go back", style: .destructive)
        
        alert.addAction(retryAction)
        alert.addAction(dismissAction)
        
        present(alert, animated: true)
    }
}
