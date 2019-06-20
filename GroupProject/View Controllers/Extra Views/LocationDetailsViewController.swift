//
//  LocationDetailsViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

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
    
    
    //MARK: - Landing Pad / Properties
    var location: Business?
    var reviews: [YelpReview] = []
    var baseImage: UIImage?
    
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
        //COMPLETE WITH COUNT OF REVIEWS FOR BUSINESS
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as? LocationReviewTableViewCell else { return UITableViewCell() }
        let review = reviews[indexPath.row]
        cell.userLabel.text = review.id
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
        guard let location = location else { return }
        
        updateCommunityRatingStars()
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
        var address = business.location.addressOne
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
    
    func updateCommunityRatingStars() {
        //change start buttons depending on location average rating
    }
    
    func updatePersonalRatingStars() {
        //check if rating exists, if not return.
        //else rating, update stars
    }
    
}//END OF LOCATION DETAIL VIEW CONTROLLER
