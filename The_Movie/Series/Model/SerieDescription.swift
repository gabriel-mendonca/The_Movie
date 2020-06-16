//
//  SerieDescription.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 14/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

struct SerieDescription: Decodable, ConvertPosterLink,ConvertBackdropLink {

    var backdropPath: String?
    let homepage: String?
    let name: String?
    let numberEpisodes: Int?
    let numberSeasons: Int?
    let overview: String?
    let posterPath: String?
    let seasons: [DescriptionSeason]?
    let voteAverage: Float?
    let id: Int?
    
    init(backdropPath: String?, homepage: String?, name: String?,numberEpisodes:Int?,numberSeasons: Int?, overview: String?, posterPath: String?,seasons:[DescriptionSeason]?, voteAverage: Float?, id: Int?) {
        self.backdropPath = backdropPath
        self.homepage = homepage
        self.name = name
        self.numberEpisodes = numberEpisodes
        self.numberSeasons = numberSeasons
        self.overview = overview
        self.posterPath = posterPath
        self.seasons = seasons
        self.voteAverage = voteAverage
        self.id = id
    }
    
    enum MovieKey: String, CodingKey {
        case backdropPath = "backdrop_path"
        case homepage
        case name
        case numberEpisodes = "number_of_episodes"
        case numberSeasons = "number_of_seasons"
        case overview
        case posterPath = "poster_path"
        case seasons
        case voteAverage = "vote_average"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let backdropPath: String? = try container.decode(String.self, forKey: .backdropPath)
        let homepage: String? = try container.decode(String.self, forKey: .homepage)
        let name: String? = try container.decode(String.self, forKey: .name)
        let numberEpisodes: Int? = try container.decode(Int.self, forKey: .numberEpisodes)
        let numberSeasons: Int? = try container.decode(Int.self, forKey: .numberSeasons)
        let overview: String? = try container.decode(String.self, forKey: .overview)
        let posterPath: String? = try container.decode(String.self, forKey: .posterPath)
        let seasons:[DescriptionSeason]? = try container.decode([DescriptionSeason]?.self, forKey: .seasons)
        let voteAverage: Float? = try container.decode(Float.self, forKey: .voteAverage)
        let id: Int? = try container.decode(Int.self, forKey: .id)
        self.init(backdropPath: backdropPath, homepage: homepage, name: name,numberEpisodes: numberEpisodes,numberSeasons: numberSeasons, overview: overview, posterPath: posterPath, seasons: seasons, voteAverage: voteAverage, id: id)
    }
    

}
