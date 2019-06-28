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
        let recipe1 = Recipe(name: "Creamy Banana Strawberry Split Smoothie", image: UIImage(named: "recipe1") ?? UIImage(named: "default")!, ingredients: ["1 cup almond milk", "1 chopped banana, frozen", "3/4 cup strawberries", "3 ice cubes", "1 scoop vanilla protein powder", "1 teaspoon vanilla extract","1 teaspoon honey", "1 teaspoon ground flax seed", "1 teaspoon ground chia seeds", "1/2 teaspoon ground cinnamon"], instructions: ["Blend almond milk, banana, strawberries, ice cubes, protein powder, vanilla extract, honey, ground flax seeds, ground chia seeds, and cinnamon in a blender until smooth."])
        let recipe2 = Recipe(name: "Raw Mango Monster Smoothie", image: UIImage(named: "recipe2") ?? UIImage(named: "default")!, ingredients: ["1 tablespoon flax seeds", "2 tablespoons pepitas (raw pumpkin seeds)", "1 ripe mango, cubed" , "1 frozen banana, quartered", "1/3 cup water, to taste", "3 ice cubes", "2 leaves kale, to taste"], instructions: ["Blend flax seeds in a blender until finely ground; add pepitas and blend until ground, about 1 minute.", "Place mango, banana, water, ice cubes, and kale in the blender; blend until smooth, kale is fully incorporated, and the smoothie is uniform in color, about 3 minutes.", "Thin with more water to reach desired consistency."])
        let recipe3 = Recipe(name: "The Georgia Peach", image: UIImage(named: "recipe3") ?? UIImage(named: "default")!, ingredients: ["2 small peaches, pitted and diced", "1/2 cup coconut milk", "1/2 cup Greek yogurt", "1/4 cup skim milk"], instructions: ["Blend peaches, coconut milk, yogurt, and milk together in a blender until smooth."])
        let recipe4 = Recipe(name: "Key Lime Pie Smoothie", image: UIImage(named: "recipe4") ?? UIImage(named: "default")!, ingredients: ["1 1/2 cup ice, to taste", "1 (6 oz.) container key lime-flavored Greek yogurt", "1 frozen banana, chunked", "1 tablespoon heavy whipping cream, to taste", "1 splash orange juice"], instructions: ["Blend ice, yogurt, banana, cream, and orange juice together in a blender until smooth."])
        let recipe5 = Recipe(name: "Pina Colada Smoothie", image: UIImage(named: "recipe5") ?? UIImage(named: "default")!, ingredients: ["1 cup frozen pineapple chunks", "1 cup frozen mango chunks", "1 cup toasted coconut vanilla Greek yogurt","1/4 cup milk, to taste"], instructions: ["Blend pineapple, mango, yogurt, and milk together in a blender until smooth and creamy."])
        let recipe6 = Recipe(name: "Carrot Cake Smoothie", image: UIImage(named: "recipe6") ?? UIImage(named: "default")!, ingredients: ["1 large carrot, peeled and diced", "1/4 cup frozen mango chunks", "1 large fresh peach, chopped", "1/4 cup soy milk, to taste", "1 tablespoon ground cinnamon", "1 teaspoon ground allspice", "1 teaspoon ground ginger"], instructions: ["Pulse carrot and mango together in a blender until roughly chopped.", "Add peach, soy milk, cinnamon, allspice, and ginger; blend until smooth."])
        let recipe7 = Recipe(name: "Mango Cherry Smoothie", image: UIImage(named: "recipe7") ?? UIImage(named: "default")!, ingredients: ["2 cups pitted cherries", "1 cup chopped mango", "1 cup water, to taste", "1 cup ice cubes"], instructions: ["Blend cherries, mango, water, and ice cubes together in a blender until smooth."])
        let recipe8 = Recipe(name: "Peanut Butter Banana Smoothie", image: UIImage(named: "recipe8") ?? UIImage(named: "default")!, ingredients: ["2 bananas, broken into chunks", "2 cups milk", "1/2 cup peanut butter", "2 tablespoons honey, to taste", "2 cups ice cubes"], instructions: ["Place bananas, milk, peanut butter, honey, and ice cubes in a blender; blend until smooth, about 30 seconds."])
        let recipe9 = Recipe(name: "Gramma's Cranberry Smoothie", image: UIImage(named: "recipe9") ?? UIImage(named: "default")!, ingredients: ["1 cup almond milk", "1 banana, chopped", "1/2 cup frozen mixed berries", "1/2 cup fresh cranberries"], instructions: ["Blend almond milk, banana, mixed berries, and cranberries in a blender until smooth.", "Refrigerate until chilled, at least 1 hour."])
        let recipe10 = Recipe(name: "Jacksonville Watermelon Slushie", image: UIImage(named: "recipe10") ?? UIImage(named: "default")!, ingredients: ["3 cups ice", "2 cups watermelon chunks", "1/2 cup cantaloupe chunks", "1/4 cup orange juice", "1 tablespoon honey" ,"4 sprigs mint, for garnish (optional)"], instructions: ["Blend the ice, watermelon, cantaloupe, orange juice, and honey together in a blender until no chunks remain and the mixture is a thick slush.", "Garnish with the mint if desired."])
        let recipe11 = Recipe(name: "Watermelon Lime Agua Fresca", image: UIImage(named: "recipe11") ?? UIImage(named: "default")!, ingredients: ["8 cups water, divided", "5 cups peeled, cubed, and seeded watermelon", "1/2 cup white sugar, to taste", "1/3 cup lime juice, to taste"], instructions: ["Combine 1 cup water, watermelon, and sugar in a blender; process until smooth.", "Pour into a large pitcher; stir in lime juice and remaining 7 cups water.", "Adjust sugar or lime juice, to taste.", "Refrigerate until chilled, about 1 hour."])
        let recipe12 = Recipe(name: "Homemade Apple Cider", image: UIImage(named: "recipe12") ?? UIImage(named: "default")!, ingredients: ["10 apples, quartered" ,"3/4 cup white sugar", "1 tablespoon ground cinnamon", "1 tablespoon ground allspice"], instructions: ["Place apples in a large stockpot and add enough water cover by at least 2 inches.", "Stir in sugar, cinnamon, and allspice.", "Bring to a boil. Boil, uncovered, for 1 hour.", "Cover pot, reduce heat, and simmer for 2 hours.", "Strain apple mixture though a fine mesh sieve. Discard solids. Drain cider again though a cheesecloth lined sieve.", "Refrigerate until cold.", ""])
        let recipe13 = Recipe(name: "Agua de Jamaica (Hibiscus Water)", image: UIImage(named: "recipe13") ?? UIImage(named: "default")!, ingredients: ["6 cups water\n2 cups dried hibiscus petals", "1 cinnamon stick", "1 pinch ground cloves", "1 pinch ground nutmeg", "1 pinch ground allspice", "1/2 cup chopped piloncillo (Mexican brown sugar cones)", "1 1/2 cups white sugar"], instructions: ["Place 6 cups of water in a large saucepan; bring to a boil.", "Stir in the hibiscus petals, cinnamon, cloves, nutmeg, and allspice.", "Reduce heat to medium-low, and gently simmer until the water has turned a deep red, 30 to 45 minutes.", "Stir the chopped piloncillo into the hibiscus water until dissolved, then set aside to cool 15 minutes.", "After cooling, strain the warm liquid into a 1 gallon pitcher through a wire mesh strainer.", "Squeeze as much liquid from the petals as you can, then discard the petals.", "Stir in the white sugar until dissolved, then pour in enough cold water to fill the pitcher.", "Serve immediately or let stand overnight for best taste.", ""])
        
        let baseArray = [recipe1, recipe2, recipe3, recipe4, recipe5, recipe6, recipe7, recipe8, recipe9, recipe10, recipe11, recipe12, recipe13]
        let recipeArray = baseArray.shuffled()
        
        return recipeArray
    }
}//END OF EXTENSION

