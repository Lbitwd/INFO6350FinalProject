//
//  LoginViewController.swift
//  JobPulse
//
//  Created by Shuya Yang on 12/12/23.
//

import UIKit

class LoginViewController: UIViewController {

    // Other IBOutlet and IBAction connections...

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "logintoMain", sender: self)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "logintoSignup", sender: self)
    }
    
    @IBAction func phoneloginButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "loginWithPhone", sender: self)
    }
    
    @IBAction func backtologinButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "backtoLogin", sender: self)
    }
    
    @IBAction func emailloginButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "loginWithEmail", sender: self)
    }
    
    @IBAction func codeButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "verificationCode", sender: self)
    }
    
    // Other functions...
}
