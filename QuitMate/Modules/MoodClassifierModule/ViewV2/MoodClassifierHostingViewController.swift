//
//  MoodClassifierHostingViewController.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import UIKit
import SwiftUI

class MoodClassifierHostingViewController: UIViewController {
    private let mainScreenView = UIHostingController(rootView: MoodClassifierMainScreenView())
    private let imagePicker: UIImagePickerController = {
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.cameraDevice = .front
            return vc
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainScreenView.view)
        addChild(mainScreenView)
        imagePicker.delegate = self
        mainScreenView.view.translatesAutoresizingMaskIntoConstraints = false
        mainScreenView.didMove(toParent: self)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainScreenView.view.topAnchor.constraint(equalTo: view.topAnchor),
            mainScreenView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScreenView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainScreenView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension MoodClassifierHostingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        guard let imageData = image.pngData() else { return }
//        presenter?.userDidTakePicture(image: imageData)
        imagePicker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
}

//extension MoodClassifierViewController: MoodClassifierViewControllerProtocol {
//    func classifierServiceSentSuccess() {
//        print("fuck you")
//    }
//
//    func showValidationFailureAlert(message: String) {
//        print(message)
//    }
//}
