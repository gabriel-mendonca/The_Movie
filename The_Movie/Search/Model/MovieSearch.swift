//
//  MovieSearch.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 10/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation


struct SearchMovieResult: Decodable {
    var results: [MovieSearch]
}

struct MovieSearch: Decodable,ConvertPosterLink {
    
    let title: String?
    let posterPath: String?
    let id: Int

    init(title: String?, posterPath: String?, id: Int) {
        self.title = title
        self.posterPath = posterPath
        self.id = id
    }
    
   private enum MovieKey: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case id
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let title = try container.decode(String.self, forKey: .title)
        let posterPath = try container.decode(String.self, forKey: .posterPath)
        let id = try container.decode(Int.self, forKey: .id)
        self.init(title: title, posterPath: posterPath, id: id)
    }
    
}

