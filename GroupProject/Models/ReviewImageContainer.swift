//
//  ReviewImageContainer.swift
//  GroupProject
//
//  Created by Haley Jones on 6/28/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class ReviewImageContainer{
    static let shared = ReviewImageContainer()
    var images: [UIImage] = []
    
    func fetchReviewImages(forReviews reviews: [JuiceReview], index: Int = 0, completion: @escaping (Bool) -> Void){
        guard reviews.count != 0, let user = UserController.shared.currentUser else { completion(true); return }
        FirebaseService.shared.fetchDocument(documentName: reviews[index].imageDocReference, collectionName: "Images") { (imageDict) in
            guard let imageDict = imageDict, let imageData = imageDict["data"] as? Data, let decodedImage = UIImage(data: imageData) else {print("couldnt unwrap the image dictionary 👁‍🗨👁‍🗨👁‍🗨"); return}
            ReviewImageContainer.shared.images.append(decodedImage)
            if ReviewImageContainer.shared.images.count < user.juiceReviewReferences.count{
                self.fetchReviewImages(forReviews: reviews, index: index + 1, completion: completion)
            } else {
                completion(true)
            }
        }
    }
    func fetchImagesForDetailPage(sender: LocationDetailsViewController, reviews: [JuiceReview], index: Int = 0, completion: @escaping (Bool) -> Void){
        guard reviews.count != 0 else { completion(true); return }
        FirebaseService.shared.fetchDocument(documentName: reviews[index].imageDocReference, collectionName: "Images") { (imageDict) in
            guard let imageDict = imageDict, let imageData = imageDict["data"] as? Data, let decodedImage = UIImage(data: imageData) else {print("couldnt unwrap the image dictionary 👁‍🗨👁‍🗨👁‍🗨"); return}
            sender.juiceReviewImages.append(decodedImage)
            if sender.juiceReviewImages.count < reviews.count{
                self.fetchReviewImages(forReviews: reviews, index: index + 1, completion: completion)
            } else {
                completion(true)
            }
        }
    }
}
