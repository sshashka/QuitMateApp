//
//  SettingsViewController.swift
//  QuitMate
//
//  Created by Саша Василенко on 11.04.2023.
//

import UIKit
import SwiftUI
import Combine

final class SettingsViewController: UIViewController {
    private let settingsLabels: [String] = ["Change password", "Terms and conditions", "About app", "Add new mood", "Watch your history"]
    private let gradientLayer = CAGradientLayer()
    private var viewModel: SettingsViewModel?
    private var disposeBag = Set<AnyCancellable>()
    private let settingsTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        return tv
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingsTableView])
        stackView.axis = .vertical
        stackView.spacing = Spacings.spacing15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rootStackView)
        view.backgroundColor = .systemBackground
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
//        setupHeaderProfileView()
        setupEditButton()
        setupConstraints()
        guard let viewModel = viewModel else { return }
        setupHeaderProfileView(viewModel: viewModel.headerViewModel)
    }
    
    init(viewModel: SettingsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingsViewController {
    func setupHeaderProfileView(viewModel: HeaderViewViewModel) {
        let profileHeaderView = UIHostingController(rootView: SettingsViewProfileHeaderView(viewModel: viewModel))
        addChild(profileHeaderView)
        profileHeaderView.didMove(toParent: self)
        profileHeaderView.view.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.insertArrangedSubview(profileHeaderView.view, at: 0)
        NSLayoutConstraint.activate([
            profileHeaderView.view.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ])
    }
    
    func setupEditButton() {
        let button = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonDidTap))
        self.navigationItem.rightBarButtonItems = [button]
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: view.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacings.spacing20),
            rootStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacings.spacing20),
        ])
    }
    
    
    func didSelectPasswordReset() {
        let alert = UIAlertController(title: "Do you want to reset your password?", message: "Note: еhis action cannot be undone ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Sure", style: .destructive) { [weak self] _ in
            self?.viewModel?.resetPassword()
            self?.showPasswordResetAlert()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func showPasswordResetAlert() {
        let alert = UIAlertController(title: "Password reset message has been sent", message: "Please check your email for instructions", preferredStyle: .alert)
    }
    
    @objc func editButtonDidTap() {
        viewModel?.didTapOnEdit()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        cell.setText(text: settingsLabels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            didSelectPasswordReset()
        case 1:
            print()
        case 2:
            print()
        case 3:
            viewModel?.didTapOnAddingMood()
        case 4:
            viewModel?.didTapOnHistory()
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = SettingsTableViewFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
}

extension SettingsViewController: SettingsTableViewFooterViewDelegate {
    func didTapLogout() {
        viewModel?.didTapLogout()
    }
}
