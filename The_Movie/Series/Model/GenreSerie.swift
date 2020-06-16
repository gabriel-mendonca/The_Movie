//
//  GenreSerie.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 14/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

struct SerieGenreList: Decodable {
    let genres: [SerieGenre]
}

struct SerieGenre: Decodable {
    let name: String
    let id: Int
}
