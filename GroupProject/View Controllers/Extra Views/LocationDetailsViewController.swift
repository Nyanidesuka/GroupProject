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
    @IBOutlet weak var swipeImageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - Landing Pad / Properties
    var location: Business?
    var reviews: [YelpReview] = []
//    var baseImage: UIImage?
    var pin: MKPointAnnotation?
    var images: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeImageCollectionView.dataSource = self
        guard let location = self.location else {return}
        for url in location.imageURLs{
            do{
                guard let imageURL = URL(string: url) else {return}
                let imageData = try Data(contentsOf: imageURL)
                guard let newImage = UIImage(data: imageData) else {return}
                self.images.append(newImage)
            }catch{
                    print("Error fetching images for swipe view🤩 \(error.localizedDescription)")
            }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        updateView()
    }
    
    
    
    //MARK: - Actions
    @IBAction func getDirectionsTapped(_ sender: UIButton) {
        guard let location = location else { return }
        goToMapForDirections(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)
    }
    @IBAction func ratingOneTapped(_ sender: UIButton) {
        guard let business = location else {return}
        rateBusiness(business: business, rating: 1)
    }
    @IBAction func ratingTwoTapped(_ sender: UIButton) {
        guard let business = location else {return}
        rateBusiness(business: business, rating: 2)
    }
    @IBAction func ratingThreeTapped(_ sender: UIButton) {
        guard let business = location else {return}
        rateBusiness(business: business, rating: 3)
    }
    @IBAction func ratingFourTapped(_ sender: UIButton) {
        guard let business = location else {return}
        rateBusiness(business: business, rating: 4)
    }
    @IBAction func ratingFiveTapped(_ sender: UIButton) {
        guard let business = location else {return}
        rateBusiness(business: business, rating: 5)
    }
    
    func checkBusinessIsFavorite(business: Business) -> Bool{
        guard let user = UserController.shared.currentUser else {return false}
        return user.likedBusinesses.contains(where: {$0.businessID == business.businessID})
    }
    
    func rateBusiness(business: Business, rating: Int){
        guard let user = UserController.shared.currentUser else {return}
        business.userRating = rating
        if user.likedBusinesses.contains(where: {$0.businessID == business.businessID}){
            //I don't know that we actually need to do this; there's a chance that just changing the rating once changes it everywhere. But i'm paranoid.
            guard let updateBusiness = user.likedBusinesses.first(where: {$0.businessID == business.businessID}) else {print("couldnt update business rating"); return}
            updateBusiness.userRating = rating
        } else {
            //ths business isnt already liked so let's like it
            user.likedBusinesses.append(business)
            business.isFavorite = true
        }
        //then we gotta save the user doc.
        let userDict = UserController.shared.createDictionary(fromUser: user)
        UserController.shared.saveUserDocument(data: userDict) { (success) in
            print("finished saving user document. Success: \(success)")
        }
        //THEN we have to update the stars
//        updatePersonalRatingButtons()
        print("Assigned a rating to \(business.name), and that rating is \(business.userRating)")
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
        print(location?.userRating)
        guard let location = location else { return }
        addPinToMap(location: location)
        updateCommunityRatingStars(rating: location.rating)
        restaurantNameLabel.text = location.name
        secondaryLocationNameLabel.text = location.name
        YelpReviewController.shared.fetchYelpReviews(forBusinessID: location.businessID) { (reviews) in
            self.reviews = reviews
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        updateSecondaryLabelFor(business: location)
        //sets images on the user score buttons
//        self.updatePersonalRatingButtons()
    }
    
    func addPinToMap(location: Business) {
        let newPin = MKPointAnnotation()
        newPin.title = location.name
        newPin.coordinate = CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)
        locationMapView.addAnnotation(newPin)
        locationMapView.showAnnotations([newPin], animated: true)
        
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
    
    
//    func updatePersonalRatingButtons(){
//        guard let location = location, let rating = location.userRating else {print("Failing the unwrap so something is nil.☄️☄️"); return}
//        switch rating{
//        case 1:
//            personalStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarTwoButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
//            personalStarThreeButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
//            personalStarFourButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
//            personalStarFiveButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
//        case 2:
//            personalStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarTwoButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//                personalStarThreeButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
//                personalStarFourButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
//                personalStarFiveButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
//        case 3:
//            personalStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarTwoButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarThreeButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarFourButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
//            personalStarFiveButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
//        case 4:
//            personalStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarTwoButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarThreeButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarFourButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarFiveButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
//        case 5:
//            personalStarOneButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarTwoButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarThreeButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarFourButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//            personalStarFiveButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
//        default: return
//        }
//    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addJuiceReview"{
            guard let destinVC = segue.destination as? ReviewViewController else {return}
            destinVC.business = self.location
        }
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

extension LocationDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return location?.imageURLs.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? SwipeImageViewCollectionViewCell,
        let location = location
        else {return UICollectionViewCell() }
        let imageURL = location.imageURLs[indexPath.row]
        guard let url = URL(string: imageURL) else { return UICollectionViewCell()}
        YelpService.shared.fetch(url: url) { (data) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                cell.swipeImageView.image = image
            }
        }
        return cell
    }
}

extension LocationDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let imageCount = location?.imageURLs.count else { return CGSize.zero }
        return CGSize(width: (collectionView.frame.width / CGFloat(imageCount)), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension LocationDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
}

