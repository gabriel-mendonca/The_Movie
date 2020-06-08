//
//  MovieViewModel.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 05/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
class MovieViewModel {
    
    var genreMovie = [Genre]()
    var service: TheMdbAPI = TheMDBAPIImpl()
    
    func numberOfMovies() -> Int {
        return genreMovie.count
    }
    
    func getMovie(at row: Int) -> (String, Int) {
        return (genreMovie[row].name, genreMovie[row].id)
    }
    
    func setUpViewController(completion : @escaping () -> Void) {
        service.fetchNameGenres { result in
            switch result {
            case.sucess(let listGenre):
                self.genreMovie = listGenre
                completion()
            case .failure:
                self.handleError()
            }
        }
        
    }
    
    private func handleError(){
        
    }
    
}
