//
//  Genre.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 05/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation


struct GenreList: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let name: String
    let id: Int
}
