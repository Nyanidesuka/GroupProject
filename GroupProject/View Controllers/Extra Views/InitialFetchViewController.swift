//
//  InitialFetchViewController.swift
//  GroupProject
//
//  Created by Haley Jones on 6/20/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit
import CoreLocation

class InitialFetchViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        //load the user first
        UserController.shared.loadUser {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                //these lines will let us segue to the tab bar controller when the fetch is done, and pop the fetch contrller off the stack.
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "tabBarController")
                UIApplication.shared.windows.first?.rootViewController = viewController
                self.performSegue(withIdentifier: "toTabController", sender: nil)
            }
        }
    }
}


extension InitialFetchViewController: CLLocationManagerDelegate{
    
}
