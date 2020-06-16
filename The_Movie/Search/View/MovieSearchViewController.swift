//
//  MovieSearchViewController.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 10/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit
import Foundation

class MovieSearchViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextFieldDelegate,MovieSearchCollectionViewDelegate {
    
    var movieSearchViewModel: MovieSearchViewModel = MovieSearchViewModel()
    weak var delegate: MovieSearchCollectionViewDelegate?
    
    @IBOutlet weak var titleTable: UITextField!
    @IBOutlet weak var collectionViewSearch: UICollectionView!
    @IBOutlet weak var search: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleTable.delegate = self
       
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
    
    @IBAction func searchFor(_ sender: Any) {
        
        movieSearchViewModel.setupSearchTableView(title: titleTable.text ?? "") {
            DispatchQueue.main.async {
                 self.collectionViewSearch.reloadData()
            }
        }
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        movieSearchViewModel.setupSearchTableView(title: titleTable.text ?? "") {
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
        let height = 125
        let widht = 100
        return CGSize(width: widht, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        cellTapped(movie: movieSearchViewModel.searchMovie[indexPath.row])
        
    }
        
        
        
        
        
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return movieSearchViewModel.numberOfSearch()
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieSearchCollectionViewCell
//        cell.image(url: movieSearchViewModel.getSearch(at: indexPath.row))
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 170
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
}

