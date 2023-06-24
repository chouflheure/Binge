
import UIKit

class CellPodcastViewController: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var imageViewEpisode: UIImageView!
    @IBOutlet weak var imageViewTimer: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var imageViewHeart: UIImageView!
    @IBOutlet weak var buttonPlay: UIButton!

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
        
        self.title.text = title
        self.subtitle.text = subtitle
        self.time.text = time
        
        self.imageViewHeart.image = favorite ? Assets.Picto.favoriteSelectBlue.image : Assets.Picto.favoriteUnselectBlue.image
    }
}
