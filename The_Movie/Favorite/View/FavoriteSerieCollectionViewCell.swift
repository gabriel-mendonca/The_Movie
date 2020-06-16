//
//  FavoriteSerieCollectionViewCell.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 16/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit

class FavoriteSerieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var poster: UIImageView!
    
     func setupImage( posterPath: String) {
        guard let url = URL(string: posterPath ) else { return }
        poster.sd_setImage(with: url)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
