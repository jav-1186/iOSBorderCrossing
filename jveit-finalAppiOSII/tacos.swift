//
//  tacos.swift
//
//
//  Created by Jeffrey Veit on 5/24/21.
//

import Foundation

// Array for storing the items of the list
let tacos = [
    Tacos(name: "Carne Asada",
        type: .beef,
        shortDescription: "Baja California Steak Tacos",
        longDescription: "Carne asada is a dish of grilled and sliced beef, usually skirt steak, sirloin steak, tenderloin steak, or rib steak. It is usually cooked with a marinade and some searing to impart a charred flavor. Carne asada can be served as a main dish or as an ingredient in other dishes."),
    
    Tacos(name: "Birria",
        type: .beef,
        shortDescription: "Jalisco Spiced Beef",
        longDescription: "Birria is a Mexican dish from the state of Jalisco. The dish is a meat stew traditionally made from goat meat, but occasionally made from beef or mutton. The dish is often served at celebratory occasions, such as weddings and baptisms, and holidays, such as Christmas and Easter."),
    
    Tacos(name: "Al Pastor",
        type: .pork,
        shortDescription: "Marinated Pork on a fire roasted spit",
        longDescription: "Al pastor, also known as tacos al pastor, is a taco made with spit-grilled pork. Based on the lamb shawarma brought by Lebanese immigrants from Mexico, al pastor features a flavor palate that combines traditional Middle Eastern spices with those indigenous to central Mexico."),
    
    Tacos(name: "Carnitas",
        type: .pork,
        shortDescription: "Michoacoan Traditional Pork Tacos",
        longDescription: "Carnitas, literally meaning 'little meats', is a dish of Mexican cuisine that originated in the state of Michoacán. Carnitas are made by braising or simmering pork in oil or preferably lard until tender."),
    
    Tacos(name: "Fish Tacos",
        type: .fish,
        shortDescription: "Baja California Style Fish Tacos",
        longDescription: "Tacos de pescado ('fish tacos') originated in Baja California in Mexico, where they consist of grilled or fried fish, lettuce or cabbage, pico de gallo, and a sour cream or citrus/mayonnaise sauce, all placed on top of a corn or flour tortilla."),
    
    Tacos(name: "Guisado",
        type: .beef,
        shortDescription: "Stewed Beef",
        longDescription: "Guisado is a hot, mildly fatty food. Unlike stew, it allows the vapors to circulate during culinary process. In making guisado, a wide variety of ingredients may be used relative to region, season, availability, and taste."),
    
    Tacos(name: "Nopales",
        type: .veggie,
        shortDescription: "Cactus tacos",
        longDescription: "Nopales are most commonly used in Mexican cuisine in dishes such as huevos con nopales 'eggs with nopal', carne con nopales 'meat with nopal', tacos de nopales, in salads with tomato, onion, and queso panela, or simply on their own as a side vegetable."),
    
    Tacos(name: "Bean",
        type: .veggie,
        shortDescription: "Pinto Bean Tacos",
        longDescription: "Bean Tacos are traditionally made with black or the pinto variety. Beans can be cooked and served by themselves or mixed with meat such as chorizo or beef. They are typically topped with avocado and a variety of salsas."),
    
    Tacos(name: "Papas",
        type: .veggie,
        shortDescription: "Potato Tacos with Cheese",
        longDescription: "Potato tacos consist of a deep fried tortilla shell stuffed with a mashed potato filling and they're topped with shredded cabbage, sliced tomato, diced onion, heaps of cotija and a garlicky tomato sauce."),
    
    Tacos(name: "Lengua",
        type: .beef,
        shortDescription: "Cow tongue Tacos",
        longDescription: "Beef tongue is a cut of beef used made of the tongue of a cow. It can be boiled, pickled, roasted or braised in sauce. It is found in many national cuisines, used for taco fillings in Mexico, and for open-faced sandwiches in the United States."),
    
    Tacos(name: "Shrimp",
        type: .fish,
        shortDescription: "Shrimp Tacos",
        longDescription: "Tacos de camarones ('shrimp tacos') also originated in Baja California in Mexico. Grilled or fried shrimp are used, usually with the same accompaniments as fish tacos: lettuce or cabbage, pico de gallo, avocado and a sour cream or citrus/mayonnaise sauce, all placed on top of a corn or flour tortilla."),
    
    Tacos(name: "Mula Asada",
        type: .beef,
        shortDescription: "Carne asada with Mexican Jack cheese and avocado salsa",
        longDescription: "Mulitas are a double-deck quesadilla with two tortillas and meat on the inside. They're loaded with gooey melted cheese and a flavorful carne asada, with crispy tacos on both sides."),
    
]

// Tacos class with init method, and declaration variables
class Tacos {
    
    enum `Type`: String {
        case beef = "beef"
        case pork = "pork"
        case fish = "fish"
        case veggie = "veggie"
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

