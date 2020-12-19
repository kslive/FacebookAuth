//
//  ViewManager.swift
//  Facebook Auth
//
//  Created by Eugene Kiselev on 19.12.2020.
//

import UIKit

class ViewManager {
    static let sharedManager = ViewManager()
    
    private init() {}
    
    func showProfile(_ controller: UIViewController) {
        let profileViewController = UIStoryboard(name: String(describing: ProfileViewController.self), bundle: nil).instantiateViewController(withIdentifier: String(describing: ProfileViewController.self)) as! ProfileViewController
        profileViewController.modalPresentationStyle = .fullScreen
        controller.present(profileViewController, animated: true)
    }
    
    func showLogin(_ controller: UIViewController) {
        let loginViewController = UIStoryboard(name: String(describing: LoginViewController.self), bundle: nil).instantiateViewController(withIdentifier: String(describing: LoginViewController.self)) as! LoginViewController
        loginViewController.modalPresentationStyle = .fullScreen
        controller.present(loginViewController, animated: true)
    }
}
