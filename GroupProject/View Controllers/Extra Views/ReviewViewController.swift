//
//  ReviewViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var drinkNameTextField: CustomTextField!
    @IBOutlet weak var drinkPriceTextField: CustomTextField!
    @IBOutlet weak var oneStarButton: UIButton!
    @IBOutlet weak var twoStarButton: UIButton!
    @IBOutlet weak var threeStarButton: UIButton!
    @IBOutlet weak var fourStarButton: UIButton!
    @IBOutlet weak var fiveStarButton: UIButton!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var flavorOneLabel: UILabel!
    @IBOutlet weak var flavorTwoLabel: UILabel!
    @IBOutlet weak var flavorThreeLabel: UILabel!
    @IBOutlet weak var flavorFourLabel: UILabel!
    @IBOutlet weak var flavorFiveLabel: UILabel!
    @IBOutlet weak var flavorOneSlider: UISlider!
    @IBOutlet weak var flavorTwoSlider: UISlider!
    @IBOutlet weak var flavorThreeSlider: UISlider!
    @IBOutlet weak var flavorFourSlider: UISlider!
    @IBOutlet weak var flavorFiveSlider: UISlider!
    
    //MARK: - Properties / Landing pad
    var business: Business?
    var review: JuiceReview?
    var rating: Int = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        updateSliderImages()
        restaurantNameLabel.text = business?.name
        guard let review = self.review else {print("the page has no review."); return}
        self.rating = review.drinkRating
        updateViews(withReview: review)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let review = self.review{
            self.updateExistingReview(review: review)
        } else {
            saveNewReview()
        }
        print("savebois 🥦🥦🥦")
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func oneStarTapped(_ sender: UIButton) {
        self.rating = 1
        updateStarButtons()
    }
    @IBAction func twoStarTapped(_ sender: UIButton) {
        self.rating = 2
        updateStarButtons()
    }
    @IBAction func threeStarTapped(_ sender: UIButton) {
        self.rating = 3
        updateStarButtons()
    }
    @IBAction func fourStarTapped(_ sender: UIButton) {
        self.rating = 4
        updateStarButtons()
    }
    @IBAction func fiveStarTapped(_ sender: UIButton) {
        self.rating = 5
        updateStarButtons()
    }
    @IBAction func sliderOneChanged(_ sender: UISlider) {
        let newValue = Int(sender.value)
        sender.setValue(Float(newValue), animated: false)
        flavorOneLabel.text = "\(JuiceReviewController.shared.flavorOne): \(newValue)"
        
    }
    @IBAction func sliderTwoChanged(_ sender: UISlider) {
        let newValue = Int(sender.value)
        sender.setValue(Float(newValue), animated: false)
        flavorTwoLabel.text = "\(JuiceReviewController.shared.flavorTwo): \(newValue)"
    }
    @IBAction func sliderThreeChanged(_ sender: UISlider) {
        let newValue = Int(sender.value)
        sender.setValue(Float(newValue), animated: false)
        flavorThreeLabel.text = "\(JuiceReviewController.shared.flavorThree): \(newValue)"
    }
    @IBAction func sliderFourChanged(_ sender: UISlider) {
        let newValue = Int(sender.value)
        sender.setValue(Float(newValue), animated: false)
        flavorFourLabel.text = "\(JuiceReviewController.shared.flavorFour): \(newValue)"
    }
    @IBAction func sliderFiveChanged(_ sender: UISlider) {
        let newValue = Int(sender.value)
        sender.setValue(Float(newValue), animated: false)
        flavorFiveLabel.text = "\(JuiceReviewController.shared.flavorFive): \(newValue)"
    }
    
    //MARK: - Helper Functions
    func saveNewReview(){
        //grab data from all the fields!
        guard let reviewComments = self.notesTextView.text, let price = self.drinkPriceTextField.text, let drinkName = self.drinkNameTextField.text, let business = self.business else {print("There's not enough info to make a review."); return}
        let sliderOneValue = Int(flavorOneSlider.value)
        let sliderTwoValue = Int(flavorTwoSlider.value)
        let sliderThreeValue = Int(flavorThreeSlider.value)
        let sliderFourValue = Int(flavorFourSlider.value)
        let sliderFiveValue = Int(flavorFiveSlider.value)
        print("Here's what we've got for the review: \(price), \(drinkName), \(business.name), \(business.businessID), \(sliderOneValue), \(sliderTwoValue), \(sliderThreeValue), \(sliderFourValue), \(sliderFiveValue)")
        JuiceReviewController.shared.createReview(businessID: business.businessID, restarauntName: business.name, drinkName: drinkName, price: price, drinkRating: rating, drinkReview: reviewComments, dimension1: sliderOneValue, dimension2: sliderTwoValue, dimension3: sliderThreeValue, dimension4: sliderFourValue, dimension5: sliderFiveValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateExistingReview(review: JuiceReview){
        //grab data from all the fields!
        guard let reviewComments = self.notesTextView.text, let price = self.drinkPriceTextField.text, let drinkName = self.drinkNameTextField.text else {print("There's not enough info to make a review."); return}
        let sliderOneValue = Int(flavorOneSlider.value)
        let sliderTwoValue = Int(flavorTwoSlider.value)
        let sliderThreeValue = Int(flavorThreeSlider.value)
        let sliderFourValue = Int(flavorFourSlider.value)
        let sliderFiveValue = Int(flavorFiveSlider.value)
        review.drinkReview = reviewComments
        review.drinkPrice = price
        review.drinkName = drinkName
        review.drinkRating = rating
        review.dimension1 = sliderOneValue
        review.dimension2 = sliderTwoValue
        review.dimension3 = sliderThreeValue
        review.dimension4 = sliderFourValue
        review.dimension5 = sliderFiveValue
        guard let user = UserController.shared.currentUser else {print("couldn't unwrap the user for \(#function)"); return}
        let userDict = UserController.shared.createDictionary(fromUser: user)
        UserController.shared.saveUserDocument(data: userDict) { (success) in
            print("Saved user document during \(#function): \(success)")
        }
    }
    
    func updateViews(withReview review: JuiceReview){
        self.updateLabels()
        self.drinkNameTextField.text = review.drinkName
        self.restaurantNameLabel.text = review.businessName
        self.drinkPriceTextField.text = review.drinkPrice
        self.updateStarButtons()
        self.notesTextView.text = review.drinkReview
        self.flavorOneSlider.value = Float(review.dimension1)
        self.flavorTwoSlider.value = Float(review.dimension2)
        self.flavorThreeSlider.value = Float(review.dimension3)
        self.flavorFourSlider.value = Float(review.dimension4)
        self.flavorFiveSlider.value = Float(review.dimension5)
        
    }
    
    func updateLabels() {
        if let review = review {
            flavorOneLabel.text = "\(JuiceReviewController.shared.flavorOne): \(review.dimension1)"
            flavorTwoLabel.text = "\(JuiceReviewController.shared.flavorTwo): \(review.dimension2)"
            flavorThreeLabel.text = "\(JuiceReviewController.shared.flavorThree): \(review.dimension3)"
            flavorFourLabel.text = "\(JuiceReviewController.shared.flavorFour): \(review.dimension3)"
            flavorFiveLabel.text = "\(JuiceReviewController.shared.flavorFive): \(review.dimension5)"
        } else {
            flavorOneLabel.text = "\(JuiceReviewController.shared.flavorOne): 0"
            flavorTwoLabel.text = "\(JuiceReviewController.shared.flavorTwo): 0"
            flavorThreeLabel.text = "\(JuiceReviewController.shared.flavorThree): 0"
            flavorFourLabel.text = "\(JuiceReviewController.shared.flavorFour): 0"
            flavorFiveLabel.text = "\(JuiceReviewController.shared.flavorFive): 0"
        }
    }
    
    func updateStarButtons(){
        print("rating: \(self.rating)")
        switch self.rating{
        case 1:
            oneStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
        case 2:
            oneStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
        case 3:
            oneStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
        case 4:
            oneStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
        case 5:
            oneStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "fullstar"), for: .normal)
        default:
            oneStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "UnlikedStar"), for: .normal)
        }
    }
    
    func updateSliderImages() {
        flavorOneSlider.setThumbImage(UIImage(named: "protein"), for: .normal)
        flavorOneSlider.minimumTrackTintColor = UIColor(ciColor: .green)
        flavorOneSlider.maximumTrackTintColor = UIColor(ciColor: .red)
        flavorTwoSlider.setThumbImage(UIImage(named: "fruit"), for: .normal)
        flavorTwoSlider.minimumTrackTintColor = UIColor(ciColor: .green)
        flavorTwoSlider.maximumTrackTintColor = UIColor(ciColor: .red)
        flavorThreeSlider.setThumbImage(UIImage(named: "vegetable"), for: .normal)
        flavorThreeSlider.minimumTrackTintColor = UIColor(ciColor: .green)
        flavorThreeSlider.maximumTrackTintColor = UIColor(ciColor: .red)
        flavorFourSlider.setThumbImage(UIImage(named: "creaminess"), for: .normal)
        flavorFourSlider.minimumTrackTintColor = UIColor(ciColor: .green)
        flavorFourSlider.maximumTrackTintColor = UIColor(ciColor: .red)
        flavorFiveSlider.setThumbImage(UIImage(named: "flavor"), for: .normal)
        flavorFiveSlider.minimumTrackTintColor = UIColor(ciColor: .green)
        flavorFiveSlider.maximumTrackTintColor = UIColor(ciColor: .red)
    }
}
