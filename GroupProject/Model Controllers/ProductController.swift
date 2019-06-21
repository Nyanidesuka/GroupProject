//
//  ProductController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/21/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import Foundation
import UIKit

class ProductController {
    
    //MARK: - Singleton
    static let sharedInstance = ProductController()
    private init() {}
    
    //MARK: - Source of truth / Properties
    var products: [Product] {
        return createMockData()
    }
    
    
}//END OF PRODUCT CONTROLLER CLASS

extension ProductController {
    func createMockData() -> [Product] {
        let product1 = Product(image: UIImage(named: "product1") ?? UIImage(named: "default")!, name: "Alex's Lemonade Stand Citrus Juicer", rating: 4.5, reviews: 869, description: "“When life hands you lemons, make lemonade.” That expression was exemplified in 2000 by a 4-year-old girl named Alex, who held a lemonade stand to raise money for a cure for childhood cancer, for patients just like her. Alex’s spirit and hope lives on today through the Alex’s Lemonade Stand, a foundation for childhood cancer that we’re proud to support. When you buy the Proctor Silex Citrus Juicer, a part of your purchase goes directly to the foundation to help fund research and support.", level: 0, url: "https://www.amazon.com/Proctor-Silex-66331-Lemonade-Citrus/dp/B008BBCZ3K/")
        let product2 = Product(image: UIImage(named: "product2") ?? UIImage(named: "default")!, name: "Dash Citrus Juicer Extractor", rating: 4.0, reviews: 345, description: "HEALTHIER JUICING: Adjustable pulp control and 32oz container lets you decide how much (or how little) you want, with no additives, preservatives, or extra sugar. Be on your way to healthier, fresh squeezed juice in no time", level: 0, url: "https://www.amazon.com/dp/B011KGTVIY/")
        let product3 = Product(image: UIImage(named: "product3") ?? UIImage(named: "default")!, name: "Migecon - Manual Juicer", rating: 4.5, reviews: 29, description: "Round shape and 12-pin fixed position lid design , more fit your hand and better fix the fruit and make it firmly attached in the reamer when you press down and rotate. Then you can get the juice out efficiently and quickly.", level: 0, url: "https://www.amazon.com/dp/B07H4DWX96/")
        let product4 = Product(image: UIImage(named: "product4") ?? UIImage(named: "default")!, name: "Ainaan - Space Saving Juicer", rating: 5.0, reviews: 16, description: "Premium & healthy material our premium manual citrus juicer is made of high quality food grade ABS material, BPA-free and food grade stainless steel. It's time to say goodbye to the additive drinks. Great hand juicer squeezer and a perfect choice to enjoy your healthy daily life.", level: 0, url: "https://www.amazon.com/dp/B07GWQ8L8B/")
        let product5 = Product(image: UIImage(named: "product5") ?? UIImage(named: "default")!, name: "Geedel - Slow Masticating Juicer", rating: 5.0, reviews: 4, description: "The masticating juicer is only operated by your hands, slow speed without motor means no heat and less friction created, reserves 100% vitamins, enzymes, minerals and other nutrition into the juice. Get this manual juicer and enjoy the most original juice and absorb all the nutrition from the ingredients.", level: 1, url: "https://www.amazon.com/Geedel-Masticating-Extractor-Maximum-Nutrition/dp/B07P5HJXDK/")
        let product6 = Product(image: UIImage(named: "product6") ?? UIImage(named: "default")!, name: "Gourmia - Electric Citrus Juicer", rating: 4.5, reviews: 296, description: "Rotating cone is designed to extract and squeeze out the most juice possible. Accommodates everything from large grapefruits and oranges to small lemons and limes.", level: 1, url: "https://www.amazon.com/dp/B00J72F1YC/")
        let product7 = Product(image: UIImage(named: "product7") ?? UIImage(named: "default")!, name: "Electric Citrus Juicer", rating: 4.3, reviews: 14, description: "Quiet motor operation and anti drip spout. Slide down the window to contain the juice, or lift and let it flow straight into your glass or bottle. Efficient filtration system eliminates all pits and pulp for just purely smooth, nutrient-packed juice.", level: 1, url: "https://www.amazon.com/dp/B07Q2F1CGM/")
        let product8 = Product(image: UIImage(named: "product8") ?? UIImage(named: "default")!, name: "Black + Decker - Countertop Blender", rating: 3.5, reviews: 548, description: "10 Speed Settings with Pulse - Find the right consistency for everything you make with a range of blending speeds", level: 1, url: "https://www.amazon.com/BLACK-DECKER-Countertop-10-Speed-BL2010BG/dp/B00OW16ZR0/")
        let product9 = Product(image: UIImage(named: "product9") ?? UIImage(named: "default")!, name: "Hamilton Beach - Power Elite Jar Blender", rating: 3.0, reviews: 5764, description: "Revolutionary Wave-Action system continuously pulls mixture down into the blades for smooth results every time", level: 1, url: "https://www.amazon.com/dp/B007UXTLFK/")
        let product10 = Product(image: UIImage(named: "product10") ?? UIImage(named: "default")!, name: "Ninja BL480D", rating: 4.5, reviews: 202, description: "1000 Watt motor has the power to crush through whole fruits, vegetables and ice in seconds", level: 1, url: "https://www.amazon.com/dp/B01N7Y3H73/")
        let product11 = Product(image: UIImage(named: "product11") ?? UIImage(named: "default")!, name: "Ninja Mega Kitchen System", rating: 4.8, reviews: 1773, description: "Dishwasher-safe and BPA-free partsIncludes one 1500-watt base, A food processor bowl, 72 oz Total crushing pitcher, two 16 oz Nutri Ninja cups with to-go lids, and a 30-Recipe inspiration guide", level: 1, url: "https://www.amazon.com/dp/B00939I7EK/")
        let product12 = Product(image: UIImage(named: "product12") ?? UIImage(named: "default")!, name: "Blendtec Professional 750", rating: 4.5, reviews: 16, description: "Blendtec blenders are built to the highest professional standards. Our blades are 80% thicker and 10x stronger than other blender blades. No tamper/plunger needed. Professional-grade countertop or in-counter professional blender with 1-touch timed and pre-programmed cycles for smoothies, shakes, soups, crushed ice, juicer, ice cream maker, mixer, and self-cleaning.", level: 2, url: "https://www.amazon.com/Blendtec-Professional-Professional-Grade-Self-Cleaning-Pre-programmed/dp/B013OVPDBM/")
        let product13 = Product(image: UIImage(named: "product13") ?? UIImage(named: "default")!, name: "Blendtec Professional 800", rating: 4.0, reviews: 20, description: "Impact-resistant, BPA-free copolyester WildSide+ jar with Vented Gripper lid", level: 2, url: "https://www.amazon.com/dp/B07K6R73MK/")
        let product14 = Product(image: UIImage(named: "product14") ?? UIImage(named: "default")!, name: "Weston Personal Jar Pro Series", rating: 4.0, reviews: 27, description: "Infinite speed control gives consumers the ultimate control over recipe taste and texture, making it easy to achieve the perfect texture and result for every recipe.", level: 2, url: "https://www.amazon.com/Weston-58918-Personal-Blender-Stainless/dp/B07BW11F66/")
        let product15 = Product(image: UIImage(named: "product15") ?? UIImage(named: "default")!, name: "Breville Commercial Grade", rating: 5.0, reviews: 1, description: "One touch programs feature optimized time/speeds to produce the tastiest results. Create smoother green smoothies and silkier dairy smoothies thanks to the two smoothie programs. Turn ice into snow with pulse/ice crush or get faster cold-to-hot soups easily with the soup program.", level: 2, url: "https://www.amazon.com/dp/B07Q4XTXDS/")
        let product16 = Product(image: UIImage(named: "product16") ?? UIImage(named: "default")!, name: "Hurom H-AE Limited Edition Slow Juicer", rating: 3.5, reviews: 10, description: "Slow squeeze technology: the H-AE slow juicer rotates at a speed of just 43 revolutions per minute to mimic the motion of a hand squeezing juice.", level: 2, url: "https://www.amazon.com/Hurom-H-AE-Slow-Juicer-Dark/dp/B0751B7YKK/")
        let product17 = Product(image: UIImage(named: "product17") ?? UIImage(named: "default")!, name: "Breville's Juice Fountain Elite", rating: 4, reviews: 8, description: "The titanium reinforced disc and Italian-made micro mesh filter basket are made out of stainless steel and together are designed for optimum juice and nutrient extraction.", level: 2, url: "https://www.amazon.com/dp/B07N1XZYJX/")
        let product18 = Product(image: UIImage(named: "product18") ?? UIImage(named: "default")!, name: "Amzchef Slow Masticating Juicer", rating: 4.2, reviews: 119, description: "Juicer Equipped with intelligent protection chips, making it stop automatically for every 20 minutes' operation. And in such case, rest in for 20-30 minutes before restarting it, so as to cool the motor down and prolong product servicelife.", level: 2, url: "https://www.amazon.com/dp/B07QS6DDFC/")
        
        let productArray = [product1, product2, product3, product4, product5, product6, product7, product8, product9, product10, product11, product12, product13, product14, product15, product16, product17, product18]
        return productArray
    }
    
    func createFeaturedProducts() -> [Product] {
        let baseArray = createMockData()
        let shuffledFive = baseArray.shuffled().prefix(5)
        return Array(shuffledFive)
    }
    
    func grabBeginnerProducts() -> [Product] {
        var beginners: [Product] = []
        let products = createMockData()
        for product in products {
            if product.level == 0 {
                beginners.append(product)
            }
        }
        return beginners.shuffled()
    }
    
    func grabIntermediateProducts() -> [Product] {
        var intermediate: [Product] = []
        let products = createMockData()
        for product in products {
            if product.level == 1 {
                intermediate.append(product)
            }
        }
        return intermediate.shuffled()
    }
    
    func grabAdvancedProdcuts() -> [Product] {
        var advanced: [Product] = []
        let products = createMockData()
        for product in products {
            if product.level == 2 {
                advanced.append(product)
            }
        }
        return advanced.shuffled()
    }
    
}//END OF HELPER FUNC EXTENSION
