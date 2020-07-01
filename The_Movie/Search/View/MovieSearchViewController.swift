//
//  MovieSearchViewController.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 10/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit
import Foundation

class MovieSearchViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextFieldDelegate,UISearchBarDelegate,MovieSearchCollectionViewDelegate {
    
    var movieSearchViewModel: MovieSearchViewModel = MovieSearchViewModel()
    var resultRequest: SearchMovieResult?
    weak var delegate: MovieSearchCollectionViewDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewSearch: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupCollectionView()
        
        
    }
    
    func setupCollectionView() {
        self.collectionViewSearch.delegate = self
        self.collectionViewSearch.dataSource = self
        self.collectionViewSearch.register(UINib (nibName: "MovieSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellid")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieSearchViewModel.searchQuery = searchBar.text ?? ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.searchTextField.textColor = .white
        if searchText.isEmpty {
            movieSearchViewModel.searchQuery = searchText
            resultRequest?.results.removeAll()
        } else {
            movieSearchViewModel.setupSearchTableView(query: searchText)
            collectionViewSearch.reloadData()
        }
    }
    
//    @IBAction func searchFor(_ sender: Any) {
//        movieSearchViewModel.setupSearchTableView(query: titleTable.text ?? "") {
//            DispatchQueue.main.async {
//                 self.collectionViewSearch.reloadData()
//            }
//        }
//    }
    
//    func textFieldShouldReturn(_ textField: UITextField, collectionView: UICollectionView) -> Bool {
//        movieSearchViewModel.setupSearchTableView(query: titleTable.text ?? "") {
//            DispatchQueue.main.async {
//                 self.collectionViewSearch.reloadData()
//            }
//        }
//        return true
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func cellTapped(movie: MovieSearch) {
          let movieDescriptionViewModel = MovieDescriptionViewModel(id: movie.id)
          let movieDescriptionViewController = MovieDescriptionViewController(movieDescriptionViewModel: movieDescriptionViewModel)
          present(movieDescriptionViewController, animated: true, completion: nil)
      }
      
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieSearchViewModel.numberOfSearch()
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! MovieSearchCollectionViewCell
        cell.image(url: movieSearchViewModel.getSearch(at: indexPath.row))
        
        return cell
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 3)-4, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        cellTapped(movie: movieSearchViewModel.searchMovie[indexPath.row])
        
    }
}


