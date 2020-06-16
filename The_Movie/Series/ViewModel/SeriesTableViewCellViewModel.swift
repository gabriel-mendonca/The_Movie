//
//  SeriesTableViewCellViewModel.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 14/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

class SerieTableViewCellViewModel {
    
    let service = NetworkServiceSeries()
    var id = 0
    var genreSeries = [Serie]()
    
    func numberOfSeries() -> Int {
        return genreSeries.count
    }
    
    func getSeries(at row: Int) -> URL? {
        return genreSeries[row].posterURL
    }
    
    func setupSerieTableViewCell(completion: @escaping () -> Void) {
        service.fetchGenreSeries(id: id) { (result) in
            switch result {
            case .sucess(let listGenre):
                self.genreSeries = listGenre
                completion()
            case .failure:
                self.handleError()
            }
            completion()
        }
    }
    
    private func handleError() {}
    
}
