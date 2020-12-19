//
//  ViewController.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 19.12.2020.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    lazy var facebookLoginButton: UIButton = {
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: view.frame.minX + 32, y: view.frame.midY, width: view.frame.width - 64, height: 50)
        loginButton.delegate = self
        return loginButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension LoginViewController {
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(facebookLoginButton)
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard AccessToken.isCurrentAccessTokenActive else {
            print(error?.localizedDescription ?? "")
            return
        }
        dismiss(animated: true)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {}
}
