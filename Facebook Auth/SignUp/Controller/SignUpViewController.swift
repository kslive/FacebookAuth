//
//  SignUpViewController.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 20.12.2020.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

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
        continueButton.addTarget(self, action: #selector(touchedContinueButton), for: .touchUpInside)
    }
    
    private func setupUserNameTF() {
    }
    
    private func setupEmailTF() {
    }
    
    private func setupPasswordTF() {
    }
    
    private func setupConfirmPasswordTF() {
    }
}

extension SignUpViewController {
    @objc
    private func touchedBackButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func touchedContinueButton() {
        
        guard let email = emailTF.text,
              let password = passwordTF.text,
              let userName = userNameTF.text
        else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("SUCCESS NEW USER")
            
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                changeRequest.displayName = userName
                changeRequest.commitChanges { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    print("DISPLAY NAME CHANGE")
                    self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
                }
            }
        }
    }
}
