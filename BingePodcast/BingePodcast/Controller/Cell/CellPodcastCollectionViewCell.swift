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
        
        // imageViewPodcast = UIImageView(image: UIImage(named: subtitlePodcast))
        
        imageViewPodcast.image = Assets.placeholderImage.image

        downloadImage(imagePodcastString) {
            image, urlString in
                if let imageObject = image {
                    // performing UI operation on main thread
                    DispatchQueue.main.async {
                        self.imageViewPodcast.image = imageObject
                    }
                }
        }
        
        
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

    
    func downloadImage(_ urlString: String, completion: ((_ _image: UIImage?, _ urlString: String?) -> ())?) {
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



