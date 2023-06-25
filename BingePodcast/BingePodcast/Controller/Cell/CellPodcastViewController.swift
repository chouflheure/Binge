//
//  EpisodeCell.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 25/06/2023.
//

import UIKit

class CellPodcastViewController: UITableViewCell {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var playButtonImageView: UIImageView!
    
    @IBOutlet weak var titleEpisode: UILabel!
    
    @IBOutlet weak var subtitleEpisode: UILabel!
    
    @IBOutlet weak var favorisImageView: UIImageView!
    
    
    @IBOutlet weak var totalTimeEpisode: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(title: String,
                       subtitle: String,
                       imageEpisode: String,
                       time: String,
                       favorite: Bool) {
            
            self.titleEpisode.text = title
            self.subtitleEpisode.text = subtitle
            self.totalTimeEpisode.text = time
            
        self.favorisImageView.image = favorite ? Assets.Picto.favoriteSelected.image : Assets.Picto.favoriteNotSelected.image
        }
    
}
