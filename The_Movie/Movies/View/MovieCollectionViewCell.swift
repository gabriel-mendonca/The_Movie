//
//  MovieCollectionViewCell.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 07/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    
    func image(url: URL?) {
        if let url = url {
            poster.sd_setImage(with: url, completed: nil)
        } else {
            
        }
    }
}

protocol MovieCollectionViewCellDelegate: AnyObject {
    func cellTapped(movie: Movie)
}
