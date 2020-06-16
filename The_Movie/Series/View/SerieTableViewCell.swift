//
//  SerieTableViewCell.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 14/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SerieTableViewCell: UITableViewCell,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   
    weak var delegate: SerieCollectionViewCellDelegate?
    var serieTableViewCellViewModel: SerieTableViewCellViewModel = SerieTableViewCellViewModel()
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func cellConfigurate(name: String) {
        label.text = name
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SerieCollectionViewCell", bundle: Bundle(for: SerieCollectionViewCell.self)), forCellWithReuseIdentifier: "cell")
        serieTableViewCellViewModel.setupSerieTableViewCell {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serieTableViewCellViewModel.numberOfSeries()
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! SerieCollectionViewCell
        cell.image(url: serieTableViewCellViewModel.getSeries(at: indexPath.row))
        
        return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 125
        let width = 100
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.cellTapped(serie: serieTableViewCellViewModel.genreSeries[indexPath.row])
        }
    }
       
    
    
    
}
