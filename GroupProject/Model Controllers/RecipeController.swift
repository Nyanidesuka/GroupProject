//
//  RecipeController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/18/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import UIKit

class RecipeController {
    
    //MARK: - Singleton
    static let sharedInstance = RecipeController()
    private init() {}
    
    //MARK: - Properties (Source of truth)
    var recipes: [Recipe] {
        return createMockData()
    }
    
}//END OF RECIPE CONTROLLER

extension RecipeController {
    func createMockData() -> [Recipe]{
        let recipe1 = Recipe(name: "Creamy Banana Strawberry Split Smoothie", image: UIImage(named: "recipe1")!, ingredients: "INGREDIENTS:\n1 cup almond milk\n1 chopped banana, frozen\n3/4 cup strawberries\n3 ice cubes\n1 scoop vanilla protein powder\n1 teaspoon vanilla extract\n1 teaspoon honey\n1 teaspoon ground flax seed\n1 teaspoon ground chia seeds\n1/2 teaspoon ground cinnamon\n\nINSTRUCTIONS:\nBlend almond milk, banana, strawberries, ice cubes, protein powder, vanilla extract, honey, ground flax seeds, ground chia seeds, and cinnamon in a blender until smooth.")
        let recipe2 = Recipe(name: "Raw Mango Monster Smoothie", image: UIImage(named: "recipe2")!, ingredients: "INGREDIENTS:\n1 tablespoon flax seeds\n2 tablespoons pepitas (raw pumpkin seeds)\n1 ripe mango, cubed\n1 frozen banana, quartered\n1/3 cup water, to taste\n3 ice cubes\n2 leaves kale, to taste\n\nINSTRUCTIONS:\n1) Blend flax seeds in a blender until finely ground; add pepitas and blend until ground, about 1 minute.\n2) Place mango, banana, water, ice cubes, and kale in the blender; blend until smooth, kale is fully incorporated, and the smoothie is uniform in color, about 3 minutes. Thin with more water to reach desired consistency.")
        let recipe3 = Recipe(name: "", image: UIImage(named: "")!, ingredients: "")
        let recipe4 = Recipe(name: "", image: UIImage(named: "")!, ingredients: "")
        let recipe5 = Recipe(name: "", image: UIImage(named: "")!, ingredients: "")
        let recipe6 = Recipe(name: "", image: UIImage(named: "")!, ingredients: "")
        let recipe7 = Recipe(name: "", image: UIImage(named: "")!, ingredients: "")
        let recipe8 = Recipe(name: "", image: UIImage(named: "")!, ingredients: "")
        let recipe9 = Recipe(name: "", image: UIImage(named: "")!, ingredients: "")
        
        let recipeArray = [recipe1, recipe2, recipe3, recipe4, recipe5, recipe6, recipe7, recipe8, recipe9]
        
        return recipeArray
    }
}//END OF EXTENSION
