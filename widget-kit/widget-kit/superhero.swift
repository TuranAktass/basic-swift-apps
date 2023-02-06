//
//  superhero.swift
//  widget-kit
//
//  Created by Turan Aktaş on 6.02.2023.
//

import Foundation


struct Superhero : Codable, Identifiable{
    
    var id : String {image}
    
    let image : String
    let name : String
    let realName: String
}


let batman = Superhero( image: "batman", name: "Batman", realName: "Bruce Wayne")
let ironman = Superhero(image: "ironman", name: "Iron Man", realName: "Tony Stark")
let spiderman = Superhero( image: "spiderman", name: "Spider Man", realName: "Peter Parker")
