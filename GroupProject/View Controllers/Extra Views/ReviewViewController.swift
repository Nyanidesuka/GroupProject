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

    }
    @IBAction func oneStarTapped(_ sender: UIButton) {
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
    }
    @IBAction func sliderTwoChanged(_ sender: UISlider) {
    }
    @IBAction func sliderThreeChanged(_ sender: UISlider) {
    }
    @IBAction func sliderFourChanged(_ sender: UISlider) {
    }
    @IBAction func sliderFiveChanged(_ sender: UISlider) {
    }
    
    
    
    //MARK: - Helper Functions
    func saveReview() {
        //need a create review func in Juice Review Controller to build this
    }
    
    func updateLabels() {
        flavorOneLabel.text = JuiceReviewController.shared.flavorOne
        flavorTwoLabel.text = JuiceReviewController.shared.flavorTwo
        flavorThreeLabel.text = JuiceReviewController.shared.flavorThree
        flavorFourLabel.text = JuiceReviewController.shared.flavorFour
        flavorFiveLabel.text = JuiceReviewController.shared.flavorFive
    }
    
    func updateSliderImages() {
        flavorOneSlider.setThumbImage(UIImage(named: "protein"), for: .normal)
        flavorTwoSlider.setThumbImage(UIImage(named: "fruit"), for: .normal)
        flavorThreeSlider.setThumbImage(UIImage(named: "vegetable"), for: .normal)
        flavorFourSlider.setThumbImage(UIImage(named: "creaminess"), for: .normal)
        flavorFiveSlider.setThumbImage(UIImage(named: "flavor"), for: .normal)
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
