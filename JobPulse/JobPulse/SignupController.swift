import UIKit
import CoreData

class SignupController: UIViewController {
    @IBOutlet private var signupButton: UIButton!
    @IBOutlet private var userNameField: UITextField!
    @IBOutlet private var pswdField: UITextField!
    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var emailField: UITextField!
    @IBOutlet private var phoneNumField: UITextField!
    var users: [Employee] = []
    var context: NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            context = appDelegate.persistentContainer.viewContext
        }
        fetchUsers()
    }
    
    @IBAction func signupbuttonTapped(_ sender: UIButton) {
        // Check if the username is already in use
        guard let username = userNameField.text, !username.isEmpty else {
            displayError(message: "Username cannot be empty")
            return
        }

        if isUsernameAlreadyUsed(username: username) {
            displayError(message: "Username is already in use")
            return
        }
        
        guard let password = pswdField.text, !password.isEmpty else {
            displayError(message: "Password cannot be empty")
            return
        }
        
        guard let name = nameField.text, !name.isEmpty else {
            displayError(message: "Name cannot be empty")
            return
        }
        
        guard let email = emailField.text, !email.isEmpty, email.contains("@") else {
            displayError(message: "Invalid email format")
            return
        }

        // Validate phone number
        guard let phoneNumber = phoneNumField.text, !phoneNumber.isEmpty, phoneNumber.count == 10, phoneNumber.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil else {
            displayError(message: "Invalid phone number format")
            return
        }

        // If the username is not in use, proceed with creating and saving the employee
        createAndSaveSampleEmployee()
        performSegue(withIdentifier: "SignuptoLogin", sender: self)
    }
    
    func fetchUsers() {
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()

        do {
            let fetchedUsers = try context.fetch(fetchRequest)
            self.users = fetchedUsers

            // Print some debugging information
            print("Fetched \(self.users.count) users.")
        } catch let error as NSError {
            print("Error fetching colleges: \(error.localizedDescription)")
        }
    }
    
    func createAndSaveSampleEmployee() {
        if let sampleEmployee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as? Employee {
            sampleEmployee.username = userNameField.text
            sampleEmployee.password = pswdField.text // You should hash passwords in a real-world scenario
            sampleEmployee.name = nameField.text
            sampleEmployee.id = Int32(self.users.count + 1)
            sampleEmployee.companyLocation = "Nil"
            sampleEmployee.email = emailField.text
            sampleEmployee.gender = "Nil"
            sampleEmployee.jobTitle = "Nil"
            sampleEmployee.jobType = "Nil"
            sampleEmployee.jobVisa = false
            sampleEmployee.phoneNumber = phoneNumField.text
            sampleEmployee.race = "Nil"
        }
        

        // Save the context to persist the changes
        do {
            try context.save()
            print("Sample employee saved")
        } catch {
            print("Error saving sample employee: \(error)")
        }
    }
    
    func isUsernameAlreadyUsed(username: String) -> Bool {
        return users.contains { $0.username?.caseInsensitiveCompare(username) == .orderedSame }
    }
    
    private func displayError(message: String) {
        let alertController = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
