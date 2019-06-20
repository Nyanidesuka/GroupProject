//
//  RecipeViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var secondaryRecipeNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    //MARK: - Landing Pad / Properties
    var recipe: Recipe?
    
    
    //MARK: - Properties
    //Need landing pad, optional recipe for navigation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    //MARK: - Helper functions
    func updateView() {
        guard let recipe = recipe else { return }
        recipeNameLabel.text = recipe.name
        recipeImageView.image = recipe.image
        secondaryRecipeNameLabel.text = recipe.name
        ingredientsLabel.text = recipe.ingredients
    }
    
    //Should we have a share recipe button or a way to create email to send recipe raw data?

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
