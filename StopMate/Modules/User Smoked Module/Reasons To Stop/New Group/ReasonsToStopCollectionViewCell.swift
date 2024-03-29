//
//  ReasonsToStopCollectionViewCell.swift
//  QuitMate
//
//  Created by Саша Василенко on 02.03.2023.
//

import UIKit

final class ReasonsToStopCollectionViewCell: UICollectionViewCell {
    static let identifier = "ReasonsToStopCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.setPoppinsFont(size: 18, style: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(text: String) {
        label.text = text
    }
    
    func handleCellSelectedState() {
        contentView.backgroundColor = .systemGreen
    }
    
    func handleCellDeselectedState() {
        contentView.backgroundColor = .lightGray
    }
}

private extension ReasonsToStopCollectionViewCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func setupContentView() {
        contentView.backgroundColor = .systemGray
        contentView.addSubview(label)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 7
    }
}
