//
//  AppDelegate.swift
//  JobPulse
//
//  Created by Shuya Yang on 12/9/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // Expose managed object context
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataSource")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        // Call a function to set up the root view controller
        self.setupRootViewController()
        return container
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Assuming you set the Storyboard ID for your LoginController in the storyboard
        if let mainpageController = storyboard.instantiateViewController(withIdentifier: "MainPageController") as? MainPageController {
            let navigationController = UINavigationController(rootViewController: mainpageController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }


}

