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
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    @IBOutlet weak var changePictureButton: UIButton!
    @IBOutlet weak var editableUsernameLabel: UITextField!
    @IBOutlet weak var saveProfileButton: CustomBarButtonItems!
    
    
    
    //MARK: - Properties
    var imagePicker: ImagePicker!
    var user: User? = {
        return UserController.shared.currentUser
    }()
    var editMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        userNameLabel.text = UserController.shared.currentUser?.username
        bioLabel.text = UserController.shared.currentUser?.bio
        bioLabel.layer.borderColor = UIColor.clear.cgColor
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.height / 2
        changePictureButton.layer.cornerRadius = changePictureButton.frame.height / 2
        profilePhotoImageView.clipsToBounds = true
        saveProfileButton.addCornerRadius()
        if let photoData = UserController.shared.currentUser?.photoData{
            self.profilePhotoImageView.image = UIImage(data: photoData)
        } else {
            print("there's no image data")
            self.profilePhotoImageView.image = UIImage(named: "default")
        }
        print("Current User Juice Reviews:\(UserController.shared.currentUser?.juiceReviewReferences.count) 🥦🥦🥦🥦")
        guard let photoReference = UserController.shared.currentUser?.photoReference else {return}
        FirebaseService.shared.fetchDocument(documentName: photoReference, collectionName: "Profile Pictures") { (pictureDict) in
            guard let pictureDict = pictureDict, let imageData = pictureDict["imageData"] as? Data, let image = UIImage(data: imageData) else {return}
            self.profilePhotoImageView.image = image
        }
        visitedCollectionView.addCornerRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = UserController.shared.currentUser else {print("there's no user. 👁‍🗨👁‍🗨👁‍🗨"); return}
        ReviewImageContainer.shared.fetchReviewImages(forReviews: user.juiceReviews) { (success) in
            self.visitedCollectionView.reloadData()
        }
        self.reviewCollectionView.reloadData()
        self.visitedCollectionView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        if !editMode{
            editMode = true
            userNameLabel.alpha = 0
            self.editableUsernameLabel.alpha = 1
            self.editableUsernameLabel.isUserInteractionEnabled = true
            self.editableUsernameLabel.text = self.userNameLabel.text
            self.editableUsernameLabel.font = self.userNameLabel.font
            self.bioLabel.isEditable = true
            self.bioLabel.isUserInteractionEnabled = true
            bioLabel.layer.borderColor = UIColor.lightGray.cgColor
            self.changePictureButton.alpha = 1
            self.changePictureButton.isUserInteractionEnabled = true
            self.changePictureButton.isEnabled = true
            self.editProfileButton.setTitle("Cancel", for: .normal)
            self.saveProfileButton.alpha = 1
            self.saveProfileButton.isEnabled = true
            self.saveProfileButton.isUserInteractionEnabled = true
        } else {
            editMode = false
            userNameLabel.alpha = 1
            self.editableUsernameLabel.alpha = 0
            self.editableUsernameLabel.isUserInteractionEnabled = false
            self.bioLabel.isEditable = false
            self.bioLabel.isUserInteractionEnabled = false
            self.bioLabel.layer.borderColor = UIColor.clear.cgColor
            self.changePictureButton.alpha = 0
            self.changePictureButton.isUserInteractionEnabled = false
            self.changePictureButton.isEnabled = false
            self.editProfileButton.setTitle("Edit", for: .normal)
            self.saveProfileButton.alpha = 0
            self.saveProfileButton.isEnabled = false
            self.saveProfileButton.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func saveProfileButtonTapped(_ sender: Any) {
        guard let user = UserController.shared.currentUser,
            let newUsername = self.editableUsernameLabel.text else {return}
        user.username = newUsername
        user.bio = bioLabel.text
        saveProfilePicture()
        userNameLabel.text = newUsername
        let userDict = UserController.shared.createDictionary(fromUser: user)
        UserController.shared.saveUserDocument(data: userDict) { (success) in
            print("saved the user to the store with the new image")
        }
    }
    
    @IBAction func changePictureButtonTapped(_ sender: Any) {
        self.imagePicker.present(from: self.view)
    }
    
    func saveProfilePicture(){
        guard let user = UserController.shared.currentUser else {print("couldnt unwrap the user🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️"); return}
        guard let image = self.profilePhotoImageView.image, let imageData = image.jpegData(compressionQuality: 0.7) else {print("couldn't unwrap the image. 🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️"); return}
        user.photoData = imageData
        //create a document from the photo, send it to firebase, save a ref to it within the user.
        let profilePhoto = ProfilePhoto(imageData: imageData)
        user.photoReference = profilePhoto.uuid
        let pfpDict: [String : Any] = ["uuid" : profilePhoto.uuid, "imageData" : profilePhoto.imageData]
        FirebaseService.shared.addDocument(documentName: profilePhoto.uuid, collectionName: "Profile Pictures", data: pfpDict) { (_) in
            //delete the old pfp if its in here.
            FirebaseService.shared.deleteDocument(documentName: profilePhoto.uuid, collectionName: "Profile Pictures", completion: { (success) in
                print("finished deleting the profile old pfp: \(success)")
            })
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toJuiceLocationDetail":
            guard let indexPath = self.visitedCollectionView.indexPathsForSelectedItems?.first,
                let destinationVC = segue.destination as? LocationDetailsViewController else { return }
            let location = user?.likedBusinesses[indexPath.row]
            destinationVC.location = location
        case "toJuiceReview":
            guard let destinVC = segue.destination as? ReviewViewController, let index = self.reviewCollectionView.indexPathsForSelectedItems?.first, let user = UserController.shared.currentUser, user.juiceReviews.count > 0 else {return}
            print(user.likedBusinesses.count)
            let business = user.likedBusinesses[index.section]
            let review = user.juiceReviews[index.row]
            destinVC.review = review
            destinVC.business = business
        default:
            print("Error in segue from profile tab")
        }
    }
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
        guard let user = UserController.shared.currentUser else {return 0}
        if collectionView == visitedCollectionView{
            return max(1, user.likedBusinesses.count)
        } else {
            return max(1, user.juiceReviews.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == visitedCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "juiceCell", for: indexPath) as? VisitedCollectionViewCell else { return UICollectionViewCell() }
            if user?.likedBusinesses.count == 0 {
                cell.juiceImageView.image = UIImage(named: "NoRating")
                cell.locationLabel.text = "Search and rate!"
                cell.isUserInteractionEnabled = false
                return cell
            }
            if let location = user?.likedBusinesses[indexPath.row] {
                guard let data = grabImageDataFor(business: location) else { return UICollectionViewCell() }
                cell.juiceImageView.image = UIImage(data: data)
                cell.locationLabel.text = location.name
                return cell
            }
            cell.juiceImageView.image = UIImage(named: "NoRating")
            cell.locationLabel.text = "Search and rate!"
            return cell
        } else {
            print("calling the collection view delegate for the juicereview collection ✓✓✓✓✓✓✓✓✓✓✓✓✓")
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? JuiceReviewCollectionViewCell else {return UICollectionViewCell()}
            cell.reviewImageView.addCornerRadius()
            if user?.juiceReviews.count == 0{
                cell.reviewImageView.image = UIImage(named: "default")
                cell.drinkNameLabel.text = "Review a juice to see it show up here!"
                return cell
            } else {
                guard let review = user?.juiceReviews[indexPath.row] else {return UICollectionViewCell()}
                cell.drinkNameLabel.text = review.drinkName
                cell.reviewImageView.image = ReviewImageContainer.shared.images[indexPath.row]
                cell.reviewImageView.clipsToBounds = true
                cell.reviewImageView.layer.cornerRadius = 20
                cell.updateStarButtons(withReview: review)
                return cell
            }
        }
    }
    
    func grabImageDataFor(business: Business) -> Data? {
        guard let urlString = URL(string: business.baseImage) else { return nil }
        do {
            let imageData = try Data(contentsOf: urlString)
            return imageData
        } catch  {
            print(error.localizedDescription)
        }
        return nil
    }
}//END OF EXTENSIONS FOR VISITED COLLECTION VIEW

extension ProfileViewController {
    func presentSimpleInputAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Creating text field
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter bio here"
        }
        //Create actions
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let bioAction = UIAlertAction(title: "Bio", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text,
                !name.isEmpty else { return }
            //CODE TO UPDATE user bio data func
            //UPDATE VIEW?
        }
        let photoAction = UIAlertAction(title: "Photo", style: .default) { (_) in
            self.imagePicker.present(from: self.view)
        }
        //Add actions/present
        alertController.addAction(bioAction)
        alertController.addAction(photoAction)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true)
    }
    
}//END OF ALERT CONTROLLER EXTENSION
