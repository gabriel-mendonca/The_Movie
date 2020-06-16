//
//  SerieDescriptionViewController.swift
//  The_Movie
//
//  Created by Gabriel Mendonça on 15/06/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class SerieDescriptionViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    var serieDescriptionViewModel = SerieDescriptionViewModel()
    var isFavorite = false
    
    @IBOutlet weak var collectionViewSeasons: UICollectionView!
    @IBOutlet weak var more: UIButton!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var episodeTime: UILabel!
    @IBOutlet weak var numberEpisodes: UILabel!
    @IBOutlet weak var numberSeasons: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var posterPath: UIImageView!
    @IBOutlet weak var backdropPath: UIImageView!
    @IBOutlet private var animation: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationFavorites()
        configButton()
        setupCollectionView()
        animation.play(fromFrame: 0, toFrame: 32)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        serieDescriptionViewModel.data {
            self.isFavorite = self.serieDescriptionViewModel.isFavorite
            self.animationFavorites()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        serieDescriptionViewModel.fetchSerieDescription(sucess: { (serieDescription) in
            self.setup(serieDescription: serieDescription)
        }, failure: {})
        DispatchQueue.main.async {
            self.collectionViewSeasons.reloadData()
        }
    }
    
    func setupCollectionView() {
        collectionViewSeasons.delegate = self
        collectionViewSeasons.dataSource = self
        collectionViewSeasons.register(UINib (nibName: "SerieDescriptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    func setup(serieDescription: SerieDescription?) {
        posterPath.sd_setImage(with: serieDescription?.posterURL)
        backdropPath.sd_setImage(with: serieDescription?.backdropURL)
        name.text = serieDescription?.name
        guard let sinopse = serieDescription?.overview else {return}
        episodeTime.text = "Sinopse: \n \(sinopse)"
        overview.text = "Temporadas:"
        guard let seasons = serieDescription?.numberSeasons else {return}
        numberSeasons.text = "Temporadas: \(seasons)"
        guard let episodes = serieDescription?.numberEpisodes else {return}
        numberEpisodes.text = "Episódios: \(episodes)"
        
        starEvaluation(nota: serieDescription?.voteAverage)
        
    }
    
    func configButton() {
        more.clipsToBounds = true
        more.layer.cornerRadius = more.frame.height/2
    }
    
    @IBAction func more(_ sender: Any) {
        serieDescriptionViewModel.setupHomePage()
        guard let urlSerieDescriptionLink = serieDescriptionViewModel.urlSerieDescriptionLink else {
            return
        }
        UIApplication.shared.open(urlSerieDescriptionLink)
        
    }
    
        @IBAction func clickAnimation(_ sender: Any) {
            animationFavoritesClick(isFavorite: isFavorite)
        }
    
        func animationFavoritesClick(isFavorite: Bool) {
            if isFavorite {
                animation.play(fromFrame: 80, toFrame: 110, loopMode: .playOnce) { _ in
                    self.animation.play(fromFrame: 5, toFrame: 32)
                    self.serieDescriptionViewModel.delete()
                }
            } else {
                animation.play(fromFrame: 33, toFrame: 65)
                serieDescriptionViewModel.post()
            }
            self.isFavorite.toggle()
        }
        
        func animationFavorites() {
            self.animation.play(fromFrame: 33, toFrame: 65)
        }
    
    func starEvaluation(nota: Float?) {
          guard let nota = nota else { return }
          let media = Int(nota / 2)
          if media <= 1 {
              voteAverage.text = "★☆☆☆☆"
          } else if media <= 2 {
              voteAverage.text = "★★☆☆☆"
          } else if media <= 3 {
              voteAverage.text = "★★★☆☆"
          } else if media <= 4 {
              voteAverage.text = "★★★★☆"
          } else if media <= 5 {
              voteAverage.text = "★★★★★"
          } else {
              voteAverage.text = "☆☆☆☆☆"
          }
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = serieDescriptionViewModel.serieDescription?.seasons else { return 0 }
        return count.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SerieDescriptionCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupSeason(serieDescription: serieDescriptionViewModel.serieDescription?.seasons?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 160
        let widht = 121
        return CGSize(width: widht, height: height)
    }
    
    
    
    
    
}
