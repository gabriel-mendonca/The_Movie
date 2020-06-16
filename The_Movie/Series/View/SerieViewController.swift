//
//  SerieViewController.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 14/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SerieViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SerieCollectionViewCellDelegate {
    
    var serieViewModel: SerieViewModel = SerieViewModel()
    
    @IBOutlet weak var tableViewSerie: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSerieTableView()
        serieViewModel.setupSerieTableView {
            DispatchQueue.main.async {
               self.tableViewSerie.reloadData()
            }
        }
        
    }

//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    func cellTapped(serie: Serie) {
           let serieDescriptionViewController = SerieDescriptionViewController(nibName: "SerieDescriptionViewController", bundle: nil)
        serieDescriptionViewController.serieDescriptionViewModel.id = serie.id
        present(serieDescriptionViewController, animated: true, completion: nil)
       }
       
       
    
    func setupSerieTableView() {
        self.tableViewSerie.delegate = self
        self.tableViewSerie.dataSource = self
        self.tableViewSerie.register(UINib (nibName: "SerieTableViewCell", bundle: Bundle(for: SerieTableViewCell.self)), forCellReuseIdentifier: "cell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serieViewModel.numberOfSeries()
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SerieTableViewCell
        cell.cellConfigurate(name: serieViewModel.getSeries(at: indexPath.row).0)
        cell.serieTableViewCellViewModel.id = serieViewModel.getSeries(at: indexPath.row).1
        cell.setupCollectionView()
        cell.delegate = self
        return cell
        
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
     
    
}
