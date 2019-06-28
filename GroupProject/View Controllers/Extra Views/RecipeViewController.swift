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
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var secondaryRecipeNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    //MARK: - Landing Pad / Properties
    var recipe: Recipe?
    var ingredientsText: String {
        var list = ""
        guard let ingredients = recipe?.ingredients else { return "" }
        for item in ingredients {
            if ingredients.last == item {
                list += "\(item)"
                return list
            }
            list += "\(item)\n"
        }
        return list
    }
    var instructionsText: String {
        var list = ""
        var stepNumber = 1
        guard let instructions = recipe?.instructions else { return "" }
        for step in instructions {
            if instructions.last == step {
                list += "\(stepNumber)) \(step)"
                return list
            }
            list += "\(stepNumber)) \(step)\n"
            stepNumber += 1
        }
        return list
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundPhotoAndBlur()
        updateView()
    }
    
    //MARK: - Actions
    
    
    //MARK: - Helper functions
    func updateView() {
        guard let recipe = recipe else { return }
        recipeImageView.image = recipe.image
        recipeImageView.layer.borderWidth = 3
        recipeImageView.layer.borderColor = UIColor.white.cgColor
        setupLabels()
    }
    
    func setupLabels() {
        guard let recipe = recipe else { return }
        secondaryRecipeNameLabel.text = recipe.name
        secondaryRecipeNameLabel.backgroundColor = UIColor(white: 1, alpha: 0.5)
        secondaryRecipeNameLabel.layer.masksToBounds = true
        secondaryRecipeNameLabel.layer.cornerRadius = 10
        ingredientsLabel.text = ingredientsText
        ingredientsLabel.backgroundColor = UIColor(white: 1, alpha: 0.5)
        ingredientsLabel.layer.masksToBounds = true
        ingredientsLabel.layer.cornerRadius = 10
        instructionsLabel.text = instructionsText
        instructionsLabel.backgroundColor = UIColor(white: 1, alpha: 0.5)
        instructionsLabel.layer.masksToBounds = true
        instructionsLabel.layer.cornerRadius = 10
    }
    
    func backgroundPhotoAndBlur() {
        guard let recipe = recipe else { return }
        self.view.backgroundColor = UIColor(patternImage: recipe.image)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
    }
    
    //Should we have a share recipe button or a way to create email to send recipe raw data?

}//END OF RECIPE DETAIL VIEW CONTROLLER
