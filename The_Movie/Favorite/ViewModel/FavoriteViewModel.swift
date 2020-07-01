//
//  FavoriteViewModel.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 11/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
//import Firebase

class FavoriteViewModel {
    var movie = [FavoritosFirebase]()
    var serie = [FavoritosFirebase]()
    
//        func dataMovie(completion: @escaping () -> Void) {
//            let dbReference = Database.database().reference()
//            dbReference.child("Movies").observe(.value) {
//                let itens = $0.value as? [String: Any] ?? [:]
//                let movies: [FavoritosFirebase] = itens.compactMap {
//                    guard let values = $0.value as? [String: Any] else {return nil}
//                    return FavoritosFirebase(
//                        id: values["id"] as? Int,
//                        isFavorite: values["isFavorite"] as? Bool,
//                        posterPath: values["posterPath"] as? String
//                    )
//                }
//                self.movie = movies
//                completion()
//
//            }
//        }
//
//        func dataSerie(completion : @escaping () -> Void) {
//            let dbReference = Database.database().reference()
//            dbReference.child("Series").observe(.value) {
//                let items = $0.value as? [String: Any] ?? [:]
//                let series: [FavoritosFirebase] = items.compactMap {
//                    guard let values = $0.value as? [String: Any] else { return nil }
//                    return FavoritosFirebase(
//                        id: values["id"] as? Int,
//                        isFavorite: values["isFavorite"] as? Bool,
//                        posterPath: values["posterPath"] as? String
//                    )
//                }
//                self.serie = series
//                completion()
//            }
//        }
    
}
