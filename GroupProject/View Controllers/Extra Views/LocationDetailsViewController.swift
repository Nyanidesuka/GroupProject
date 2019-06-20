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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //COMPLETE W/ REVIEWS FOR BUSINESS
        return UITableViewCell()
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
        tableView.reloadData()
        
        
    }
    
    func updateCommunityRatingStars() {
        //change start buttons depending on location average rating
    }
    
    func updatePersonalRatingStars() {
        //check if rating exists, if not return.
        //else rating, update stars
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}//END OF LOCATION DETAIL VIEW CONTROLLER
