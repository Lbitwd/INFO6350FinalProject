//
//  ViewController.swift
//  JobPulse
//
//  Created by Shuya Yang on 12/9/23.
//

import UIKit
import CoreData

extension String {
    func truncateMiddle(maxLength: Int) -> String {
        guard self.count > maxLength else { return self }
        
        let separatorLength = 3 // Length of the ellipsis
        let sideLength = (maxLength + 2) / 2
        let start = String(self.prefix(sideLength + 4))
        let end = String(self.suffix(sideLength - 4))
        
        return start + "..." + end
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    var job: [Job] = []
    var company: [Company] = []
    var employee: [Employee] = []
    var experience: [Experience] = []
    let dateFormatter = DateFormatter()
    var filteredJobs: [Job] = []
    
    @IBOutlet weak var jobTypeSegment: UISegmentedControl!
    @IBOutlet weak var jobTableView: UITableView!
    @IBOutlet weak var searchField: UISearchBar!
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        filterJobs() // Call the function to filter jobs based on the segment value
        jobTableView.reloadData()
    }
    @IBOutlet weak var tabBar: UITabBar!
    /*@IBOutlet weak var jobpageSwitch: UITabBarItem!
    @IBOutlet weak var communitypageSwitch: UITabBarItem!
    @IBOutlet weak var managepageSwitch: UITabBarItem!
    @IBOutlet weak var employeepageSwitch: UITabBarItem!*/
    
