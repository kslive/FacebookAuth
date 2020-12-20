//
//  ProfileViewController.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 19.12.2020.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchingUserData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkStatusAuth()
    }
    
    private func checkStatusAuth() {
        if Auth.auth().currentUser == nil {
            ViewManager.sharedManager.showLogin(self)
        }
    }
    
    private func fetchingUserData() {
        if Auth.auth().currentUser != nil {
            guard let uId = Auth.auth().currentUser?.uid else { return }
            Database.database(url: "https://facebook-auth-2281e-default-rtdb.firebaseio.com/")
                .reference()
                .child("users")
                .child(uId)
                .observeSingleEvent(of: .value) { [weak self] (snapshot) in
                    guard let self = self else { return }
                    guard let userData = snapshot.value as? [String: Any] else { return }
                    let currentUser = CurrentUser(uId: uId, data: userData)
                    self.nameLabel.text = currentUser?.name ?? "NO NAME"
                } withCancel: { (error) in
                    print(error.localizedDescription)
                }

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
        guard !AccessToken.isCurrentAccessTokenActive else { return }
        do {
            try Auth.auth().signOut()
            ViewManager.sharedManager.showLogin(self)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
