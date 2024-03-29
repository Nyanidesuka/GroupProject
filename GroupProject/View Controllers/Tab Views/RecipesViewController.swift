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
    
    @IBOutlet weak var allRecipesHeightConstraint: NSLayoutConstraint!
    
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
        allRecipesHeightConstraint.constant = CGFloat(allRecipesCollectionView.numberOfItems(inSection: 0) * 310)
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
            cell.recipeImageView.clipsToBounds = true
            cell.recipeImageView.layer.cornerRadius = 30
            cell.ingredientCount.text = "\(featuredRecipes[indexPath.row].ingredients.count)"
            cell.timeLabel.text = "\(Double(featuredRecipes[indexPath.row].ingredients.count) * 1.25) mins"
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
        if segue.identifier == "fromFeaturedRecipeToDetail" {
            guard let indexPath = self.featuredCollectionView.indexPathsForSelectedItems?.first else { return }
            guard let destinationVC = segue.destination as? RecipeViewController else { return }
            let recipe = featuredRecipes[indexPath.row]
            destinationVC.recipe = recipe
        }
        if segue.identifier == "fromAllRecipesToDetail" {
            guard let indexPath = self.allRecipesCollectionView.indexPathsForSelectedItems?.first else { return }
            guard let destinationVC = segue.destination as? RecipeViewController else { return }
            let recipe = allRecipes[indexPath.row]
            destinationVC.recipe = recipe
        }
    }
    
}//END OF RECIPES VIEW CONTROLLER

extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == allRecipesCollectionView {
            return CGSize(width: collectionView.frame.width, height: 300)
        } else {
            return CGSize(width: (collectionView.frame.width * 0.70 ), height: collectionView.frame.height)
        }
    }
}
