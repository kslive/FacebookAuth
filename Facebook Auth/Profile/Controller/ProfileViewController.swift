//
//  ProfileViewController.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 19.12.2020.
//

import UIKit
import FBSDKLoginKit

class ProfileViewController: UIViewController {

    lazy var logoutButton: UIButton = {
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: view.frame.minX + 32, y: view.frame.midY, width: view.frame.width - 64, height: 50)
        loginButton.delegate = self
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkStatusAuth()
    }
    
    private func checkStatusAuth() {
        if !(AccessToken.isCurrentAccessTokenActive) {
            ViewManager.sharedManager.showLogin(self)
        }
    }
}

extension ProfileViewController {
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(logoutButton)
    }
}

extension ProfileViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {}
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // проверяем на отсутсиве активного токена авторизации
        guard !AccessToken.isCurrentAccessTokenActive else { return }
        ViewManager.sharedManager.showLogin(self)
    }
}
