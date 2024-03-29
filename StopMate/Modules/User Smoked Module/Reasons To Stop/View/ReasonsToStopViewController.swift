//
//  ResonsToStopView.swift
//  QuitMate
//
//  Created by Саша Василенко on 02.03.2023.
//

import UIKit

final class ReasonsToStopViewController: UIViewController {
    private var reasonsToStopCollectionView: UICollectionView!
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Localizables.UserSmokedModuleStrings.selectUpTenReasons
        label.textColor = .systemGray
        label.numberOfLines = 2
        label.font = UIFont(name: FontsEnum.light.rawValue, size: 16)
        return label
    }()
    var presenter: ReasonsToStopPresenterProtocol?
    private var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localizables.Shared.next, for: .normal)
        button.titleLabel?.font = UIFont(name: FontsEnum.semiBold.rawValue, size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: ColorConstants.buttonsColor)
        button.isEnabled = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, reasonsToStopCollectionView, doneButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private var selectedItems = Set<Int>()
    private var reasonsToStopArray: [ReasonsToStop] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        view.addSubview(rootStackView)
        setupConstraints()
        doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
    }
}

private extension ReasonsToStopViewController {
    
    @objc func didTapDoneButton() {
        presenter?.didTapDoneButton(reasons: Array(selectedItems))
    }
    
    func setupLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
                
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: Spacings.spacing15, leading: 0, bottom: 0, trailing: 0)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    
    func setupCollectionView() {
        reasonsToStopCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setupLayout())
        reasonsToStopCollectionView.translatesAutoresizingMaskIntoConstraints = false
        reasonsToStopCollectionView.allowsMultipleSelection = true
        reasonsToStopCollectionView.register(ReasonsToStopCollectionViewCell.self, forCellWithReuseIdentifier: ReasonsToStopCollectionViewCell.identifier)
        reasonsToStopCollectionView.dataSource = self
        reasonsToStopCollectionView.backgroundColor = .clear
        reasonsToStopCollectionView.allowsMultipleSelection = true
        reasonsToStopCollectionView.delegate = self
        reasonsToStopCollectionView.backgroundColor = .systemBackground
        
        presenter?.showArrayOfReasons()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Spacings.spacing15),
            rootStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Spacings.spacing15),
            rootStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Spacings.spacing15),
            doneButton.heightAnchor.constraint(equalToConstant: LayoutConstants.uiButtonHeight)
        ])
    }
}

extension ReasonsToStopViewController: ReasonsToStopViewProtocol {
    func showReasons(reasons: [ReasonsToStop]) {
        self.reasonsToStopArray = reasons
        reasonsToStopCollectionView.reloadData()
    }
}

extension ReasonsToStopViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReasonsToStopCollectionViewCell.identifier, for: indexPath) as? ReasonsToStopCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        cell.setText(text: reasonsToStopArray[indexPath.row].localizedCase)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reasonsToStopArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if selectedItems.count >= 10 {
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItems.insert(indexPath.item)
        let cell = collectionView.cellForItem(at: indexPath) as? ReasonsToStopCollectionViewCell
        guard let cell = cell else { return }
        cell.handleCellSelectedState()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedItems.remove(indexPath.item)
        let cell = collectionView.cellForItem(at: indexPath) as? ReasonsToStopCollectionViewCell
        guard let cell = cell else { return }
        cell.handleCellDeselectedState()
    }
}
