//
//  CellPodcastCollectionViewCell.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 28/06/2023.
//

import UIKit

class CellPodcastCollectionViewCell: UICollectionViewCell {

    
    let imageViewPodcast = UIImageView()
    let titlePodcast = UILabel()
    let authorPodcast = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpUI(title: String) {
        
        self.addSubview(titlePodcast)
        titlePodcast.text = title
        titlePodcast.translatesAutoresizingMaskIntoConstraints = false
        
        [
            titlePodcast.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titlePodcast.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20),
            titlePodcast.widthAnchor.constraint(equalToConstant: 80)
            // imageViewPodcast.heightAnchor
        ].forEach{$0.isActive = true}
        
    }

}
