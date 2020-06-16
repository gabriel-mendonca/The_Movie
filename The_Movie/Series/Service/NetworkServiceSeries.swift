//
//  NetworkService.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 13/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

enum ResultNameGenreSeries {
    case sucess(serieList: [SerieGenre])
    case failure(error: ErrorSerie)
}

enum ResultGenreSerie {
    case sucess(listGenre: [Serie])
    case failure(error: ErrorSerie)
}

enum ResultSerieDescription {
    case sucess(serie: SerieDescription?)
    case failure(error: ErrorSerie)
}

enum ErrorSerie {
    case parseError(error: String)
}

class NetworkServiceSeries {
    func fetchNameGenreSeries(completion: @escaping( _ result: ResultNameGenreSeries) -> Void) {
        var listGenre = [SerieGenre]()
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/tv/list?api_key=68206fe24af296b2560c51089250d615&language=pt-BR") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error == nil {
                do {
                    
                    guard let data = data else {
                        return
                    }
                    let list = try JSONDecoder().decode(SerieGenreList.self, from: data)
                    listGenre = list.genres
                    completion(ResultNameGenreSeries.sucess(serieList: listGenre))
                } catch  {
                    if let data = data {
                        let str = String(data: data, encoding: .utf8)
                        print("Parse Error3", str as Any, error)
                    } else {
                        print("Parse Error3", error)
                    }
                    completion(ResultNameGenreSeries.failure(error: ErrorSerie.parseError(error: "error no parse")))
                }
            }
        }.resume()
    }
    
    func fetchGenreSeries(id: Int, completion: @escaping( _ result: ResultGenreSerie) -> Void) {
        var serie = [Serie]()
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/tv?api_key=68206fe24af296b2560c51089250d615&language=pt-BR&sort_by=popularity.desc&page=1&with_genres=\(id)&include_null_first_air_dates=false") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error == nil {
                do {
                    
                    guard let data = data else {
                        return
                    }
                    
                    let list =  try JSONDecoder().decode(ListSeries.self, from: data)
                    serie = list.results
                    completion(ResultGenreSerie.sucess(listGenre: serie))
                } catch {
                    if let data = data {
                        let str = String(data: data, encoding: .utf8)
                        print("Parse Error3",str as Any, error)
                    } else {
                        print("Parse Error3", error)
                    }
                    completion(ResultGenreSerie.failure(error: ErrorSerie.parseError(error: "Erro no parse")))
                    
                }
            }
        }.resume()
        
    }
    
    func fetchSerieDescription(id: Int, completion: @escaping(_ result: ResultSerieDescription) -> Void) {
        var serie: SerieDescription?
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(id)?api_key=68206fe24af296b2560c51089250d615&language=pt-BR") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if error == nil {
                    do{
                        guard let data = data else {return}
                        
                        let descriptionSerie = try JSONDecoder().decode(SerieDescription.self, from: data)
                        serie = descriptionSerie
                        completion(ResultSerieDescription.sucess(serie: serie))
                    } catch {
                        if let data = data {
                            let str = String(data: data, encoding: .utf8)
                            print("Parse Error3", str as Any, error)
                        } else {
                            print("Parse Error3", error)
                        }
                        completion(ResultSerieDescription.failure(error: ErrorSerie.parseError(error: "erro no parse")))
                    }
                }
            }
            
        }.resume()
    }
    
}
