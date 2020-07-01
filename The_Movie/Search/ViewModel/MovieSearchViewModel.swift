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
    var service = NetworkServiceSearch()
    
    init(service: NetworkServiceSearch = NetworkServiceSearch()) {
        self.service = service
        searchQuery = ""
    }
    
    var searchQuery: String{
        didSet {
           reloadSearch()
        }
    }
    
    func reloadSearch() {
        if searchQuery.isEmpty {
            setupSearchTableView(query: searchQuery)
        }else {
            
        }
    }
    
    func numberOfSearch() -> Int {
        return searchMovie.count
    }
    
    func getSearch(at row: Int) -> URL? {
        return searchMovie[row].posterURL
        
    }
    
    
    func setupSearchTableView(query: String) {
        service.fetchMovieSearch(query: query) { (result) in
            switch result {
            case .sucess(let movie):
                self.searchMovie = movie
            case .failure:
                self.handleError()
            }
        }
    }
    
    private func handleError() {
        
    }
    
}
