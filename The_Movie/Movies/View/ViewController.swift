//
//  ViewController.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 04/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, MovieCollectionViewCellDelegate{
    
    var movieViewModel: MovieViewModel = MovieViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewTable()
        movieViewModel.setUpViewController {
            self.tableView.reloadData()
        }
        
    }
    
    func setUpViewTable() {

        self.tableView.register(UINib (nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        }
    
    func cellTapped(movie: Movie) {
           
       }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.numberOfMovies()
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? MovieTableViewCell {
            cell.cellconfiguration(name: movieViewModel.getMovie(at: indexPath.row).0)
            cell.movieTableViewCellViewModel.id = movieViewModel.getMovie(at: indexPath.row).1
            cell.setupCollectionView()
            cell.delegate = self
        
        }
        return cell
        
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}

