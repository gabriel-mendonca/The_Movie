//
//  SerieDescriptionViewModel.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 15/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
//import Firebase

class SerieDescriptionViewModel {
    
    var id: Int?
    let service = NetworkServiceSeries()
    var serieDescription: SerieDescription?
    var urlSerieDescriptionLink: URL?
    var isFavorite: Bool = false
    
    
    func fetchSerieDescription(sucess: @escaping( _ serieDescription: SerieDescription?) -> Void, failure: @escaping() -> Void) {
        guard let id = id else {return}
        service.fetchSerieDescription(id: id) { (result) in
            switch result {
            case .sucess(let serie):
                self.serieDescription = serie
                sucess(self.serieDescription)
            case .failure:
                self.handleError()
            }
        }
    }
    
//        func post() {
//            guard let poster = serieDescription?.posterPath else { return }
//            let posterPath = "https://image.tmdb.org/t/p/original/\(poster)"
//            let id = serieDescription?.id
//            let title = serieDescription?.name
//            let isFavorite = true
//    
//            let post: [String: AnyObject] = [ "posterPath": posterPath as AnyObject, "id": id as AnyObject, "isFavorite": isFavorite as AnyObject]
//    
//                let dbReference = Database.database().reference()
//            dbReference.child("Series").child(title ?? "").setValue(post)
//    
//            }
//        
//        func delete() {
//            let title = serieDescription?.name
//            let dbReference = Database.database().reference()
//            dbReference.child("Series").child(title ?? "").removeValue()
//        }
//    
//        func data(completion : @escaping () -> Void) {
//            let title = serieDescription?.name
//                let dbReference = Database.database().reference()
//                dbReference.child("Series/\(title ?? "")/isFavorite").observe(.value) {(snaphot: DataSnapshot) in
//                    if let values = snaphot.value as? Bool {
//                        self.isFavorite = values
//                        completion()
//                    }
//                }
//        }
    
    func handleError() {}
    
    
    func setupHomePage() {
        guard let serie = serieDescription?.homepage else {return}
        guard let url = URL(string: serie) else {return}
        urlSerieDescriptionLink = url
    }
    
}
