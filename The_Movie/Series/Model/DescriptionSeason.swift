//
//  DescriptionSeason.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 15/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

struct DescriptionSeason:Decodable, ConvertPosterLink {
    let posterPath: String?
    let name: String?
    
    init(posterPath: String?, name: String?) {
        self.posterPath = posterPath
        self.name = name
    }
    
    enum MovieKey: String, CodingKey {
        case posterPath = "poster_path"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let posterPath = try container.decode(String.self, forKey: .posterPath)
        let name = try container.decode(String.self, forKey: .name)
        self.init(posterPath: posterPath, name: name)
    }
}
