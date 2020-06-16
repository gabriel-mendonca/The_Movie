//
//  Serie.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 13/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

struct ListSeries: Decodable {
    let results: [Serie]
}

struct Serie: Decodable, ConvertPosterLink {
    let posterPath: String?
    let id: Int?
    
    init(posterPath: String?, id: Int?) {
        self.posterPath = posterPath
        self.id = id
    }
    
    enum MovieKey: String, CodingKey {
        case posterPath = "poster_path"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let posterPath = try container.decode(String.self, forKey: .posterPath)
        let id = try container.decode(Int.self, forKey: .id)
        self.init(posterPath: posterPath, id: id)
    }
    
    
}


