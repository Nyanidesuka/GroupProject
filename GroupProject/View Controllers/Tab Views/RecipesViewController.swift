//
//  RecipesViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var allRecipesCollectionView: UICollectionView!
    
    
    //MARK: - Properties
    let allRecipes: [Recipe] = RecipeController.sharedInstance.recipes
    var featuredRecipes: [Recipe] {
        let shuffled = allRecipes.shuffled()
        let tags = shuffled.prefix(3)
        return Array(tags)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Collection View data
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case featuredCollectionView:
            return allRecipes.count
        case allRecipesCollectionView:
            return featuredRecipes.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case featuredCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredRecipeCell", for: indexPath) as? FeaturedRecipeCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case allRecipesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allRecipesCell", for: indexPath) as? AllRecipesCollectionViewCell else { return UICollectionViewCell () }
            print("")
            return cell
        default:
            return UICollectionViewCell()
        }
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
