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
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        //load the user first
        UserController.shared.loadUser {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.locationManager = CLLocationManager()
                self.locationManager?.delegate = self
                self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                let authorizationStatus = CLLocationManager.authorizationStatus()
                if authorizationStatus == CLAuthorizationStatus.notDetermined{
                    print("we do not have permissions.⚠️⚠️⚠️⚠️⚠️⚠️⚠️")
                    self.segueToTabBarVC()
                } else {
                    print("we have permissions. ⚠️⚠️⚠️⚠️⚠️⚠️")
                    //start updating location. When it finishes this should trigger the delegate function
                    self.locationManager?.startUpdatingLocation()
                }
            }
        }
    }
    
    func segueToTabBarVC(){
        print("henlo, we're firing the segue to the tab bar controller.")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "tabBarController")
        UIApplication.shared.windows.first?.rootViewController = viewController
        self.performSegue(withIdentifier: "toTabController", sender: nil)
    }
    
}


extension InitialFetchViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("⚠️⚠️⚠️⚠️⚠️⚠️ delegate firing")
        currentLocation = locations[locations.count-1] as CLLocation
        CoreLocationReferences.currentLocation = currentLocation
        guard let latitude = currentLocation?.coordinate.latitude, let longitude = currentLocation?.coordinate.longitude else {return}
        BusinessController.shared.fetchBusinessWithCoordinates(latitude: latitude, longitude: longitude) { (fetchedBusinesses) in
            BusinessController.shared.businesses = fetchedBusinesses
            DispatchQueue.main.async {
                print("firing segue🧶")
                self.segueToTabBarVC()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("in the delegate didFail function. Firing segue.")
        self.segueToTabBarVC()
    }
}
