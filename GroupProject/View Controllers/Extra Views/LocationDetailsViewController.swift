//
//  LocationDetailsViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var secondaryLocationNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commuityStarOneButton: UIButton!
    @IBOutlet weak var communityStarTwoButton: UIButton!
    @IBOutlet weak var communityStarThreeButton: UIButton!
    @IBOutlet weak var communityStarFourButton: UIButton!
    @IBOutlet weak var communityStarFiveButton: UIButton!
    @IBOutlet weak var personalStarOneButton: UIButton!
    @IBOutlet weak var personalStarTwoButton: UIButton!
    @IBOutlet weak var personalStarThreeButton: UIButton!
    @IBOutlet weak var personalStarFourButton: UIButton!
    @IBOutlet weak var personalStarFiveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationMapView: MKMapView!
    
    
    //MARK: - Landing Pad / Properties
    var location: Business?
    var reviews: [YelpReview] = []
    var baseImage: UIImage?
    var pin: MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        updateView()
    }
    
    
    //MARK: - Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func getDirectionsTapped(_ sender: UIButton) {
        guard let location = location else { return }
        goToMapForDirections(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)
    }
    @IBAction func ratingOneTapped(_ sender: UIButton) {
    }
    @IBAction func ratingTwoTapped(_ sender: UIButton) {
    }
    @IBAction func ratingThreeTapped(_ sender: UIButton) {
    }
    @IBAction func ratingFourTapped(_ sender: UIButton) {
    }
    @IBAction func ratingFiveTapped(_ sender: UIButton) {
    }
    
    //MARK: - Table view data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as? LocationReviewTableViewCell else { return UITableViewCell() }
        let review = reviews[indexPath.row]
        cell.userLabel.text = review.user.name
        cell.reviewLabel.text = review.text
        
        return cell
    }
    
    //MARK: - Helper Functions
    func ratingTappedFor(starNumber: Int) {
        switch starNumber {
        case 1:
            //Change user rating for business to 1
            //Update star images
            print("One tapped")
        case 2:
            //Change user rating for business to 2
            //Update star images
            print("Two tapped")
        case 3:
            //Change user rating for business to 3
            //Update star images
            print("Three tapped")
        case 4:
            //Change user rating for business to 4
            //Update star images
            print("Four tapped")
        case 5:
            //Change user rating for business to 5
            //Update star images
            print("Five tapped")
        default:
            print("Error tapping rating❗️")
        }
    }
    
    func updateView() {
        print(location?.name)
        guard let location = location else { return }
        addPinToMap(location: location)
        updateCommunityRatingStars(rating: location.rating)
        updatePersonalRatingStars()
        restaurantNameLabel.text = location.name
        secondaryLocationNameLabel.text = location.name
        YelpReviewController.shared.fetchYelpReviews(forBusinessID: location.businessID) { (reviews) in
            self.reviews = reviews
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        updateLocationImageFor(business: location)
        updateSecondaryLabelFor(business: location)
    }
    
    func addPinToMap(location: Business) {
        let newPin = MKPointAnnotation()
        newPin.title = location.name
        newPin.coordinate = CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)
        locationMapView.addAnnotation(newPin)
        locationMapView.showAnnotations([newPin], animated: true)
        
    }
    
//    func addPinToMap(){
//        mapView.removeAnnotations(pins)
//        self.pins = []
//        for business in self.locations{
//            let newPin = MKPointAnnotation()
//            newPin.title = business.name
//            newPin.coordinate = CLLocationCoordinate2D(latitude: business.coordinates.latitude, longitude: business.coordinates.longitude)
//            mapView.addAnnotation(newPin)
//            self.pins.append(newPin) //collect references ot the pin so we can remove them later
//        }
//        print("location manager has no location.🧚‍♀️🧚‍♀️🧚‍♀️")
//
//        //set the radius
//        mapView.showAnnotations(pins, animated: true)
//    }
    
    
    func updateLocationImageFor(business: Business) {
        guard let url = URL(string: business.baseImage) else { return }
        do {
            let imageData = try Data(contentsOf: url)
            self.baseImage = UIImage(data: imageData)
        } catch  {
            print(error.localizedDescription)
        }
        DispatchQueue.main.async {
            self.locationImage.image = self.baseImage
        }
    }
    
    func updateSecondaryLabelFor(business: Business) {
        let address = business.location.addressOne
        let city = business.location.city
        let state = business.location.state
        let zip = business.location.zipCode
//        if let address2 = business.location.addressTwo {
//            address = "\(address)\n\(address2)"
//        }
//        if let address3 = business.location.addressThree {
//            address = "\(address)\n\(address3)"
//        }
        let label = "\(address)\n\(city), \(state) \(zip)"
        DispatchQueue.main.async {
            self.descriptionLabel.text = label
        }
    }
    
    func updateCommunityRatingStars(rating: Double) {
        if rating == 0 {
            return
        } else if rating < 1 {
            DispatchQueue.main.async {
                self.commuityStarOneButton.setImage(#imageLiteral(resourceName: "halfstar"), for: .normal)
                return
            }
        } else if rating < 1.5 {
            DispatchQueue.main.async {
                self.commuityStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                return
            }
        } else if rating < 2 {
            DispatchQueue.main.async {
                self.commuityStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarTwoButton.setImage(#imageLiteral(resourceName: "halfstar"), for: .normal)
                return
            }
        } else if rating < 2.5 {
            DispatchQueue.main.async {
                self.commuityStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarTwoButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                return
            }
        } else if rating < 3 {
            DispatchQueue.main.async {
                self.commuityStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarTwoButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarThreeButton.setImage(#imageLiteral(resourceName: "halfstar"), for: .normal)
                return
            }
        } else if rating < 3.5 {
            DispatchQueue.main.async {
                self.commuityStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarTwoButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarThreeButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                return
            }
        } else if rating < 4 {
            DispatchQueue.main.async {
                self.commuityStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarTwoButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarThreeButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarFourButton.setImage(#imageLiteral(resourceName: "halfstar"), for: .normal)
                return
            }
        } else if rating < 4.5 {
            DispatchQueue.main.async {
                self.commuityStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarTwoButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarThreeButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarFourButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                return
            }
        } else if rating < 5 {
            DispatchQueue.main.async {
                self.commuityStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarTwoButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarThreeButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarFourButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarFiveButton.setImage(#imageLiteral(resourceName: "halfstar"), for: .normal)
                return
            }
        } else if rating == 5 {
            DispatchQueue.main.async {
                self.commuityStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarTwoButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarThreeButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarFourButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                self.communityStarFiveButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
                return
            }
        }
    }
    
    func updatePersonalRatingStars() {
        //check if rating exists, if not return.
        //else rating, update stars
    }
    
}//END OF LOCATION DETAIL VIEW CONTROLLER

extension LocationDetailsViewController {
    func goToMapForDirections(latitude: Double, longitude: Double) {
        let lat: CLLocationDegrees = latitude
        let long: CLLocationDegrees = longitude
        
        let regionDistance: CLLocationDistance = 10000
        let coordiates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let regionSpan = MKCoordinateRegion(center: coordiates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordiates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location?.name
        mapItem.openInMaps(launchOptions: options)
    }
}
