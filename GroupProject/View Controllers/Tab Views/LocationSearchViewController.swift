//
//  LocationSearchViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Properties
    let debouncer = Debouncer(timeInterval: 2.0)
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var pins: [MKPointAnnotation] = []
    
    var locations: [Business] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.addPinsToMap()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        mapView.delegate = self
        debouncer.handler = {
            guard let searchText = self.searchBar.text else { return }
            BusinessController.shared.fetchBusinessesFromYelp(location: searchText) { (locations) in
                self.locations = locations
                BusinessController.shared.businesses = locations
                //self.sortFurthestBusiness()
                DispatchQueue.main.async {
                    self.view.endEditing(true)
                    //this would be a good place to update the map post-search
                }
            }
        }
        //core location request
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == CLAuthorizationStatus.notDetermined{
            locationManager?.requestWhenInUseAuthorization()
            print("we do not have permissions.⚠️⚠️⚠️⚠️⚠️⚠️⚠️")
        } else {
            print("we have permissions. ⚠️⚠️⚠️⚠️⚠️⚠️")
            mapView.showsUserLocation = true
            locationManager?.startUpdatingLocation()
            self.locations = BusinessController.shared.businesses
            //self.sortFurthestBusiness()
        }
    }
    
    //MARK: - TableView Data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }
        let business = locations[indexPath.row]
        let openStatus = business.isClosed ? "CLOSED" : "OPEN"
        let buttonText = "\(business.name)\nJuiceNow™ Rating: \(business.rating)\nCurrently \(openStatus)"
        cell.locationInfo.text = buttonText
        return cell
    }
    
    //MARK: Map View Delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    
    
    //MARK: Add pins to the map
    func addPinsToMap(){
        mapView.removeAnnotations(pins)
        self.pins = []
        for business in self.locations{
            let newPin = MKPointAnnotation()
            newPin.title = business.name
            newPin.coordinate = CLLocationCoordinate2D(latitude: business.coordinates.latitude, longitude: business.coordinates.longitude)
            mapView.addAnnotation(newPin)
            self.pins.append(newPin) //collect references ot the pin so we can remove them later
        }
        print("location manager has no location.🧚‍♀️🧚‍♀️🧚‍♀️")
        
        //set the radius
        mapView.showAnnotations(pins, animated: true)
    }
    
//    func sortFurthestBusiness(){//this is gonna be incredibly ineffecient
//        var longestDistance: CLLocationDistance = 0
//        print("according to that new function the furthest business is:")
//        print(sortedBusinesses.last?.name)
//        self.locations = sortedBusinesses
//    }

    
    func findDistanceToUser(business: Business) -> CLLocationDistance{
        let businessCoordinate = CLLocationCoordinate2D(latitude: business.coordinates.latitude, longitude: business.coordinates.longitude)
        guard let currentAltitude = currentLocation?.altitude, let userLocation = currentLocation else {return 0}
        let businessLocation = CLLocation(coordinate: businessCoordinate, altitude: currentAltitude, horizontalAccuracy: 1, verticalAccuracy: -1, timestamp: Date())
        let distanceToUser = businessLocation.distance(from: userLocation)
        return distanceToUser
    }
    
//    func (){
//
//    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationToLocationDetailVC" {
            if let index = tableView.indexPathForSelectedRow?.row {
                let destinationVC = segue.destination as? LocationDetailsViewController
                //passing location
                let location = locations[index]
                destinationVC?.location = location
                //passing yelp reviews
                
            }
        }
    }
}

//END OF Location Search View Controller

//MARK: - Search bar functionality
extension LocationSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debouncer.renewInterval()
    }
    
}

extension LocationSearchViewController: CLLocationManagerDelegate{
    //fires whenever the location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("⚠️⚠️⚠️⚠️⚠️⚠️ delegate firing")
        self.currentLocation = locations[locations.count-1] as CLLocation
        guard let latitude = currentLocation?.coordinate.latitude, let longitude = currentLocation?.coordinate.longitude else {return}
        BusinessController.shared.fetchBusinessWithCoordinates(latitude: latitude, longitude: longitude) { (fetchedBusinesses) in
            self.locations = fetchedBusinesses
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    //this fires when the user authorizes.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            guard let searchText = self.searchBar.text, !searchText.isEmpty else { return }
            BusinessController.shared.fetchBusinessesFromYelp(location: searchText) { (locations) in
                self.locations = locations
                BusinessController.shared.businesses = locations
                DispatchQueue.main.async {
                    self.view.endEditing(true)
                }
            }
        }
    }
}
