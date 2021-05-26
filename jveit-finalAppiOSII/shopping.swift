//
//  shopping.swift
//  
//
//  Created by Jeffrey Veit on 5/24/21.
//

import Foundation

// Array for storing the items of the list
let shops = [
    Shopping(name: "Oxxo",
        type: .market,
        shortDescription: "The 7/11 of Mexico",
        longDescription: "Oxxo is a Mexican chain of convenience stores, with over 18,000 stores across Latin America. It is the largest chain of convenience stores in Latin America. Its headquarters are in Monterrey, Nuevo León."),
    
    Shopping(name: "Plaza Cachanilla",
        type: .plaza,
        shortDescription: "Largest Mall in Mexicali",
        longDescription: "Plaza Cachanilla contains a many variety of stores such as La Ley, Walmart. and boasts a food court with options such as tacos, coffee, or chinese food."),
    
    Shopping(name: "Ropa de Mexicali",
        type: .clothes,
        shortDescription: "Clothing Store",
        longDescription: "Contains typical clothing worn in Northern Mexico. You can find shirts, shoes, pants and even Cowboy hats!"),
    
]

// Tacos class with init method, and declaration variables
class Shopping {
    
    enum `Type`: String {
        case market = "market"
        case clothes = "clothes"
        case plaza = "plaza"
    }
    
    var name: String
    var type: Type
    var shortDescription: String
    var longDescription: String
    
    init(name: String, type: Type, shortDescription: String, longDescription: String) {
        self.name = name
        self.type = type
        self.shortDescription = shortDescription
        self.longDescription = longDescription
    }
    
}


