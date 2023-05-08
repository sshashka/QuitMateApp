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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainScreenView.view)
        addChild(mainScreenView)
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
