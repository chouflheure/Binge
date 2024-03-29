import UIKit

class PodcastHomePageCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var imageCallURL = ImageCallURL()

    // MARK: - Variables Declaration
    var imageName = String()
    
    let imagePodcast: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = Colors.darkBlue.color
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 17)
        return label
    }()
    
    let lineSeperator: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: 148, height: 1)
        view.backgroundColor = Colors.darkBlue.color
        return view
    }()

    let author: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = Colors.darkBlue.color
        label.font = UIFont(name: .fonts.proximaNova_Thin.fontName(), size: 14)
        return label
    }()

    func setup(imagePodcastName: String, titlePodcast: String, authorPodcast: String) {
        
        self.imageName = imagePodcastName
        self.title.text = titlePodcast
        self.author.text = authorPodcast

        imagePodcast.image = Assets.placeholderImage.image

        imageCallURL.downloadImage(imageName) {image, urlString in
            if let imageObject = image {
                // performing UI operation on main thread
                DispatchQueue.main.async {
                    guard let urlString = urlString else {return}
                    
                    if self.imageName == urlString {
                        self.imagePodcast.image = imageObject
                    } else {
                    }
                }
        }}


        // color
        backgroundColor = .clear

        // Add element on view
        addSubview(imagePodcast)
        addSubview(title)
        addSubview(lineSeperator)
        addSubview(author)
        
        // Auto resizing disable
        imagePodcast.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        lineSeperator.translatesAutoresizingMaskIntoConstraints = false
        author.translatesAutoresizingMaskIntoConstraints = false
        
        // image Podcast contraints
        [
            imagePodcast.topAnchor.constraint(equalTo: self.topAnchor),
            imagePodcast.heightAnchor.constraint(equalToConstant: 148),
            imagePodcast.widthAnchor.constraint(equalToConstant: 148)
        ].forEach{$0.isActive = true}
        
        // title Podcast contraints
        [
            title.topAnchor.constraint(equalTo: imagePodcast.bottomAnchor, constant: 10),
            title.rightAnchor.constraint(equalTo: self.rightAnchor),
            title.leftAnchor.constraint(equalTo: self.leftAnchor),
            title.heightAnchor.constraint(equalToConstant: 17)
        ].forEach{$0.isActive = true}
        
        // line Seperator contraints
        [
            lineSeperator.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
            lineSeperator.rightAnchor.constraint(equalTo: self.rightAnchor),
            lineSeperator.leftAnchor.constraint(equalTo: self.leftAnchor),
            lineSeperator.heightAnchor.constraint(equalToConstant: 1)
        ].forEach{$0.isActive = true}
        
        // author Podcast contraints
        [
            author.topAnchor.constraint(equalTo: lineSeperator.bottomAnchor, constant: 2),
            author.rightAnchor.constraint(equalTo: self.rightAnchor),
            author.leftAnchor.constraint(equalTo: self.leftAnchor),
            author.heightAnchor.constraint(equalToConstant: 14)
        ].forEach{$0.isActive = true}
    }

    
}
