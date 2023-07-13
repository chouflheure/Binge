//
//  EpisodeCell.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 25/06/2023.
//

import UIKit

class CellEpisodeTabViewCell: UITableViewCell {
    
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
        self.backgroundColor = .clear
        // Configure the view for the selected state
    }
    
    func setupCell(title: String,
                       subtitle: String,
                       imageEpisode: String,
                       time: String,
                       favorite: Bool) {
            
        self.titleEpisode.text = title
        self.titleEpisode.numberOfLines = 1
        self.titleEpisode.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 18)
        self.titleEpisode.textColor = Colors.darkBlue.color
        
        self.subtitleEpisode.text = subtitle
        self.subtitleEpisode.numberOfLines = 1
        self.subtitleEpisode.font = UIFont(name: .fonts.proximaNova_Alt_Light.fontName(), size: 16)
        self.subtitleEpisode.textColor = Colors.darkBlue.color
        
        self.totalTimeEpisode.text = time
        self.totalTimeEpisode.numberOfLines = 1
        self.totalTimeEpisode.font = UIFont(name: .fonts.proximaNova_Alt_Thin.fontName(), size: 15)
        self.totalTimeEpisode.textColor = Colors.darkBlue.color
        
        self.episodeImageView.image = UIImage(named: imageEpisode)
        self.episodeImageView.layer.cornerRadius = 10
        
        self.favorisImageView.image = favorite ? Assets.Picto.Favorite.favoriteSelectedBlue.image : Assets.Picto.Favorite.favoriteUnselectedBlue.image
        }
    
}