//
//  MovieSearchViewModel.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 10/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchViewModel {
    var searchMovie = [MovieSearch]()
    let service = NetworkServiceSearch()
 
    
    func numberOfSearch() -> Int {
        return searchMovie.count
    }
    
    func getSearch(at row: Int) -> URL? {
        return searchMovie[row].posterURL
        
    }
    
    
    func setupSearchTableView(title: String,completion: @escaping () -> Void) {
        service.fetchMovieSearch(title: title) { (result) in
            switch result {
            case .sucess(let movie):
                self.searchMovie = movie
                completion()
            case .failure:
                self.handleError()
            }
            completion()
        }
    }
    
    private func handleError() {
        
    }
    
}
