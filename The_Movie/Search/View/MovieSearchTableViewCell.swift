//
//  MovieSearchTableViewCell.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 10/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit

class MovieSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    
    func image(url: URL?) {
        if let url = url {
            posterImageView.sd_setImage(with: url)
        } else {

        }
    }
}
