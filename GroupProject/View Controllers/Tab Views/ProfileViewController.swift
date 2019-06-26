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
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var editProfileButton: UIButton!
    
    
    //MARK: - Properties
    var imagePicker: ImagePicker!
    var user: User?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        userNameLabel.text = UserController.shared.currentUser?.username
        bioLabel.text = UserController.shared.currentUser?.bio
        
        profilePhotoImageView.layer.cornerRadius = 50
        profilePhotoImageView.clipsToBounds = true
        profilePhotoImageView.layer.borderWidth = 3
        profilePhotoImageView.layer.borderColor = UIColor.white.cgColor
        //set the profile picture
        if let photoData = UserController.shared.currentUser?.photoData{
            self.profilePhotoImageView.image = UIImage(data: photoData)
        } else {
            print("there's no image data")
            self.profilePhotoImageView.image = UIImage(named: "default")
        }
    }

    //MARK: - Actions
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        switch segue.identifier {
        case "toJuiceLocationDetail":
            guard let indexPath = self.visitedCollectionView.indexPathsForSelectedItems?.first,
            let destinationVC = segue.destination as? LocationDetailsViewController else { return }
            let location = user?.likedBusinesses[indexPath.row]
            destinationVC.location = location
        case "toJuiceReviewDetail":
            guard let indexPath = self.reviewTableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? ReviewViewController else { return }
            let review = user?.juiceReviews[indexPath.row]
            destinationVC.review = review
        default:
            print("Error in segue from profile tab")
        }
    }
}//END OF PROFILE VIEW CONTROLLER

extension ProfileViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let user = UserController.shared.currentUser else {print("couldnt unwrap the user🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️"); return}
        guard let image = image, let imageData = image.pngData() else {print("couldn't unwrap the image. 🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️"); return}
        user.photoData = imageData
        let userDict = UserController.shared.createDictionary(fromUser: user)
        UserController.shared.saveUserDocument(data: userDict) { (success) in
            print("saved the user to the store with the new image")
        }
        DispatchQueue.main.async {
            self.profilePhotoImageView.image = image
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = user?.likedBusinesses.count {
            return count
        }
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "juiceCell", for: indexPath) as? VisitedCollectionViewCell else { return UICollectionViewCell() }
        if let location = user?.likedBusinesses[indexPath.row] {
            guard let data = grabImageDataFor(business: location) else { return UICollectionViewCell() }
            cell.juiceImageView.image = UIImage(data: data)
            //NEED INFO TO UPDATE FOR A LABEL THAT DOESN"T EXIST YET IN STORYBOARD
            return cell
        }
            cell.juiceImageView.image = UIImage(named: "NoRating")
        //NEED INFO TO UPDATE FOR A LABEL THAT DOESN"T EXIST YET IN STORYBOARD
            return cell
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
    
}//END OF EXTENSIONS FOR COLLECTION VIEW

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == reviewTableView{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as? ReviewTableViewCell else {return UITableViewCell()}
            cell.drinkNameLabel.text = "review.text"
            cell.restaurantNameLabel.text = "INSERT NAME OF LOCATION"
            return cell
        }
        return UITableViewCell()
    }
}


