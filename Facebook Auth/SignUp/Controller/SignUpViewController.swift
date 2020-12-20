//
//  SignUpViewController.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 20.12.2020.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension SignUpViewController {
    private func setup() {
        setupBackButton()
        setupContinueButton()
        setupUserNameTF()
        setupEmailTF()
        setupPasswordTF()
        setupConfirmPasswordTF()
    }
    
    private func setupBackButton() {
        backButton.addTarget(self, action: #selector(touchedBackButton), for: .touchUpInside)
    }
    
    private func setupContinueButton() {
        continueButton.isEnabled = false
        continueButton.addTarget(self, action: #selector(touchedContinueButton), for: .touchUpInside)
    }
    
    private func setupUserNameTF() {
        userNameTF.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
    }
    
    private func setupEmailTF() {
        emailTF.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
    }
    
    private func setupPasswordTF() {
        passwordTF.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
    }
    
    private func setupConfirmPasswordTF() {
        confirmPasswordTF.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
    }
}

extension SignUpViewController {
    @objc
    private func touchedBackButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func touchedContinueButton() {
        
    }
    
    @objc
    private func textFieldsChanged() {
        
    }
}
