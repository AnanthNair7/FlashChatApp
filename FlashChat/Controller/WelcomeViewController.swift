//
//  ViewController.swift
//  FlashChat
//
//  Created by Ananth Nair on 28/08/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        var charIndex = 0.0
        let titletext = K.appName
        for letter in titletext {
//            print("-")
//            print(0.1 * charIndex)
//            print(letter)
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
    }
    
    


}

