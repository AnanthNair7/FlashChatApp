//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Ananth Nair on 28/08/23.
//

import UIKit
import FirebaseAuth
class RegisterViewController : UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if  let email =  emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    // Navigate to chatViewController
                    self.performSegue(withIdentifier:K.registerSegue, sender:self )
                }
                
            }
        }
       
    }
        
    }
    
    

