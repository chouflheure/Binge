//
//  CellPodcastCollectionViewCell.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 28/06/2023.
//

import UIKit

class CellPodcastCollectionViewCell: UICollectionViewCell {

    
    var imageViewPodcast = UIImageView()
    let titlePodcast = UILabel()
    let authorPodcast = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpUI(title: String, subtitlePodcast: String, imagePodcastString: String) {
        
        imageViewPodcast = UIImageView(image: UIImage(named: subtitlePodcast))
        imageViewPodcast.translatesAutoresizingMaskIntoConstraints = false
        imageViewPodcast.layer.cornerRadius = 24
        self.imageViewPodcast.layer.masksToBounds = true
        
        self.addSubview(imageViewPodcast)
        [
            imageViewPodcast.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageViewPodcast.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageViewPodcast.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            imageViewPodcast.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
        ].forEach{$0.isActive = true}
        
        imageViewPodcast.isHidden = true
        
            /*
        self.addSubview(titlePodcast)
        titlePodcast.text = title
        titlePodcast.translatesAutoresizingMaskIntoConstraints = false
        
        [
            titlePodcast.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titlePodcast.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20),
            titlePodcast.widthAnchor.constraint(equalToConstant: 80)
            // imageViewPodcast.heightAnchor
        ].forEach{$0.isActive = true}
     */
    }

}
