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
    var featuredRecipes: [Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        setupFeaturedRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.featuredCollectionView.reloadData()
        self.allRecipesCollectionView.reloadData()
    }
    
    //MARK: - Collection View data
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case featuredCollectionView:
            return featuredRecipes.count
        case allRecipesCollectionView:
            return allRecipes.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case featuredCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredRecipeCell", for: indexPath) as? FeaturedRecipeCollectionViewCell else { return UICollectionViewCell() }
            cell.recipeNameLabel.text = featuredRecipes[indexPath.row].name
            cell.recipeImageView.image = featuredRecipes[indexPath.row].image
            return cell
        case allRecipesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allRecipesCell", for: indexPath) as? AllRecipesCollectionViewCell else { return UICollectionViewCell () }
            cell.recipeNameLabel.text = allRecipes[indexPath.row].name
            cell.recipeImageView.image = allRecipes[indexPath.row].image
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    //MARK: - Helper functions
    func setupCollectionViews() {
        self.allRecipesCollectionView.delegate = self
        self.allRecipesCollectionView.dataSource = self
        self.featuredCollectionView.delegate = self
        self.featuredCollectionView.dataSource = self
    }
    
    func setupFeaturedRecipes() {
        let shuffled = allRecipes.shuffled()
        let tags = shuffled.prefix(3)
        featuredRecipes = Array(tags)
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}//END OF RECIPES VIEW CONTROLLER
