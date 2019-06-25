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
            guard self.checkStateOnlySearch(inText: searchText) == false else {
                self.presentSearchTermAlert()
                return
            }
            BusinessController.shared.fetchBusinessesFromYelp(location: searchText) { (locations) in
                self.locations = locations
                guard let user = UserController.shared.currentUser else {print("couldnt unwrap user"); return}
                for business in self.locations{
                    if user.likedBusinesses.contains(where: {$0.businessID == business.businessID}){
                        business.isFavorite = true
                        print("\(business.name) marked as favorite. 🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️")
                    }
                }
                BusinessController.shared.businesses = self.locations
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
        cell.favoriteButton.setImage(UIImage(named: business.isFavorite ? "vegetable" : "UnlikedStar"), for: .normal)
        cell.businessReference = self.locations[indexPath.row]
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
    
    func checkStateOnlySearch(inText text: String) -> Bool{
        let stateNames = ["alabama", "alaska", "arizona", "arkansas", "california", "colorado", "connecticut", "delaware", "florida", "georgia", "hawaii", "idaho", "illinois", "indiana", "iowa", "kansas", "kentucky", "louisiana", "maine", "maryland", "massachusetts", "michigan", "minnesota", "mississippi", "missouri", "montana", "nebraska", "nevada", "new hampshire", "new jersey", "new mexico", "new york", "north carolina", "north dakota", "ohio", "oaklahoma", "oregon", "pennsylvania", "rhode island", "south carolina", "south dakota", "tennessee", "texas", "utah", "vermont", "virginia", "washington", "west virginia", "wisconsin", "wyoming"]
        let stateAbbreviations = ["al", "ak", "as", "az", "ar", "ca", "co", "ct", "de", "dc", "fl", "ga", "hi", "id", "il", "in", "ia", "ks", "ky", "la", "me", "md", "ma", "mi", "mn", "ms", "mo", "mt", "ne", "nv", "nh", "nj", "nm", "ny", "nc", "nd", "oh", "ok", "or", "pa", "ri", "sc", "sd", "tn", "tx", "ut", "vt", "va", "wa", "wv", "wi", "wy"]
        let lowercasedText = text.lowercased()
        let filteredText = lowercasedText.trimmingCharacters(in: NSCharacterSet.letters.inverted)
        print(filteredText)
        if filteredText.count == 2{
            return stateAbbreviations.contains(filteredText)
        } else {
            return stateNames.contains(filteredText)
        }
    }
    
    func presentSearchTermAlert(){
        let searchTermAlert = UIAlertController(title: "Hold on.", message: "Please enter a city and state or a US zip code to search. Just a state won't do.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Got it.", style: .default) { (action) in
            searchTermAlert.dismiss(animated: true, completion: nil)
        }
        searchTermAlert.addAction(closeAction)
        self.present(searchTermAlert, animated: true)
    }
    
    
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
            locationManager?.startUpdatingLocation()
        }
    }
}
