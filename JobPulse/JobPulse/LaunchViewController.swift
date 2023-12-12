//
//  LaunchViewController.swift
//  JobPulse
//
//  Created by Shuya Yang on 12/12/23.
//

import UIKit

class LaunchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up any design or image for your launch screen
        
        // Create a timer to schedule the transition to the login page after 5 seconds
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
            self.navigateToLogin()
        }
    }
    
    private func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            // Transition to the login view controller
            navigationController?.pushViewController(loginVC, animated: true)
            // Or if you're using a navigation controller, you can present it:
            // present(loginVC, animated: true, completion: nil)
        }
    }
}
