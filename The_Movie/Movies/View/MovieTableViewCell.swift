//
//  MyTableViewController.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 05/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
  
    var movieTableViewCellViewModel: MovieTableViewCellViewModel = MovieTableViewCellViewModel()
    weak var delegate: MovieCollectionViewCellDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
   func cellconfiguration(name: String) {
     label.text = name
                   }
    
    func setupCollectionView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib (nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewCell")
        movieTableViewCellViewModel.setupTableViewCell {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }



    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTableViewCellViewModel.numberOfMovies()
      }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        if let cell = cell as? MovieCollectionViewCell {
            cell.image(url: movieTableViewCellViewModel.get(at: indexPath.row))
        }

        return cell
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 125
        let widht = 100
        return CGSize(width: widht, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.cellTapped(movie: movieTableViewCellViewModel.listGenreMovie[indexPath.row])
        }
    }
      
      
    
    
}
