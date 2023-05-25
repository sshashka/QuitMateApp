//
//  RegistrationViewController.swift
//  QuitMate
//
//  Created by Саша Василенко on 26.04.2023.
//

import UIKit
import Combine

class RegistrationViewController: UIViewController {
    private var viewModel = RegistrationViewModel()
    private var disposeBag = Set<AnyCancellable>()
    private let alreadyHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.font = UIFont(name: FontsEnum.poppinsLight.rawValue, size: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: FontsEnum.poppinsLight.rawValue, size: 14)
        return button
    }()
    
    private lazy var signInStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [alreadyHaveAccountLabel, signInButton])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let passwordConfirmationTextField: CustomTextField  = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setPlaceholderParameters(text: "Password Confirmation")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: ColorConstants.purpleColor)
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, passwordConfirmationTextField, registerButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacings.spacing15
        stackView.distribution = .fillEqually
        stackView.setCustomSpacing(Spacings.spacing30, after: passwordConfirmationTextField)
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signInStackView, textFieldsStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rootStackView)
        view.setBackgroundColor()
        setupConstraints()
        emailTextField.addTarget(self, action: #selector(emailTextFieldTextDidChange), for: .allEditingEvents)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldTextDidChange), for: .allEditingEvents)
        passwordConfirmationTextField.addTarget(self, action: #selector(passwordConfirmationTextFieldTextDidChange), for: .allEditingEvents)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        viewModel.$registerButtonEnabled
            .assign(to: \.isEnabled, on: registerButton)
            .store(in: &disposeBag)
        
        viewModel.$emailTextFieldColor
            .assign(to: \.backgroundColor, on: emailTextField)
            .store(in: &disposeBag)
        
        viewModel.$passwordTextFieldColor
            .assign(to: \.backgroundColor, on: passwordTextField)
            .store(in: &disposeBag)
        
        viewModel.$passwordConfirmationTextFieldColor
            .assign(to: \.backgroundColor, on: passwordTextField)
            .store(in: &disposeBag)
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

private extension RegistrationViewController {
    @objc func emailTextFieldTextDidChange() {
        guard let text = emailTextField.text, text != "" else { return }
        viewModel.email = text
    }
    
    @objc func passwordTextFieldTextDidChange() {
        guard let text = passwordTextField.text, text != "" else { return }
        viewModel.password = text
    }
    
    @objc func passwordConfirmationTextFieldTextDidChange() {
        guard let text = passwordConfirmationTextField.text, text != "" else { return }
        viewModel.confirmationPassword = text
    }
    
    @objc func didTapRegisterButton() {
        viewModel.didTapDoneButton()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            rootStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rootStackView.widthAnchor.constraint(equalToConstant: view.frame.width * (4/5)),
            
            rootStackView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5)
        ])
    }
}
