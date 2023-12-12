import UIKit
import CoreData

class MainPageController: UIViewController {
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var signupButton: UIButton!
    
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            context = appDelegate.persistentContainer.viewContext
        }
        deleteAllUsers()
        // Uncomment the following line to create and save a sample employee
        createAndSaveSampleEmployee()
    }
    
    @IBAction func loginbuttonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginController", sender: self)
    }
    @IBAction func signupbuttonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "SignupController", sender: self)
    }
    
    private func createAndSaveSampleEmployee() {
        if let sampleEmployee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as? Employee {
            sampleEmployee.username = "admin"
            sampleEmployee.password = "password123" // You should hash passwords in a real-world scenario
            sampleEmployee.name = "Nobel"
            sampleEmployee.id = 1
            sampleEmployee.companyLocation = "Boston"
            sampleEmployee.email = "nobel@gmail.com"
            sampleEmployee.gender = "Male"
            sampleEmployee.jobTitle = "SDE"
            sampleEmployee.jobType = "Intern"
            sampleEmployee.jobVisa = true
            sampleEmployee.phoneNumber = "1234567890"
            sampleEmployee.race = "Asian"
        }
        

        // Save the context to persist the changes
        do {
            try context.save()
            print("Sample employee saved successfully")
        } catch {
            print("Error saving sample employee: \(error)")
        }
    }
    
    func deleteAllUsers() {
        // Access the persistent container from the app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // Create a managed object context
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        
        do {
            let entities = try context.fetch(fetchRequest)
            
            // Delete each entity
            for entity in entities {
                if let managedObject = entity as? NSManagedObject {
                    context.delete(managedObject)
                }
            }
            
            // Save the changes
            try context.save()
        } catch {
            print("Failed to delete all data: \(error)")
        }
    }
}
