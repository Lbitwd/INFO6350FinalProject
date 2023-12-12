//
//  ViewController.swift
//  JobPulse
//
//  Created by Shuya Yang on 12/9/23.
//

import UIKit
import CoreData



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var jobTypeSegment: UISegmentedControl!
    @IBOutlet weak var jobTableView: UITableView!
    @IBOutlet weak var cell1LabelTitle: UILabel!
    @IBOutlet weak var searchField: UISearchBar!
    var context: NSManagedObjectContext!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    fatalError("Unable to access AppDelegate")
                }
        context = appDelegate.persistentContainer.viewContext

        jobTypeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .selected)
        jobTableView.delegate = self
        jobTableView.dataSource = self
        
        jobTableView.register(UITableViewCell.self, forCellReuseIdentifier: "1")
        jobTableView.register(UITableViewCell.self, forCellReuseIdentifier: "2")
        jobTableView.register(UITableViewCell.self, forCellReuseIdentifier: "3")
        jobTableView.register(UITableViewCell.self, forCellReuseIdentifier: "4")
        
    
    }
    
    func saveDataToCoreData() {
        // Creating and saving a managed object
        let job = NSEntityDescription.entity(forEntityName: "Job", in: context)!
        let newItem = NSManagedObject(entity: job, insertInto: context)
        // Set values for your attributes (example)
        newItem.setValue("Tiktok", forKey: "jobTitle")
        newItem.setValue("1", forKey: "companyID")
        newItem.setValue("45", forKey: "salary")
        
        let company = NSEntityDescription.entity(forEntityName: "Company", in: context)!
        let newItem2 = NSManagedObject(entity: company, insertInto: context)
        // Set values for your attributes (example)
        newItem.setValue("Seattle", forKey: "location")
        newItem.setValue("1", forKey: "id")
        // Save the context
        do {
            try context.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Number of sections in the table view (1 in this case)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // Four rows in the table view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the cells without any additional configuration
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(indexPath.row + 1)", for: indexPath)
        return cell
    }


}

