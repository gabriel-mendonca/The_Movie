//
//  FavoriteViewController.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 11/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit
//import Firebase

class FavoriteViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{

    var favoriteViewModel = FavoriteViewModel()

    @IBOutlet weak var favoriteMovieCollection: UICollectionView!
    @IBOutlet weak var favoriteSerieCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteViewModel.dataMovie {
            self.setupMovieCollection()
       }
        favoriteViewModel.dataSerie {
            self.setupSerieCollection()
        }

    }

    func setupMovieCollection() {

        favoriteMovieCollection.delegate = self
        favoriteMovieCollection.dataSource = self
        favoriteMovieCollection.register(UINib (nibName: "FavoriteMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        DispatchQueue.main.async {
            self.favoriteMovieCollection.reloadData()
        }

    }
    
    func setupSerieCollection() {
        favoriteSerieCollection.delegate = self
        favoriteSerieCollection.dataSource = self
        favoriteSerieCollection.register(UINib (nibName: "FavoriteSerieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellSerie")
        
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case favoriteMovieCollection:
            let count = favoriteViewModel.movie.count
            return count
        case favoriteSerieCollection:
            let count = favoriteViewModel.serie.count
            return count
        default:
            return 0
        }
      }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case favoriteMovieCollection:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? FavoriteMovieCollectionViewCell {
        cell.setupImage(posterPath: favoriteViewModel.movie[indexPath.row].posterPath ?? "")
        }
        return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSerie", for: indexPath)
            if let cell = cell as? FavoriteSerieCollectionViewCell{
            cell.setupImage(posterPath: favoriteViewModel.serie[indexPath.row].posterPath ?? "")
            }
            return cell
        }
      }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == favoriteMovieCollection {
        let movieDescriptionViewModel = MovieDescriptionViewModel(id: favoriteViewModel.movie[indexPath.row].id ?? 0)
        let movieDescriptionViewController = MovieDescriptionViewController(movieDescriptionViewModel: movieDescriptionViewModel)

        present(movieDescriptionViewController, animated: true, completion: nil)
        } else {
            let serieDescriptionViewController = SerieDescriptionViewController(nibName: "SerieDescriptionViewController", bundle: nil)
            serieDescriptionViewController.serieDescriptionViewModel.id = favoriteViewModel.serie[indexPath.row].id
            present(serieDescriptionViewController, animated: true, completion: nil)
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let width = 205
          let height = 273
          return CGSize(width: width, height: height)
      }


}
