//
//  tacos.swift
//  jveit-listApp
//
//  Created by Jeffrey Veit on 2/22/21.
//

import Foundation

// Array for storing the items of the list
let cult = [
    Cultural(name: "Catedral de Nuestra Senora de Guadalupe",
        type: .historic,
        shortDescription: "Famous church in Mexicali",
        longDescription: "Beautiful place to visit in Centro Historico de Mexicali. It has been recently renovated and it looks beautiful, a must visit if you are in Mexicali. Especially if you want to enjoy mass in spanish."),
    
    Cultural(name: "Forest and Zoo of the City",
        type: .historic,
        shortDescription: "Retreat from the desert",
        longDescription: "This recreational center is one of the tourist places in Mexicali preferred by families. The forest and zoo has different attractions, such as the Museum of Natural History, the Paseo de las Culturas Prehispánicas, the botanical garden, the green areas and the lake."),
    
    Cultural(name: "Guadalupe Canyon",
        type: .historic,
        shortDescription: "Outdoor Adventure",
        longDescription: "In this canyon located in the Sierra Cucapah there are many activities to satisfy your adventurous spirit: climbing, hiking, flora and fauna observation, mountain biking, visits to archaeological sites and cave paintings, swimming in hot springs; These activities are something that this oasis offers in the middle of the desert."),
    
]

// Tacos class with init method, and declaration variables
class Cultural {
    
    enum `Type`: String {
        case historic = "historic"
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



