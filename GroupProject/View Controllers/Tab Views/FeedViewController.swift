//
//  FeedViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var juicenowLogoImageView: UIImageView!
    
    //MARK: - Properties
    var locationsFromLocalizedFetch: [Business] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getBusinesses()
    }
    
    //MARK: - Helper functions
    func getBusinesses() {
        BusinessController.shared.fetchBusinessesFromYelp { (locations) in
            self.locationsFromLocalizedFetch = locations
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}//END OF VIEW CONTROLLER