    var context: NSManagedObjectContext!
    var managedContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).manageObjectContext!
    
    override func viewDidLoad() {
        //clearAllData()
        super.viewDidLoad()
        //saveDataToCoreData()
        loadSavedData()

        jobTypeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .selected)
        jobTableView.delegate = self
        jobTableView.dataSource = self
        searchField.delegate = self
        filterJobs()
    }

    
    func saveDataToCoreData() {
        
        let job1 = Job(context: self.managedContext)
        let job2 = Job(context: self.managedContext)
        let job3 = Job(context: self.managedContext)
        let job4 = Job(context: self.managedContext)
        let job5 = Job(context: self.managedContext)
        let job6 = Job(context: self.managedContext)
        let job7 = Job(context: self.managedContext)
        //let lastUsedID = job.last?.id ?? 0
        job1.id = 1
        job1.jobTitle = "Software Engineering Intern"
        job1.salary = 45
        job1.companyID = 1
        job1.type = "Intern"
        job1.visa = true
        job1.onsite = "On-site"
        job1.postDate = Date()
        job.append(job1)
        
        job2.id = 2
        job2.jobTitle = "Software Engineering Intern"
        job2.salary = 50
        job2.companyID = 1
        job2.type = "Intern"
        job2.visa = true
        job2.onsite = "Hybrid"
        job2.postDate = Date()
        job.append(job2)
        
        job3.id = 3
        job3.jobTitle = "Software Engineering Intern"
        job3.salary = 47
        job3.companyID = 2
        job3.type = "Intern"
        job3.visa = true
        job3.onsite = "Hybrid"
        job3.postDate = Date()
        job.append(job3)
        
        job4.id = 4
        job4.jobTitle = "Data Engineering Intern"
        job4.salary = 40
        job4.companyID = 3
        job4.type = "Intern"
        job4.visa = true
        job4.onsite = "Remote"
        job4.postDate = Date()
        job.append(job4)
        
        job5.id = 5
        job5.jobTitle = "Software Engineer NG"
        job5.salary = 133
        job5.companyID = 4
        job5.type = "NG"
        job5.visa = true
        job5.onsite = "On-site"
        job5.postDate = Date()
        job.append(job5)
        
        job6.id = 6
        job6.jobTitle = "Software Engineer III"
        job6.salary = 184
        job6.companyID = 2
        job6.type = "Experienced"
        job6.visa = false
        job6.onsite = "On-site"
        job6.postDate = Date()
        job.append(job6)
        
        job7.id = 7
        job7.jobTitle = "Software Engineer NG"
        job7.salary = 166
        job7.companyID = 6
        job7.type = "NG"
        job7.visa = true
        job7.onsite = "On-site"
        job7.postDate = Date()
        job.append(job7)
        
        let company1 = Company(context: self.managedContext)
        let company2 = Company(context: self.managedContext)
        let company3 = Company(context: self.managedContext)
        let company4 = Company(context: self.managedContext)
        let company5 = Company(context: self.managedContext)
        let company6 = Company(context: self.managedContext)
        company1.id = 1
        company1.name = "Tiktok"
        company1.location = "Boston, MA"
        if let logoImage = UIImage(named: "Tiktok-Logo") {
            if let imageData = logoImage.pngData() {
                company1.logo = imageData
            }
        }
        company.append(company1)
        
        company2.id = 2
        company2.name = "Google"
        company2.location = "New York, NY"
        if let logoImage = UIImage(named: "Google-logo") {
            if let imageData = logoImage.pngData() {
                company2.logo = imageData
            }
        }
        company.append(company2)
        
        company3.id = 3
        company3.name = "Meta"
        company3.location = "Seattle, WA"
        if let logoImage = UIImage(named: "logo-Meta") {
            if let imageData = logoImage.pngData() {
                company3.logo = imageData
            }
        }
        company.append(company3)
        
        company4.id = 4
        company4.name = "Amazon"
        company4.location = "Seattle, WA"
        if let logoImage = UIImage(named: "Amazon-logo 1") {
            if let imageData = logoImage.pngData() {
                company4.logo = imageData
            }
        }
        company.append(company4)
        
        company5.id = 5
        company5.name = "Netflix"
        company5.location = "Los Gatos, CA"
        if let logoImage = UIImage(named: "Netfli-logo") {
            if let imageData = logoImage.pngData() {
                company5.logo = imageData
            }
        }
        company.append(company5)
        
        company6.id = 6
        company6.name = "Apple"
        company6.location = "Los Gatos, CA"
        if let logoImage = UIImage(named: "Apple-Logo") {
            if let imageData = logoImage.pngData() {
                company6.logo = imageData
            }
        }
        company.append(company6)
        
        
        do {
            try self.managedContext.save()
            loadSavedData()
            jobTableView.reloadData()
        } catch {
            print("Error saving new college: \(error)")
            return
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Number of sections in the table view (1 in this case)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredJobs.count // Use the count of the filtered array
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140// Adjust this value according to the height you desire for your cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobTableViewCell
        //let selectedSegmentIndex = jobTypeSegment.selectedSegmentIndex
        
        if jobTypeSegment.selectedSegmentIndex == UISegmentedControl.noSegment {
                filteredJobs = job
            } else {
                filterJobs()
            }
            
            // Access job from the filteredJobs array     
        let job = filteredJobs[indexPath.row]
        //let job = job[indexPath.row]
        
        let maxLength = 20 // Set your desired maximum length
        
        if let jobTitle = job.jobTitle {
            let truncatedJobTitle = jobTitle.truncateMiddle(maxLength: maxLength)
            cell.jobTitleLabel?.text = truncatedJobTitle
        } else {
            cell.jobTitleLabel?.text = "No Title" // or any default text when job title is nil
        }

        dateFormatter.dateFormat = "MM-dd" // Displaying month and day with dashes (e.g., "12
        if let postDate = job.postDate {
            let dateString = dateFormatter.string(from: postDate)
            cell.jobPostDate?.text = dateString
        } else {
            cell.jobPostDate?.text = "No Date" // Or provide a default value when job post date is nil
        }
        
        cell.salaryLabel?.text = "$\(job.salary)/h"
        cell.jobonSite?.setTitle(job.onsite, for: .normal)
        
        if let company = company.first(where: { $0.id == job.companyID }) {
            cell.companyNameLabel?.text = company.name
            cell.companyLocationLabel?.text = company.location
            
            if let logoData = company.logo, let logoImage = UIImage(data: logoData) {
                cell.companyLogo?.image = logoImage
            } else {
                // Set a default image if the logo data is nil
                cell.companyLogo?.image = UIImage(named: "defaultLogo")
            }
        }
        return cell
    }
    
    /*func filterJobs() {
        let selectedSegmentIndex = jobTypeSegment.selectedSegmentIndex
            
        switch selectedSegmentIndex {
            case 0: // Intern segment
                filteredJobs = job.filter { $0.type == "Intern" }
            case 1: // NG segment
                filteredJobs = job.filter { $0.type == "NG" }
            case 2: // Experienced segment
                filteredJobs = job.filter { $0.type == "Experienced" }
            default:
                filteredJobs = job
        }
    }*/
    
    func filterJobs() {
        let selectedSegmentIndex = jobTypeSegment.selectedSegmentIndex
        
        switch selectedSegmentIndex {
            case 0: // Intern segment
                if let searchText = searchField.text, !searchText.isEmpty {
                    let filteredByCompany = company.filter { $0.name?.range(of: searchText, options: .caseInsensitive) != nil }
                    let companyIDs = filteredByCompany.map { $0.id }
                    filteredJobs = job.filter { $0.type == "Intern" && companyIDs.contains($0.companyID) }
                } else {
                    filteredJobs = job.filter { $0.type == "Intern" }
                }
            case 1: // NG segment
                if let searchText = searchField.text, !searchText.isEmpty {
                    let filteredByCompany = company.filter { $0.name?.range(of: searchText, options: .caseInsensitive) != nil }
                    let companyIDs = filteredByCompany.map { $0.id }
                    filteredJobs = job.filter { $0.type == "NG" && companyIDs.contains($0.companyID) }
                } else {
                    filteredJobs = job.filter { $0.type == "NG" }
                }
            case 2: // Experienced segment
                if let searchText = searchField.text, !searchText.isEmpty {
                    let filteredByCompany = company.filter { $0.name?.range(of: searchText, options: .caseInsensitive) != nil }
                    let companyIDs = filteredByCompany.map { $0.id }
                    filteredJobs = job.filter { $0.type == "Experienced" && companyIDs.contains($0.companyID) }
                } else {
                    filteredJobs = job.filter { $0.type == "Experienced" }
                }
            default:
                filteredJobs = job
        }
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterJobs() // Update the filtered results based on the search text
        jobTableView.reloadData() // Reload the table view with the updated results
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Dismiss the keyboard when the search button is clicked
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil // Clear the text in the search field
        filterJobs() // Update the filtered results (show all results)
        searchBar.resignFirstResponder() // Dismiss the keyboard
        jobTableView.reloadData() // Reload table view to display all results
    }

    func loadSavedData() {
            do {
                let jobFetchRequest: NSFetchRequest<Job> = Job.fetchRequest()
                let companyFetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
                let employeeFetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
                let experienceFetchRequest: NSFetchRequest<Experience> = Experience.fetchRequest()
                
                self.job = try (self.managedContext.fetch(jobFetchRequest)) as [Job]
                self.company = try (self.managedContext.fetch(companyFetchRequest)) as [Company]
                self.employee = try (self.managedContext.fetch(employeeFetchRequest)) as [Employee]
                self.experience = try (self.managedContext.fetch(experienceFetchRequest)) as [Experience]
                jobTableView.reloadData()
                
            } catch {
                print("Error fetching data: \(error)")
                // Handle error as needed
            }
        }
    
    func clearAllData() {
        do {
            let jobFetchRequest: NSFetchRequest<Job> = Job.fetchRequest()
            let jobs = try self.managedContext.fetch(jobFetchRequest)
            
            for job in jobs {
                self.managedContext.delete(job)
            }
            
            let companyFetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
            let companys = try self.managedContext.fetch(companyFetchRequest)
            
            for company in companys {
                self.managedContext.delete(company)
            }
            try self.managedContext.save()
            
        } catch {
            print("Error clearing data: \(error)")
            // Handle error as needed
        }
    }


}

