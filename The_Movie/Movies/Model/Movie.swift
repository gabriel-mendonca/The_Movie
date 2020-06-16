//
//  Movie.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 05/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation


protocol ConvertPosterLink {
    var posterPath: String? { get }
    var posterURL: URL? { get }
}

extension ConvertPosterLink {
    var posterURL: URL? {
        if let posterPath = self.posterPath?.replacingOccurrences(of: "^/", with: "", options: .regularExpression) {
            return URL(string: posterPath, relativeTo: URL(string: "https://image.tmdb.org/t/p/original/"))
            
        }
        return nil
    }
    
}
    
    struct ListMovie: Decodable {
        let results: [Movie]
    }
    
struct Movie: Decodable, ConvertPosterLink {
    let posterPath: String?
    let id: Int
    
    init(posterPath: String?, id: Int) {
        self.posterPath = posterPath
        self.id = id
    }
    
    enum MovieKey: String, CodingKey {
        case posterPath = "poster_path"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let posterPath: String? = try container.decode(String.self, forKey: .posterPath)
        let id: Int = try container.decode(Int.self, forKey: .id)
        self.init(posterPath: posterPath, id: id)
    }
    
}

    
