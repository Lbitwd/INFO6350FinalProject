//
//  LoginViewController.swift
//  JobPulse
//
//  Created by Shuya Yang on 12/12/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

//    // Other IBOutlet and IBAction connections...
    @IBOutlet var LoginuserName: UITextField!
    @IBOutlet var Loginpassword: UITextField!
//    
    var context: NSManagedObjectContext!
    var managedContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).manageObjectContext!
    var currentUser: Employee?
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // Remove these lines if you don't want to clear and save test data every time
        clearAllData()
        saveDataToCoreData()

        let userFetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()

        do {
            let users = try managedContext.fetch(userFetchRequest)

            // Get the entered email/phone number and password
            let enteredEmailOrPhoneNumber = getEmailOrPhoneNumber() // Implement this function to get the entered email/phone number
            let enteredPassword = getPassword() // Implement this function to get the entered password

            // Check if there's a match in users
            if let matchedUser = users.first(where: { ($0.email == enteredEmailOrPhoneNumber || $0.phoneNumber == enteredEmailOrPhoneNumber) && $0.password == enteredPassword }) {
//                // Email or phone number and password match found, perform segue to the next page
                currentUser = matchedUser
                performSegue(withIdentifier: "logintoMain", sender: nil)
            } else {
                // No match found, display an error message
                displayErrorMessage(message: "Invalid email/phone number or password.")
            }
        } catch {
            // Handle the fetch error
            print("Error fetching users: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logintoMain" {
            if let viewController = segue.destination as? ViewController {
                // Pass the current user to the ViewController
                viewController.currentUser = currentUser
            }
        }
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
    
    func saveDataToCoreData() {
        
        let user1 = Employee(context: self.managedContext)
        user1.id = 1
        user1.name = "ccjob"
        user1.email = "cc@gmail.com"
        user1.password = "pswd"
        user1.phoneNumber = "1234567890"
        user1.gender = "Male"
        user1.race = "Asian"
        user1.companyLocation = "Boston"
        user1.jobTitle = "SDE"
        user1.jobType = "Intern"
        user1.jobVisa = true
        
        do {
            try self.managedContext.save()
//            loadSavedData()
        } catch {
            print("Error saving new college: \(error)")
            return
        }
    }
    func clearAllData() {
        do {
            let userFetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
            let users = try self.managedContext.fetch(userFetchRequest)
            
            for user in users {
                self.managedContext.delete(user)
            }
            try self.managedContext.save()
            
        } catch {
            print("Error clearing data: \(error)")
            // Handle error as needed
        }
    }
    // Other functions...
    private func getEmailOrPhoneNumber() -> String {
        return LoginuserName.text ?? ""
    }

    private func getPassword() -> String {
        return Loginpassword.text ?? ""
    }

    private func displayErrorMessage(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
