//
//  NetworkService.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 05/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

enum resultGenreMovie {
    case sucess(moviesList: [Movie])
    case failure(error: Error)
}

enum resultNameGenres {
    case sucess(listGenre: [Genre])
    case failure(error: Error)
}

enum resultMovieDescription {
    case sucess(movie: MovieDescription?)
    case failure(error: Error)
}
enum Error {
    case parseError(error: String)
}

protocol TheMdbAPI {
    func fetchGenreMovies(id: Int, completion: @escaping( _ result: resultGenreMovie) -> Void)
    func fetchNameGenres(completion: @escaping( _ result: resultNameGenres ) -> Void)
    func fetchMovieDescription(id: Int,completion: @escaping( _ result: resultMovieDescription) -> Void)
}

struct TheMDBAPIImpl: TheMdbAPI {
    func fetchGenreMovies(id: Int, completion: @escaping( _ result: resultGenreMovie) -> Void) {
        var movies = [Movie]()
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=68206fe24af296b2560c51089250d615&language=pt-BR&page=\(id)")
            else {
                return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        
                        guard let data = data else {
                            return
                        }
                        
                        let list =  try JSONDecoder().decode(ListMovie.self, from: data)
                        movies = list.results
                        completion(resultGenreMovie.sucess(moviesList: movies))
                    } catch  {
                        if let data = data {
                            let str = String(bytes: data, encoding: .utf8)
                            print("Parse Error3", str as Any, error)
                        } else {
                            print("Parse Error3", error)
                        }
                        completion(resultGenreMovie.failure(error: Error.parseError(error: "Erro no Parse")))
                    }
                }
            }
        }.resume()
        
        
    }
    
    func fetchNameGenres(completion: @escaping( _ result: resultNameGenres ) -> Void) {
        var listGenres = [Genre]()
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=68206fe24af296b2560c51089250d615&language=pt-BR") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        
                        guard let data = data else {
                            return
                        }
                        
                        let list =  try JSONDecoder().decode(GenreList.self, from: data)
                        listGenres = list.genres
                        completion(resultNameGenres.sucess(listGenre: listGenres))
                    } catch  {
                        if let data = data {
                            let str = String(data: data, encoding: .utf8)
                            print("Parse Error3", str as Any, error)
                        } else {
                            print("Parse Error3", error)
                        }
                        completion(resultNameGenres.failure(error: Error.parseError(error: "Erro no Parse")))
                    }
                }
            }
        }.resume()
        
        
    }
    func fetchMovieDescription(id: Int, completion: @escaping( _ result: resultMovieDescription) -> Void) {
          var movie: MovieDescription?
          guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=68206fe24af296b2560c51089250d615&language=pt-BR") else {
              return
          }
          URLSession.shared.dataTask(with: url) { data, _, error in
              DispatchQueue.main.async {
                  if error == nil {
                      do {
                          guard let data = data else {
                              return
                          }
                          
                          let descriptionMovie = try JSONDecoder().decode(MovieDescription.self, from: data)
                          movie = descriptionMovie
                        completion(resultMovieDescription.sucess(movie: movie))
                      } catch {
                        if let data = data {
                            let str = String(data: data, encoding: .utf8)
                            print("Parse Error3", str as Any, error)
                        } else {
                            print("Parse Error3", error)
                        }
                      completion(resultMovieDescription.failure(error: Error.parseError(error: "Erro no parse")))
                      }
                  }
              }
          }.resume()
      }
}
