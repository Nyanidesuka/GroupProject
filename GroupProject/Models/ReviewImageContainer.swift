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
    
    func fetchAllReviewImages(forUser user: User, index: Int = 0, completion: @escaping (Bool) -> Void){
        guard user.juiceReviews.count != 0 else { completion(true); return }
        FirebaseService.shared.fetchDocument(documentName: user.juiceReviews[index].imageDocReference, collectionName: "Images") { (imageDict) in
            guard let imageDict = imageDict, let imageData = imageDict["data"] as? Data, let decodedImage = UIImage(data: imageData) else {print("couldnt unwrap the image dictionary 👁‍🗨👁‍🗨👁‍🗨"); return}
            ReviewImageContainer.shared.images.append(decodedImage)
            if ReviewImageContainer.shared.images.count < user.juiceReviews.count{
                self.fetchAllReviewImages(forUser: user, index: index + 1, completion: completion)
            } else {
                completion(true)
            }
        }
    }
}
