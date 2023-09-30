//
//  SettingsTableViewCell.swift
//  QuitMate
//
//  Created by Саша Василенко on 11.04.2023.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"
    private let settingsTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontsEnum.light.rawValue, size: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(settingsTextLabel)
        self.backgroundColor = .clear
        self.accessoryType = .disclosureIndicator
        settingsTextLabel.frame = contentView.frame
        
        
    }
    
    func setText(text: String) {
        settingsTextLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
