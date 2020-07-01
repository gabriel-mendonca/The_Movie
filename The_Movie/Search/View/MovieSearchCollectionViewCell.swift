//
//  TesteCollectionViewCell.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 13/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit

class MovieSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var progressLoad: UIActivityIndicatorView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    func image(url: URL?) {
        if let url = url {
            posterImageView.sd_setImage(with: url) { (image, error, _, url) in
                self.progressLoad.stopAnimating()
            }
        } else {
            
        }
    }
}

protocol MovieSearchCollectionViewDelegate: AnyObject {
    func cellTapped(movie: MovieSearch)
}

