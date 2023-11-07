//
//  StandartButton.swift
//  QuitMate
//
//  Created by Саша Василенко on 26.06.2023.
//

import UIKit

class StandartButton: UIButton {
    private var text: String
    init(text: String) {
        self.text = text
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.backgroundColor = UIColor(named: ColorConstants.buttonsColor)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont(name: FontsEnum.semiBold.rawValue, size: 14)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = LayoutConstants.cornerRadius
//        self.heightAnchor.constraint(equalToConstant: LayoutConstants.uiButtonHeight)
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
