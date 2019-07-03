//
//  ReviewViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController, UITextViewDelegate {
    
    //MARK: - Outlets
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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var meter1ImageView: UIImageView!
    
    //MARK: - Properties / Landing pad
    var business: Business?{
        didSet{
            loadViewIfNeeded()
            self.navigationItem.title = self.business?.name
        }
    }
    var review: JuiceReview?{
        didSet{
            print("wow the review var sure got set. 🚹🚹")
            loadViewIfNeeded()
            self.navigationItem.title = review?.businessName
            guard let review = self.review else {print("the page has no review."); return}
            self.rating = review.drinkRating
            updateViews(withReview: review)
        }
    }
    var rating: Int = 0
    var imagePicker: ImagePicker!
    var sender: LocationDetailsViewController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        reviewImageView.addCornerRadius()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        updateLabels()
        updateSliderImages()
        notesTextView.delegate = self
    }
    
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let drinkName = drinkNameTextField.text, !drinkName.isEmpty else {
            let noNameAlert = UIAlertController(title: "Woah there.", message: "We need to have a name for the juice you're reviewing.", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Got it.", style: .default) { (action) in
                noNameAlert.dismiss(animated: true, completion: nil)
            }
            noNameAlert.addAction(closeAction)
            self.present(noNameAlert, animated: true)
            return
        }
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
    
    @IBAction func imageButtonTapped(_ sender: Any) {
        self.imagePicker.present(from: self.view)
    }
    
    
    //MARK: - Helper Functions
    func saveNewReview(){
        //grab data from all the fields!
        guard let reviewComments = self.notesTextView.text, let price = self.drinkPriceTextField.text, let drinkName = self.drinkNameTextField.text, let business = self.business, let imageData = reviewImageView.image?.jpegData(compressionQuality: 0.7) else {print("There's not enough info to make a review. 🥐🥐🥐"); return}
        let sliderOneValue = Int(flavorOneSlider.value)
        let sliderTwoValue = Int(flavorTwoSlider.value)
        let sliderThreeValue = Int(flavorThreeSlider.value)
        let sliderFourValue = Int(flavorFourSlider.value)
        let sliderFiveValue = Int(flavorFiveSlider.value)
        //now we make a new image document and save that, and then we make the review and save that to the user.
        let newImageUUID = UUID().uuidString
        FirebaseService.shared.addDocument(documentName: newImageUUID, collectionName: "Images", data: ["data" : imageData]) { (success) in
            print("successfully save the new image document to firestore. 🥐🥐🥐")
        }
        print("Here's what we've got for the review: \(price), \(drinkName), \(business.name), \(business.businessID), \(sliderOneValue), \(sliderTwoValue), \(sliderThreeValue), \(sliderFourValue), \(sliderFiveValue)")
        guard let newReview = JuiceReviewController.shared.createReview(businessID: business.businessID, restarauntName: business.name, drinkName: drinkName, price: price, drinkRating: rating, drinkReview: reviewComments, dimension1: sliderOneValue, dimension2: sliderTwoValue, dimension3: sliderThreeValue, dimension4: sliderFourValue, dimension5: sliderFiveValue, imageDocReference: newImageUUID) else {return}
        //add the new review locally
        sender?.juiceReviews.append(newReview)
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateExistingReview(review: JuiceReview){
        //grab data from all the fields!
        guard let reviewComments = self.notesTextView.text, let price = self.drinkPriceTextField.text, let drinkName = self.drinkNameTextField.text, let business = self.business else {print("There's not enough info to make a review."); return}
        let sliderOneValue = Int(flavorOneSlider.value)
        let sliderTwoValue = Int(flavorTwoSlider.value)
        let sliderThreeValue = Int(flavorThreeSlider.value)
        let sliderFourValue = Int(flavorFourSlider.value)
        let sliderFiveValue = Int(flavorFiveSlider.value)
        //delete the old review image so we dont just endlessly gather images
        FirebaseService.shared.deleteDocument(documentName: review.imageDocReference, collectionName: "Images") { (success) in
            print("tried to delete the old review image. Success: \(success)")
        }
        //time to create a new image document!
        let newImageUUID = UUID().uuidString
        guard let imageData = reviewImageView.image?.jpegData(compressionQuality: 0.7) else {print("Couldn't create image data from the review's image."); return}
        FirebaseService.shared.addDocument(documentName: newImageUUID, collectionName: "Images", data: ["data" : imageData]) { (success) in
            print("Tried to create a new image document in firestore. Success: \(success)")
        }
        JuiceReviewController.shared.updateReview(review: review, drinkName: drinkName, imageDoc: newImageUUID, comments: reviewComments, rating: rating, price: price, dimension1: sliderOneValue, dimension2: sliderTwoValue, dimension3: sliderThreeValue, dimension4: sliderFourValue, dimension5: sliderFiveValue)
    }
    
    func updateViews(withReview review: JuiceReview){
        self.updateLabels()
        self.drinkNameTextField.text = review.drinkName
        self.drinkPriceTextField.text = review.drinkPrice
        self.updateStarButtons()
        self.notesTextView.text = review.drinkReview
        self.flavorOneSlider.value = Float(review.dimension1)
        self.flavorTwoSlider.value = Float(review.dimension2)
        self.flavorThreeSlider.value = Float(review.dimension3)
        self.flavorFourSlider.value = Float(review.dimension4)
        self.flavorFiveSlider.value = Float(review.dimension5)
        FirebaseService.shared.fetchDocument(documentName: review.imageDocReference, collectionName: "Images") { (imageDict) in
            guard let imageDict = imageDict else {print("couldnt unwrap the image dictionary"); return}
            guard let imageData = imageDict["data"] as? Data else {print("couldnt get the data from the image dictionary"); return}
            DispatchQueue.main.async {
                self.reviewImageView.image = UIImage(data: imageData)
                self.reviewImageView.clipsToBounds = true
            }
        }
    }
    
    func updateLabels() {
        if let review = review {
            flavorOneLabel.text = "\(JuiceReviewController.shared.flavorOne): \(review.dimension1)"
            flavorTwoLabel.text = "\(JuiceReviewController.shared.flavorTwo): \(review.dimension2)"
            flavorThreeLabel.text = "\(JuiceReviewController.shared.flavorThree): \(review.dimension3)"
            flavorFourLabel.text = "\(JuiceReviewController.shared.flavorFour): \(review.dimension4)"
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
            oneStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
        case 2:
            oneStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
        case 3:
            oneStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
        case 4:
            oneStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
        case 5:
            oneStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "orange slice"), for: .normal)
        default:
            oneStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
            twoStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
            threeStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
            fourStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
            fiveStarButton.setImage(#imageLiteral(resourceName: "orange slice rank 1"), for: .normal)
        }
    }
    
    func updateSliderImages() {
        flavorOneSlider.setThumbImage(UIImage(named: "protein"), for: .normal)
        flavorOneSlider.minimumTrackTintColor = UIColor(ciColor: .clear)
        flavorOneSlider.maximumTrackTintColor = UIColor(ciColor: .clear)
        flavorTwoSlider.setThumbImage(UIImage(named: "fruit"), for: .normal)
        flavorTwoSlider.minimumTrackTintColor = UIColor(ciColor: .clear)
        flavorTwoSlider.maximumTrackTintColor = UIColor(ciColor: .clear)
        flavorThreeSlider.setThumbImage(UIImage(named: "vegetable"), for: .normal)
        flavorThreeSlider.minimumTrackTintColor = UIColor(ciColor: .clear)
        flavorThreeSlider.maximumTrackTintColor = UIColor(ciColor: .clear)
        flavorFourSlider.setThumbImage(UIImage(named: "creaminess"), for: .normal)
        flavorFourSlider.minimumTrackTintColor = UIColor(ciColor: .clear)
        flavorFourSlider.maximumTrackTintColor = UIColor(ciColor: .clear)
        flavorFiveSlider.setThumbImage(UIImage(named: "flavor"), for: .normal)
        flavorFiveSlider.minimumTrackTintColor = UIColor(ciColor: .clear)
        flavorFiveSlider.maximumTrackTintColor = UIColor(ciColor: .clear)
    }
    
    //MARK: - Helper funcs to set up textView editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter comments"
            textView.textColor = UIColor.lightGray
        }
    }
    
}

extension ReviewViewController: ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        guard let selectedImage = image else {print("couldnt unwrap the selected image"); return}
        reviewImageView.image = selectedImage
    }
}
