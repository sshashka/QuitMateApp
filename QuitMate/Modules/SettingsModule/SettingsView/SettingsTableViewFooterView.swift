//
//  SettingsTableViewFooterView.swift
//  QuitMate
//
//  Created by Саша Василенко on 11.04.2023.
//

import UIKit

class SettingsTableViewFooterView: UIView {
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoutButton)
        logoutButton.frame = self.frame
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingsTableViewFooterView {
    func setupView() {
        self.layer.cornerRadius = LayoutConstants.cornerRadius
        
    }
}
