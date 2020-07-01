//
//  SerieDescriptionCollectionViewCell.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 16/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit

class SerieDescriptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterPath: UIImageView!
    @IBOutlet weak var nameSeason: UILabel!
    
    
    func setupSeason(serieDescription: DescriptionSeason?) {
         posterPath.sd_setImage(with: serieDescription?.posterURL)
         nameSeason.text = serieDescription?.name
     }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
