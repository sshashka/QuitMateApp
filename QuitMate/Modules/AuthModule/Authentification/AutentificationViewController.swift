//
//  ViewController.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.02.2023.
//

import UIKit
import Combine
import SwiftUI


final class AutentificationViewController: UIViewController {
    var presenter: AuthentificationModulePresenterProtocol?
    
    // MARK: Creating UI elements
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = AuthentificationModuleConstants.headerLabel()
        label.textAlignment = .center
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(AuthentificationModuleConstants.signUpForFreeButtonTitle(), for: .normal)
        button.setTitleColor(UIColor(named: ColorConstants.purpleColor), for: .normal)
        button.isEnabled = true
        return button
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, registerButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setPlaceholderParameters(text: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setPlaceholderParameters(text: "Password at least 8 characters")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: ColorConstants.purpleColor)
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: Setting up buttons and textFields stackView
    private lazy var buttonsAndTextFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.setCustomSpacing(32, after: passwordTextField)
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerStackView, buttonsAndTextFieldsStackView])
        stackView.spacing = LayoutConstants.spacing16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private var cancellables = Set<AnyCancellable>()
    // MARK: Init subjects
    private var emailSubject = CurrentValueSubject<String, Never>("")
    private var passwordSubject = CurrentValueSubject<String, Never>("")
    
    // MARK: Publishers
    private var emailIsValid: AnyPublisher<Bool, Never> {
        emailSubject
            .map{ [weak self] in
                self?.emailIsValid(email: $0)
            }
            .replaceNil(with: false)
            .eraseToAnyPublisher()
        
    }
    
    private var passwordIsValid: AnyPublisher<Bool, Never> {
        passwordSubject
            .map{ [weak self] in
                self?.passwordIsValid(password: $0)
            }
            .replaceNil(with: false)
            .eraseToAnyPublisher()
    }
    
    private var formIsValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(emailIsValid, passwordIsValid)
            .map{ $0.0 && $0.1 }
            .eraseToAnyPublisher()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor()
        view.addSubview(rootStackView)
        setupConstraints()
        
        registerButton.addTarget(self, action: #selector(registerButtonDidTap), for: .touchUpInside)
        
        emailTextField.addTarget(self, action: #selector(emailTextDidChange), for: .allEditingEvents)
        passwordTextField.addTarget(self, action: #selector(passwordTextDidChange), for: .allEditingEvents)
        loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        
        formIsValid
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &cancellables)
    }
    
    deinit {
        print("AuthVC deinit")
    }
}

private extension AutentificationViewController {
    // MARK: Setting up view
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            rootStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rootStackView.widthAnchor.constraint(equalToConstant: view.frame.width * (4/5)),
            
            rootStackView.heightAnchor.constraint(equalToConstant: view.frame.height/3)
        ])
    }
    // MARK: Adding selectors to UI
    @objc func loginButtonDidTap() {
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        presenter?.didSelectLoginWithEmailLogin(email: emailText, password: passwordText)
    }
    
    @objc func registerButtonDidTap() {
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
    
    @objc func emailTextDidChange(_ sender: UITextField) {
        emailSubject.send(sender.text ?? "")
    }
    
    @objc func passwordTextDidChange(_ sender: UITextField) {
        passwordSubject.send(sender.text ?? "")
    }
    
    func emailIsValid(email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    func passwordIsValid(password: String) -> Bool {
        return password.count >= 8
    }
    
    
}

extension AutentificationViewController: AutentificationLoginViewControllerProtocol {
    func didReceiveErrorFromFirebaseAuth(error: String) {
        let alert = UIAlertController(title: "OOPS", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func didRegisterSuccesfully(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}


struct AuthViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return AutentificationViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct AuthViewControllerPreview: PreviewProvider {
    static var previews: some View {
        AuthViewControllerRepresentable()
    }
}
