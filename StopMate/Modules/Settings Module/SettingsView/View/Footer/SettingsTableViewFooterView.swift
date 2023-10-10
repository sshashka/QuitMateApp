//
//  SettingsTableViewFooterView.swift
//  QuitMate
//
//  Created by Саша Василенко on 11.04.2023.
//

import UIKit

protocol SettingsTableViewFooterViewDelegate: AnyObject {
    func didTapLogout()
}

final class SettingsTableViewFooterView: UIView {
    weak var delegate: SettingsTableViewFooterViewDelegate?
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localizables.SettingsStrings.logout, for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(logoutButton)
        logoutButton.frame = bounds
        logoutButton.addTarget(self, action: #selector(didTapOnSignOut), for: .touchUpInside)
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
    // Wrong, needs delegation or combine way
    @objc func didTapOnSignOut() {
        delegate?.didTapLogout()
    }
}
