//
//  SpecificLocationViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class SpecificLocationViewController: UIViewController {
    
    //MARK: - Outlets
    //Need outlet for location main image
    //Need outlet for  location name
    //Need outlet for location description/address
    //new outlet for location rating
    //new outlet for person rating
    //new outlet for map

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    //Need action for get directions tapped - insert getDirections()
    //Need action for person rate tapped - insert rateLocation()
    

    //MARK: - Helper functions
    func getDirections() {
        
    }
    
    func rateLocation() {
        //populate an alert controller to get 1-5 score
        //update location self rating button label/image (update view?)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}//END OF SPECIFIC LOCATION VIEW CONTROLLER
