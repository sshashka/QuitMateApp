//
//  emailTextField.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import UIKit

final class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.setPlaceholderParameters(text: "Email address")
        self.layer.cornerRadius = LayoutConstants.cornerRadius
        self.layer.masksToBounds = true
//        self.keyboardType = .emailAddress
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.textColor = .black
        self.setLeftPaddingPoints(20)
        self.setRightPaddingPoints(20)
        self.backgroundColor = .lightGray
//        self.makeGlassEffectOnView(style: .extraLight)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
