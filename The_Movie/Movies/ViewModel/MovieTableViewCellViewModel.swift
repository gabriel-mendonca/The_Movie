//
//  MovieTableViewCellViewModel.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 06/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

class MovieTableViewCellViewModel {
    
    var service: TheMdbAPI = TheMDBAPIImpl()
    var listGenreMovie = [Movie]()
    var id = 0
    
    func numberOfMovies() -> Int {
        return listGenreMovie.count
    }
    func get(at row: Int) -> URL {
        return listGenreMovie[row].posterURL!
    }
    
    func setupTableViewCell(completion: @escaping () -> Void) {
        service.fetchGenreMovies(id: id) { (result) in
            switch result {
            case .sucess(let movies):
                self.listGenreMovie = movies
                completion()
            case .failure:
                self.handleError()
            }
        }
        
        
    }
    
    func handleError() {
        
    }
    
}
