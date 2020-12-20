//
//  SignInViewController.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 20.12.2020.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension SignInViewController {
    private func setup() {
        setupContinueButton()
        setupBackButton()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
    }
    
    private func setupBackButton() {
        backButton.addTarget(self, action: #selector(touchedBackButton), for: .touchUpInside)
    }
    
    private func setupContinueButton() {
        continueButton.isEnabled = false
        continueButton.addTarget(self, action: #selector(touchedContinueButton), for: .touchUpInside)
    }
    
    private func setupSignUpButton() {
        signUpButton.addTarget(self, action: #selector(touchedSignInButton), for: .touchUpInside)
    }
    
    private func setupEmailTextField() {
        emailTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
    }
    
    private func setupPasswordTextField() {
        passwordTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
    }
}

extension SignInViewController {
    @objc
    private func touchedBackButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func touchedSignInButton() {
        ViewManager.sharedManager.showSignUp(self)
    }
    
    @objc
    private func touchedContinueButton() {
        
    }
    
    @objc
    private func textFieldsChanged() {
        
    }
}
