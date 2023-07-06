//
//  ProgressChartsModuleHostingViewController.swift
//  QuitMate
//
//  Created by Саша Василенко on 03.05.2023.
//

import UIKit
import SwiftUI

final class ProgressChartsModuleHostingViewController: UIViewController {

    private let mainScreenView = UIHostingController(rootView: ProgressChartsModuleMainScreen())
    private let qutittingInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Chart for this week"
        label.font = UIFont(name: "Poppins-SemiBold", size: 18)
        label.textColor = UIColor(named: ColorConstants.labelColor)
        label.textAlignment = .left
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.addSubview(qutittingInfoLabel)
        navigationItem.titleView = qutittingInfoLabel
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
