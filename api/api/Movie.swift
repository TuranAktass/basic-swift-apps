//
//  Movie.swift
//  api
//
//  Created by Risetime on 14.12.2022.
//

import Foundation


class Movie {
    var poster : String?
    var title : String?
    var year : String?
    
    
    init(dict : Dictionary<String, Any>) {
        self.poster = dict["Poster"] as? String
        self.title = dict["Title"] as? String
        self.year = dict["Year"] as? String
    }
}
