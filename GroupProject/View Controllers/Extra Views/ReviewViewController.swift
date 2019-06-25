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
    @IBOutlet weak var locationTextField: CustomTextField!
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
    
    //MARK: - Properties
    var business: Business?
    var review: JuiceReview?
    var rating: Int?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        updateSliderImages()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveReview()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func oneStarTapped(_ sender: UIButton) {
        //NEED TO SET LOCAL RATING VAR WHEN ANY OF THESE ARE TAPPED
    }
    @IBAction func twoStarTapped(_ sender: UIButton) {
    }
    @IBAction func threeStarTapped(_ sender: UIButton) {
    }
    @IBAction func fourStarTapped(_ sender: UIButton) {
    }
    @IBAction func fiveStarTapped(_ sender: UIButton) {
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
    func saveReview() {
//        guard let businessID = business?.businessID,
//        let restaurantName = business?.name,
//        let drinkName = drinkNameTextField.text,
//        let price = Float(drinkPriceTextField.text),
//        let drinkRating = rating,
//            let drinkReview = notesTextView.text else { return }
//        
//
//
//
//        if let review = review {
//            //code if review exists, update
//            JuiceReviewController.shared.
//            JuiceReviewController.shared.updateReview(review: <#T##JuiceReview#>)
//        } else {
//            //create new review
//            JuiceReviewController.shared.createReview(businessID: <#T##String#>, restarauntName: <#T##String#>, drinkName: <#T##String#>, price: <#T##Float#>, drinkRating: <#T##Int#>, drinkReview: <#T##String#>, dimension1: <#T##Int#>, dimension2: <#T##Int#>, dimension3: <#T##Int#>, dimension4: <#T##Int#>, dimension5: <#T##Int#>)
//        }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
