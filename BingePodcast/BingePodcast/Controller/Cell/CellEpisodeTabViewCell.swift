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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = .clear
    }
    
    func setupCell(title: String, subtitle: String, imageEpisode: String, time: String, favorite: Bool) {
            
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
        
        self.favorisImageView.image = favorite ? Assets.Picto.Favorite.favoriteSelectedBlue.image : Assets.Picto.Favorite.favoriteUnselectedBlue.image
        
        self.episodeImageView.image = Assets.placeholderImage.image
        self.episodeImageView.layer.cornerRadius = 10
        downloadImage(imageEpisode) { image, urlString in
            if let imageObject = image {
                // performing UI operation on main thread
                DispatchQueue.main.async {
                self.episodeImageView.image = imageObject
                }
            }
        }

    }
            
    func downloadImage(_ urlString: String, completion: ((_ _image: UIImage?, _ urlString: String?) -> ())?) {
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
            completion?(image, urlString)
            return
        }
        guard let url = URL(string: urlString) else {
            completion?(nil, urlString)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response,error) in
            if let error = error {
                print("error in downloading image: \(error)")
                completion?(nil, urlString)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                    completion?(nil, urlString)
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    completion?(image, urlString)
                    return
                }
                completion?(nil, urlString)
            }.resume()
    }
}
