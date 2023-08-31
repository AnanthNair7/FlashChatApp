//
//  LoginViewController.swift
//  FlashChat
//
//  Created by Ananth Nair on 28/08/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class LoginViewController : UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: K.loginSegue , sender: self)
                }
                
            }
        }
    }
    
}
