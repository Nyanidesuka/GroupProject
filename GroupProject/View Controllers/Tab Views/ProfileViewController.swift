//
//  ProfileViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UITextView!
    @IBOutlet weak var visitedCollectionView: UICollectionView!
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    //MARK: - Properties
    var imagePicker: ImagePicker!
    var user: User?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        userNameLabel.text = UserController.shared.currentUser?.username
        bioLabel.text = UserController.shared.currentUser?.bio
        
        profilePhotoImageView.layer.cornerRadius = 100
        profilePhotoImageView.clipsToBounds = true
        profilePhotoImageView.layer.borderWidth = 3
        profilePhotoImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}//END OF PROFILE VIEW CONTROLLER

extension ProfileViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        DispatchQueue.main.async {
            self.profilePhotoImageView.image = image
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case reviewCollectionView:
            return (user?.businessReviews.count)!
        case visitedCollectionView:
            return 5
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView{
        case reviewCollectionView:
            return 1
        case visitedCollectionView:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == reviewCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? ReviewCollectionViewCell else {return UICollectionViewCell()}
            guard let review = user?.businessReviews[indexPath.row] else { return UICollectionViewCell() }
            cell.drinkNameLabel.text = review.text
            cell.restaurantNameLabel.text = "INSERT NAME OF LOCATION"
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "juiceCell", for: indexPath) as? VisitedCollectionViewCell else {return UICollectionViewCell()}
            cell.juiceImageView.image = UIImage(named: "DefaultProfileImage")
            return cell
        }
    }
}
