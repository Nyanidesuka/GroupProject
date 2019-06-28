//
//  JuiceReviewController.swift
//  GroupProject
//
//  Created by Haley Jones on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class JuiceReviewController{
    //MARK: - Singleton
    static let shared = JuiceReviewController()
    private init() {}
    
    //MARK: - Properties
    let flavorOne = "Protein"
    let flavorTwo = "Fruit"
    let flavorThree = "Vegetables"
    let flavorFour = "Creaminess"
    let flavorFive = "Flavor/Add-Ins"
    
    //MARK: - CRUD Functions
    
    func createReview(businessID: String, restarauntName: String, drinkName: String, price: String, drinkRating: Int, drinkReview: String, dimension1: Int, dimension2: Int, dimension3: Int, dimension4: Int, dimension5: Int, imageDocReference: String){
        let newJuiceReview = JuiceReview(businessID: businessID, businessName: restarauntName, drinkName: drinkName, drinkPrice: price, drinkRating: drinkRating, drinkReview: drinkReview, dimension1: dimension1, dimension2: dimension2, dimension3: dimension3, dimension4: dimension4, dimension5: dimension5, imageDocReference: imageDocReference)
        guard let user = UserController.shared.currentUser else {return}
        user.juiceReviews.append(newJuiceReview)
        let userDict = UserController.shared.createDictionary(fromUser: user)
        UserController.shared.saveUserDocument(data: userDict) { (success) in
            print("created a new review, added it to the user, and saved that user document.🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️")
        }
    }
    
    func deleteReview(review: JuiceReview){
        guard let user = UserController.shared.currentUser else {print("couldnt unwrap the current user. 🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️"); return}
        guard let index = user.juiceReviews.firstIndex(where: {$0.businessID == review.businessID && $0.drinkReview == review.drinkReview}) else {print("that review isn't in this user's drink reviews. 🙆‍♀️🙆‍♀️🙆‍♀️"); return}
        user.juiceReviews.remove(at: index)
        let userDict = UserController.shared.createDictionary(fromUser: user)
        UserController.shared.saveUserDocument(data: userDict) { (success) in
            print("deleted the review and saved the document.🙆‍♀️🙆‍♀️🙆‍♀️")
        }
    }
    //this one isnt fully working yet
    func updateReview(review: JuiceReview){
        guard let user  = UserController.shared.currentUser else {return}
        let userDict = UserController.shared.createDictionary(fromUser: user)
        UserController.shared.saveUserDocument(data: userDict) { (success) in
            print("updated the review and saved the document.🙆‍♀️🙆‍♀️🙆‍♀️")
        }
    }
    
    
    //this function creates a dictionary from a juice review so we can save it to firestore
    func createDictionary(fromJuiceReview reviews: [JuiceReview]) -> [[String : Any]]{
        var returnArray: [[String : Any]] = []
        for review in reviews{
            let reviewDictionary: [String : Any] = ["businessID" : review.businessID, "businessName" : review.businessName, "drinkName" : review.drinkName, "drinkPrice" : review.drinkPrice, "drinkRating" : review.drinkRating, "drinkReview" : review.drinkReview, "dimension1" : review.dimension1, "dimension2" : review.dimension2, "dimension3" : review.dimension3, "dimension4" : review.dimension4, "dimension5" : review.dimension5, "imageDocReference" : review.imageDocReference]
            returnArray.append(reviewDictionary)
        }
        return returnArray
    }
}

