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
        let recipe1 = Recipe(name: "Creamy Banana Strawberry Split Smoothie", image: UIImage(named: "recipe1") ?? UIImage(named: "default")!, ingredients: "INGREDIENTS:\n1 cup almond milk\n1 chopped banana, frozen\n3/4 cup strawberries\n3 ice cubes\n1 scoop vanilla protein powder\n1 teaspoon vanilla extract\n1 teaspoon honey\n1 teaspoon ground flax seed\n1 teaspoon ground chia seeds\n1/2 teaspoon ground cinnamon\n\nINSTRUCTIONS:\nBlend almond milk, banana, strawberries, ice cubes, protein powder, vanilla extract, honey, ground flax seeds, ground chia seeds, and cinnamon in a blender until smooth.")
        let recipe2 = Recipe(name: "Raw Mango Monster Smoothie", image: UIImage(named: "recipe2") ?? UIImage(named: "default")!, ingredients: "INGREDIENTS:\n1 tablespoon flax seeds\n2 tablespoons pepitas (raw pumpkin seeds)\n1 ripe mango, cubed\n1 frozen banana, quartered\n1/3 cup water, to taste\n3 ice cubes\n2 leaves kale, to taste\n\nINSTRUCTIONS:\n1) Blend flax seeds in a blender until finely ground; add pepitas and blend until ground, about 1 minute.\n2) Place mango, banana, water, ice cubes, and kale in the blender; blend until smooth, kale is fully incorporated, and the smoothie is uniform in color, about 3 minutes. Thin with more water to reach desired consistency.")
        let recipe3 = Recipe(name: "The Georgia Peach", image: UIImage(named: "recipe3") ?? UIImage(named: "default")!, ingredients: "INGREDIENTS:\n2 small peaches, pitted and diced\n1/2 cup coconut milk\n1/2 cup Greek yogurt\n1/4 cup skim milk\n\nINSTRUCTIONS:\nBlend peaches, coconut milk, yogurt, and milk together in a blender until smooth.")
        let recipe4 = Recipe(name: "Key Lime Pie Smoothie", image: UIImage(named: "recipe4") ?? UIImage(named: "default")!, ingredients: "INGREDIENTS:\n1 1/2 cup ice, to taste\n1 (6 oz.) container key lime-flavored Greek yogurt\n1 frozen banana, chunked\n1 tablespoon heavy whipping cream, to taste\n1 splash orange juice\n\nINSTRUCTIONS:\nBlend ice, yogurt, banana, cream, and orange juice together in a blender until smooth.")
        let recipe5 = Recipe(name: "Pina Colada Smoothie", image: UIImage(named: "recipe5") ?? UIImage(named: "default")!, ingredients: "INGREDIENTS:\n1 cup frozen pineapple chunks\n1 cup frozen mango chunks\n1 cup toasted coconut vanilla Greek yogurt\n1/4 cup milk, to taste\n\nINSTRUCTIONS:\nBlend pineapple, mango, yogurt, and milk together in a blender until smooth and creamy.")
        let recipe6 = Recipe(name: "Carrot Cake Smoothie", image: UIImage(named: "recipe6") ?? UIImage(named: "default")!, ingredients: "INGREDIENTS:\n1 large carrot, peeled and diced\n1/4 cup frozen mango chunks\n1 large fresh peach, chopped\n1/4 cup soy milk, to taste\n1 tablespoon ground cinnamon\n1 teaspoon ground allspice\n1teaspoon ground ginger\n\nINSTRUCTIONS: Pulse carrot and mango together in a blender until roughly chopped. Add peach, soy milk, cinnamon, allspice, and ginger; blend until smooth.")
        let recipe7 = Recipe(name: "Mango Cherry Smoothie", image: UIImage(named: "recipe7") ?? UIImage(named: "default")!, ingredients: "INGREDIENTS:\n2 cups pitted cherries\n1 cup chopped mango\n1 cup water, to taste\n1 cup ice cubes\n\nINSTRUCTIONS:\nBlend cherries, mango, water, and ice cubes together in a blender until smooth.")
        let recipe8 = Recipe(name: "Peanut Butter Banana Smoothie", image: UIImage(named: "recipe8") ?? UIImage(named: "default")!, ingredients: "INGREDIENTS:\n2 bananas, broken into chunks\n2 cups milk\n1/2 cup peanut butter\n2 tablespoons honey, to taste\n2 cups ice cubes\n\nINSTRUCTIONS:\nPlace bananas, milk, peanut butter, honey, and ice cubes in a blender; blend until smooth, about 30 seconds.")
        let recipe9 = Recipe(name: "Gramma's Cranberry Smoothie", image: UIImage(named: "recipe9") ?? UIImage(named: "default")!, ingredients: "INGREDIENTS:\n1 cup almond milk\n1 banana, chopped\n1/2 cup frozen mixed berries\n1/2 cup fresh cranberries\n\nINSTRUCTIONS:\n1) Blend almond milk, banana, mixed berries, and cranberries in a blender until smooth.\n2) Refrigerate until chilled, at least 1 hour.")
        let recipe10 = Recipe(name: " ", image: UIImage(named: "") ?? UIImage(named: "default")!, ingredients: "")
        let recipe11 = Recipe(name: " ", image: UIImage(named: "") ?? UIImage(named: "default")!, ingredients: "")
        let recipe12 = Recipe(name: " ", image: UIImage(named: "") ?? UIImage(named: "default")!, ingredients: "")
        let recipe13 = Recipe(name: " ", image: UIImage(named: "") ?? UIImage(named: "default")!, ingredients: "")
        
        let baseArray = [recipe1, recipe2, recipe3, recipe4, recipe5, recipe6, recipe7, recipe8, recipe9]
        let recipeArray = baseArray.shuffled()
        
        return recipeArray
    }
}//END OF EXTENSION
