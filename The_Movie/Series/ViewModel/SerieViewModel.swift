//
//  SerieViewModel.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 14/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

class SerieViewModel {
    var genreSerie = [SerieGenre]()
    let service = NetworkServiceSeries()
    
    func numberOfSeries() -> Int {
        return genreSerie.count
    }
    
    func getSeries(at row: Int) -> (String,Int) {
        return (genreSerie[row].name, genreSerie[row].id)
    }
    
    func setupSerieTableView(completion: @escaping () -> Void) {
        service.fetchNameGenreSeries { (result) in
            switch result {
            case .sucess(let serieList):
                self.genreSerie = serieList
                completion()
            case .failure:
                self.handleError()
            }
            completion()
        }
    }
    
    func handleError() {}
    
    
}
