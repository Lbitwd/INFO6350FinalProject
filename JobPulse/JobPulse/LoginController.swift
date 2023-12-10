import UIKit
import CoreData

class LoginController: UIViewController {
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var userNameField: UITextField!
    @IBOutlet private var pswdField: UITextField!
    
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            context = appDelegate.persistentContainer.viewContext
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        // Ensure that username and password fields are not empty
        guard let username = userNameField.text, let pswd = pswdField.text, !username.isEmpty, !pswd.isEmpty else {
            displayError(message: "Username and password cannot be empty")
            return
        }

        // Fetch user from Core Data based on entered username
        if let user = fetchUser(username: username) {
            // Compare entered password with stored password
            if user.password == pswd {
                // Passwords match, perform the segue
                performSegue(withIdentifier: "LogintoMain", sender: self)
            } else {
                // Passwords don't match, display error
                displayError(message: "Invalid password")
            }
        } else {
            // User not found, display error
            displayError(message: "Username or Password is incorrect!")
        }
    }

    private func fetchUser(username: String) -> Employee? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username ==[c] %@", username)

        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                print("Found user: \(user.username ?? "No username")")
                return user
            } else {
                print("User not found")
                return nil
            }
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }


    private func displayError(message: String) {
        let alertController = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
