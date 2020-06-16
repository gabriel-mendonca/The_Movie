//
//  SerieCollectionViewCell.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 16/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SerieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    
    func image(url: URL?) {
            if let url = url {
            poster.sd_setImage(with: url)
            } else {
                
            }
        }
}

    protocol SerieCollectionViewCellDelegate: AnyObject {
        func cellTapped(serie: Serie)
    }
