//
//  ViewController.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 19.12.2020.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    private var users: Users?
    
    lazy var facebookLoginButton: UIButton = {
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: view.frame.minX + 32, y: view.frame.midY, width: view.frame.width - 64, height: 50)
        loginButton.delegate = self
        return loginButton
    }()
    
    lazy var customFacebookLoginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.backgroundColor = .red
        loginButton.setTitle("Custom Facebook Login", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.frame = CGRect(x: 32, y: 360, width: view.frame.width - 64, height: 50)
        loginButton.addTarget(self, action: #selector(touchedCustomFBButton), for: .touchUpInside)
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func signIntoFirebase() {
        let accessToken = AccessToken.current
        guard let tokenString = accessToken?.tokenString else { return }
        let credentials = FacebookAuthProvider.credential(withAccessToken: tokenString)
        
        Auth.auth().signIn(with: credentials) { [weak self] (user, error) in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                self.fetchFacebookFields()
            }
        }
    }
    
    private func fetchFacebookFields() {
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start { [weak self] (_, result, error) in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let userData = result as? [String: Any] {
                self.users = Users(data: userData)
                self.saveToFirebase()
            }
        }
    }

    private func saveToFirebase() {
        guard let uId = Auth.auth().currentUser?.uid else { return }
        let userData = ["name": users?.name, "email": users?.email]
        let values = [uId: userData]
        Database.database(url: "https://facebook-auth-2281e-default-rtdb.firebaseio.com/").reference().child("users").updateChildValues(values) { (error, _) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("SUCCESS SAVE")
            self.dismiss(animated: true)
        }
    }
}

extension LoginViewController {
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(facebookLoginButton)
        view.addSubview(customFacebookLoginButton)
    }
}

extension LoginViewController {
    @objc
    private func touchedCustomFBButton() {
        LoginManager().logIn(permissions: ["email","public_profile"], from: self) { [weak self] (loginManager, error) in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                guard let result = loginManager else { return }
                if result.isCancelled {
                    return
                } else {
                    self.signIntoFirebase()
                }
            }
        }
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard AccessToken.isCurrentAccessTokenActive else {
            print(error?.localizedDescription ?? "")
            return
        }
        signIntoFirebase()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {}
}
