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
    
    //this is just here for testing
    override func viewDidAppear(_ animated: Bool) {
        imagePicker.present(from: profilePhotoImageView)
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
        print(UserController.shared.currentUser?.username)
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
        switch collectionView{
        case visitedCollectionView:
            return 5
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView{
        case visitedCollectionView:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == reviewCollectionView{
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? ReviewCollectionViewCell else {return UICollectionViewCell()}
////            guard let review = user?.businessReviews[indexPath.row] else { return UICollectionViewCell() }
//            cell.drinkNameLabel.text = "review.text"
//            cell.restaurantNameLabel.text = "INSERT NAME OF LOCATION"
//            return cell
//        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "juiceCell", for: indexPath) as? VisitedCollectionViewCell else {return UICollectionViewCell()}
            cell.juiceImageView.image = UIImage(named: "DefaultProfileImage")
            return cell
        }
    }

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


