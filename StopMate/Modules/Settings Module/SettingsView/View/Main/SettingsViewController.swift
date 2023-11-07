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
    private let settingsLabels: [String] = [Localizables.SettingsStrings.changePassword, Localizables.SettingsStrings.termsAndConditions, Localizables.SettingsStrings.privacyPolicy, Localizables.SettingsStrings.watchYourHistory, Localizables.OnboardingStrings.onboardingHeader, Localizables.SettingsStrings.deleteAccuont]
    private var viewModel: SettingsViewModelProtocol?
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
        setupEditButton()
        setupConstraints()
        guard let viewModel = viewModel else { return }
        setupHeaderProfileView(viewModel: viewModel.headerViewModel)
        viewModel.isShowingAlertPublisher
            .receive(on: RunLoop.main)
            .sink {[weak self] bool in
            guard bool == true else { return }
            self?.showAlert()
        }.store(in: &disposeBag)
    }
    
    init(viewModel: SettingsViewModelProtocol) {
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
            profileHeaderView.view.heightAnchor.constraint(equalToConstant: view.frame.height / 2.5)
        ])
    }
    
    func setupEditButton() {
        let button = UIBarButtonItem(title: Localizables.SettingsStrings.edit, style: .plain, target: self, action: #selector(editButtonDidTap))
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
        let alert = UIAlertController(title: nil, message: Localizables.SettingsStrings.resetPasswordPromt, preferredStyle: .alert)
        let action = UIAlertAction(title: Localizables.Shared.sure, style: .destructive) { [weak self] _ in
            self?.viewModel?.resetPassword()
            self?.showPasswordResetAlert()
        }
        let cancelAction = UIAlertAction(title: Localizables.Shared.cancel, style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: viewModel?.errorText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizables.Shared.ok, style: .default) { [weak self] _ in
            self?.viewModel?.isShowingAlert.toggle()
        })
        
        present(alert, animated: true)
    }
    
    func showPasswordResetAlert() {
        let alert = UIAlertController(title: Localizables.SettingsStrings.passwordResetAlertTitle, message: Localizables.SettingsStrings.passwordResetAlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizables.Shared.ok, style: .default))
        
        present(alert, animated: true)
    }
    
    func showDeleteAccountAlert() {
        let alert = UIAlertController(title: nil, message: Localizables.SettingsStrings.accountDeleteMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizables.Shared.yes, style: .destructive) {[weak self] _ in
            self?.viewModel?.didTapOnAccountDelete()
        })
        alert.addAction(UIAlertAction(title: Localizables.Shared.no, style: .cancel))
        present(alert, animated: true)
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
            let vc = TermsAndConditionsView()
            vc.selectedURL = PrivacyPolicyAndTermsAndConditionsURL.termsAndConditions
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = TermsAndConditionsView()
            vc.selectedURL = PrivacyPolicyAndTermsAndConditionsURL.privacyPolicy
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            viewModel?.didTapOnHistory()
        case 4:
            viewModel?.didTapOnOnboarding()
        case 5:
            showDeleteAccountAlert()
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = SettingsTableViewFooterView(frame: CGRect(x: .zero, y: .zero, width: tableView.frame.width, height: Spacings.spacing40))
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Spacings.spacing40
    }
}

extension SettingsViewController: SettingsTableViewFooterViewDelegate {
    func didTapLogout() {
        viewModel?.didTapLogout()
    }
}
