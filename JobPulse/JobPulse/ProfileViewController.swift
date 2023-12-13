import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pswdText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneNumText: UITextField!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var raceButton: UIButton!
    @IBOutlet weak var jobTitleButton: UIButton!
    @IBOutlet weak var jobTypeButton: UIButton!
    @IBOutlet weak var jobVisaButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var EditButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    

    var currentUser: Employee?
    let genderOptions = ["Male", "Female", "Non-binary"]
    let raceOptions = ["Asian", "Black", "White"]
    let jobTitleOptions = ["SDE", "MLE", "DA", "MKT"]
    let jobTypeOptions = ["Intern", "Entry Level", "Experienced"]
    let jobVisaOptions = ["Sponsor", "No Sponsor"]
    let locationOptions = ["Boston", "Seattle", "New York", "Los Angeles", "Other", "Remote"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        if let currentUser = currentUser {
            // Populate data
            populateUserData(currentUser)
        }   
    }

    @IBAction func selectGender(_ sender: UIButton) {
        showOptionsAlert(title: "Select Gender", options: genderOptions) { selectedOption in
            self.genderButton.setTitle(selectedOption, for: .normal)
        }
    }

    @IBAction func selectRace(_ sender: UIButton) {
        showOptionsAlert(title: "Select Race", options: raceOptions) { selectedOption in
            self.raceButton.setTitle(selectedOption, for: .normal)
        }
    }
    
    @IBAction func selectJobTitle(_ sender: UIButton) {
        showOptionsAlert(title: "Select Job Title", options: jobTitleOptions) { selectedOption in
            self.jobTitleButton.setTitle(selectedOption, for: .normal)
        }
    }
    
    @IBAction func selectJobType(_ sender: UIButton) {
        showOptionsAlert(title: "Select Job Type", options: jobTypeOptions) { selectedOption in
            self.jobTypeButton.setTitle(selectedOption, for: .normal)
        }
    }
    
    @IBAction func selectJobVisa(_ sender: UIButton) {
        showOptionsAlert(title: "Select Job Visa", options: jobVisaOptions) { selectedOption in
            self.jobVisaButton.setTitle(selectedOption, for: .normal)
        }
    }

    @IBAction func selectLocation(_ sender: UIButton) {
        showOptionsAlert(title: "Select Preferred Location", options: locationOptions) { selectedOption in
            self.locationButton.setTitle(selectedOption, for: .normal)
        }
    }
    
    func showOptionsAlert(title: String, options: [String], completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)

        for option in options {
            let action = UIAlertAction(title: option, style: .default) { _ in
                completion(option)
            }
            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func setupUI() {
        // Disable user interaction for text fields and buttons
        emailText.isUserInteractionEnabled = false
        pswdText.isUserInteractionEnabled = false
        nameText.isUserInteractionEnabled = false
        phoneNumText.isUserInteractionEnabled = false
        genderButton.isUserInteractionEnabled = false
        raceButton.isUserInteractionEnabled = false
        jobTitleButton.isUserInteractionEnabled = false
        jobTypeButton.isUserInteractionEnabled = false
        jobVisaButton.isUserInteractionEnabled = false
        locationButton.isUserInteractionEnabled = false
    }

    func populateUserData(_ user: Employee) {
        // Populate data from the currentUser
        emailText.text = user.email
        pswdText.text = user.password
        nameText.text = user.name
        phoneNumText.text = user.phoneNumber
        genderButton.setTitle(user.gender, for: .normal)
        raceButton.setTitle(user.race, for: .normal)
        jobTitleButton.setTitle(user.jobTitle, for: .normal)
        jobTypeButton.setTitle(user.jobType, for: .normal)
        jobVisaButton.setTitle(user.jobVisa ? "Sponsor" : "No Sponsor", for: .normal)
        locationButton.setTitle(user.companyLocation, for: .normal)
    }

    @IBAction func editButtonTapped(_ sender: UIButton) {
        // Enable user interaction for text fields and buttons when EditButton is tapped
        emailText.isUserInteractionEnabled = true
        pswdText.isUserInteractionEnabled = true
        nameText.isUserInteractionEnabled = true
        phoneNumText.isUserInteractionEnabled = true
        genderButton.isUserInteractionEnabled = true
        raceButton.isUserInteractionEnabled = true
        jobTitleButton.isUserInteractionEnabled = true
        jobTypeButton.isUserInteractionEnabled = true
        jobVisaButton.isUserInteractionEnabled = true
        locationButton.isUserInteractionEnabled = true
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // Check if currentUser exists
        guard let currentUser = currentUser else {
            // Handle the case where currentUser is nil
            return
        }

        // Update the currentUser with the edited information
        currentUser.email = emailText.text
        currentUser.password = pswdText.text
        currentUser.name = nameText.text
        currentUser.phoneNumber = phoneNumText.text
        currentUser.gender = genderButton.currentTitle
        currentUser.race = raceButton.currentTitle
        currentUser.jobTitle = jobTitleButton.currentTitle
        currentUser.jobType = jobTypeButton.currentTitle
        currentUser.jobVisa = (jobVisaButton.currentTitle == "Sponsor")
        currentUser.companyLocation = locationButton.currentTitle

        // Save the changes to CoreData
        do {
            try currentUser.managedObjectContext?.save()
            // Optionally, you can show an alert or perform other actions after saving.
            // For example, you can display a success message:
            let alertController = UIAlertController(title: "Success", message: "Profile updated successfully", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } catch {
            // Handle the error if the save operation fails
            print("Error saving profile: \(error)")
            // Optionally, you can display an error message:
            let alertController = UIAlertController(title: "Error", message: "Failed to update profile", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }


}
