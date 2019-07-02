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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationMapView: MKMapView!
    @IBOutlet weak var swipeImageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var juiceReviewCollection: UICollectionView!
    @IBOutlet weak var yelpStarsImageView: UIImageView!
    @IBOutlet weak var yelpReviewCountLabel: UILabel!
    
    
    //MARK: - Landing Pad / Properties
    var location: Business?
    var reviews: [YelpReview] = []
//    var baseImage: UIImage?
    var pin: MKPointAnnotation?
    var images: [UIImage?] = []
    var juiceReviews: [JuiceReview] = []
    var juiceReviewImages: [UIImage] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.juiceReviewCollection.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set delegates
        self.locationMapView.addViewBorderColor()
        self.locationMapView.layer.borderWidth = 3
        self.swipeImageCollectionView.dataSource = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.juiceReviewCollection.delegate = self
        self.juiceReviewCollection.dataSource = self
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        //start fetching data for the business
        guard let location = self.location else {print("We have no location and are returning. ✅✅✅");return}
        print("we are past the guard and now we're gonna try to get images. Location has \(location.imageURLs.count) URLs ✅✅✅")
        JuiceNowBusinessInfoController.shared.fetchInfoForBusiness(business: location) { (info) in
            guard let businessInfo = info else {return}
            BusinessController.shared.addJuiceNowBusinessInfo(businessInfo: businessInfo, toBusiness: location, completion: { (_) in
                //cool now that that's gone lets use the image URLs we got and grab those images.
                for url in location.imageURLs{
                    do{
                        guard let imageURL = URL(string: url) else {return}
                        let imageData = try Data(contentsOf: imageURL)
                        guard let newImage = UIImage(data: imageData) else {return}
                        self.images.append(newImage)
                        print("We have gotten \(self.images.count) images for this business. ✅✅")
                    }catch{
                        print("Error fetching images for swipe view🤩 \(error.localizedDescription)")
                    }
                }
                DispatchQueue.main.async {
                    self.swipeImageCollectionView.reloadData()
                }
            })
        }
        //fetch all the JuiceNow reviews for the business
        FirebaseService.shared.fetchReviewsForBusiness(business: location) { (documents) in
            for document in documents{
                guard let loadedReview = JuiceReview(firestoreData: document) else {print("could not create a review from that document. 🔶🔶🔶🔶"); return}
                self.juiceReviews.append(loadedReview)
            }
            ReviewImageContainer.shared.fetchImagesForDetailPage(sender: self, reviews: self.juiceReviews, completion: { (success) in
                DispatchQueue.main.async {
                    print("trying to reload data for the juicereview collection. We have \(self.juiceReviews.count) reviews and \(self.juiceReviewImages.count) Images.🔶🔶🔶")
                    self.juiceReviewCollection.reloadData()
                }
            })
        }
        updateView()
    }
    
    
    
    //MARK: - Actions
    @IBAction func getDirectionsTapped(_ sender: UIButton) {
        guard let location = location else { return }
        goToMapForDirections(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)
    }
    @IBAction func yelpLogoTapped(_ sender: UIButton) {
        guard let location = location,
        let url = URL(string: location.url) else { return }
        UIApplication.shared.open(url)
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
        print("Location user rating: \(location?.userRating)🔊")
        guard let location = location else { return }
        addPinToMap(location: location)
        updateYelpStars(withRating: location.rating, totalRatings: location.reviewCount)
        restaurantNameLabel.text = location.name
        secondaryLocationNameLabel.text = location.name
        YelpReviewController.shared.fetchYelpReviews(forBusinessID: location.businessID) { (reviews) in
            self.reviews = reviews
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //update the yelp info
    func updateYelpStars(withRating rating: Double, totalRatings: Int){
        self.yelpReviewCountLabel.text = "Based on \(totalRatings) reviews"
        if rating < 0.5{
            yelpStarsImageView.image = UIImage(named: "regular_0")
        } else if rating < 1.5{
            yelpStarsImageView.image = UIImage(named: "regular_1")
        } else if rating < 2.0{
            yelpStarsImageView.image = UIImage(named: "regular_1_half")
        } else if rating < 2.5 {
            yelpStarsImageView.image = UIImage(named: "regular_2")
        } else if rating < 3.0{
            yelpStarsImageView.image = UIImage(named: "regular_2_half")
        } else if rating < 3.5{
            yelpStarsImageView.image = UIImage(named: "regular_3")
        } else if rating < 4.0{
            yelpStarsImageView.image = UIImage(named: "regular_3_half")
        } else if rating < 4.5{
            yelpStarsImageView.image = UIImage(named: "regular_4")
        } else if rating < 4.8{
            yelpStarsImageView.image = UIImage(named: "regular_4_half")
        } else {
            yelpStarsImageView.image = UIImage(named: "regular_5")
        }
    }
    
    func addPinToMap(location: Business) {
        let newPin = MKPointAnnotation()
        newPin.title = location.name
        newPin.coordinate = CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)
        locationMapView.addAnnotation(newPin)
        locationMapView.showAnnotations([newPin], animated: true)
        
    }
    
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addJuiceReview"{
            guard let destinVC = segue.destination as? ReviewViewController else {return}
            destinVC.business = self.location
        }
        if segue.identifier == "toExistingReview"{
            guard let destinVC = segue.destination as? ReviewViewController, let index = self.juiceReviewCollection.indexPathsForSelectedItems?.first else {return}
            print("passing info to the review controller. \(self.juiceReviews[index.row].drinkName) 🚹🚹🚹")
            destinVC.business = self.location
            destinVC.review = self.juiceReviews[index.row]
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

extension LocationDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == swipeImageCollectionView{
            return location?.imageURLs.count ?? 0
        } else {
            if self.juiceReviews.count > 0{
                print("🔶🔶🔶setting the number of items in the juicereviews collection to: \(self.juiceReviews.count)🔶🔶🔶")
                return self.juiceReviews.count
            } else {
                return 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("In the cellForItemAt 🔶🔶🔶")
        if collectionView == swipeImageCollectionView{
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
        } else {
            guard let location = self.location else {return UICollectionViewCell()}
            print("🔶🔶🔶loading data for the review collection🔶🔶🔶")
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? DetailPageReviewCollectionViewCell else {return UICollectionViewCell()}
            if self.juiceReviews.count > 0{
                cell.juiceNameLabel.text = self.juiceReviews[indexPath.row].drinkName
                cell.reviewImageView.image = self.juiceReviewImages[indexPath.row]
                cell.reviewImageView.addCornerRadius()
                cell.updateStarButtons(withReview: self.juiceReviews[indexPath.row])
            } else {
                cell.juiceNameLabel.text = "No ratings"
                cell.reviewImageView.image = UIImage(named: "NoRating")
            }
            return cell
        }
    }
}

extension LocationDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == juiceReviewCollection{
        return CGSize(width: self.juiceReviewCollection.frame.width / 2, height: self.juiceReviewCollection.frame.height)
        } else {
            guard let imageCount = location?.imageURLs.count else { return CGSize.zero }
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension LocationDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("a scroll view stopped scrolling")
        if scrollView == swipeImageCollectionView{
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        }
    }
}

