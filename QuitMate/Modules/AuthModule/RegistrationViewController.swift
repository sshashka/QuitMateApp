//
//  RegistrationViewController.swift
//  QuitMate
//
//  Created by Саша Василенко on 26.04.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
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
    
    private let nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setPlaceholderParameters(text: "Name")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let surnameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setPlaceholderParameters(text: "Name")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
