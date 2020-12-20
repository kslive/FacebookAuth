//
//  SignInViewController.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 20.12.2020.
//

import UIKit
import Firebase

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
        setupSignUpButton()
    }
    
    private func setupBackButton() {
        backButton.addTarget(self, action: #selector(touchedBackButton), for: .touchUpInside)
    }
    
    private func setupContinueButton() {
        continueButton.addTarget(self, action: #selector(touchedContinueButton), for: .touchUpInside)
    }
    
    private func setupSignUpButton() {
        signUpButton.addTarget(self, action: #selector(touchedSignInButton), for: .touchUpInside)
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
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("SUCCESS LOGIN WITH EMAIL")
            self.presentingViewController?.presentingViewController?.dismiss(animated: true)
        }
    }
}
