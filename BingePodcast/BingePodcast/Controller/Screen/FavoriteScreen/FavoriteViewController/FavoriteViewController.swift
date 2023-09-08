// https://github.com/cjlarsen/Tutorials/tree/master

import UIKit

class FavoriteViewController: UIViewController {

    var pageController: UIPageViewController?
    var currentIndex: Int = 0
    var leftContainer: NSLayoutConstraint?
    var podcastSaved = [PodcastSaved]()
    var seeLater = [PodcastSaved]()

    let favoriteTitle : UILabel = {
        let label = UILabel()
        label.text = L10n.favorite
        label.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 24)
        label.textColor = Colors.darkBlue.color
        return label
    }()
    
    let seeLaterTitle : UILabel = {
        let label = UILabel()
        label.text = L10n.seeLater
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 24)
        label.textColor = Colors.darkBlue.color
        return label
    }()

    private let line : UIView = {
        let line = UIView()
        line.backgroundColor = Colors.yellow.color
        line.layer.cornerRadius = 2
        return line
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        podcastSaved.append(PodcastSaved(titlePocast: "Du Sport", episodeSaved: [
            EpisodeSaved_test(titleEpisode: "Episode 1",
                              subtitleEpisode: "Les jeux olympiques sont ils utilent",
                              totalTimeEpisode: "12",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),
            
            EpisodeSaved_test(titleEpisode: "Episode 2",
                              subtitleEpisode: "À quoi ca sert de courir ?",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),
            
            EpisodeSaved_test(titleEpisode: "Episode 3",
                              subtitleEpisode: "Peut-on toujours repousser les limites ?",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),
            
            EpisodeSaved_test(titleEpisode: "Episode 4",
                              subtitleEpisode: "Pourquoi les ballons no…",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),
        ]))

        podcastSaved.append(PodcastSaved(titlePocast: "Les couilles sur la table", episodeSaved: [
            EpisodeSaved_test(titleEpisode: "Episode 1",
                              subtitleEpisode: "Les jeux olympiques sont ils utilent",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),

            EpisodeSaved_test(titleEpisode: "Episode 2",
                              subtitleEpisode: "À quoi ca sert de courir ?",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name),

            EpisodeSaved_test(titleEpisode: "Episode 3",
                              subtitleEpisode: "Peut-on toujours repousser les limites ?",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name)
        ]))

        seeLater.append(PodcastSaved(titlePocast: "Du Sport", episodeSaved: [
            EpisodeSaved_test(titleEpisode: "Episode 1",
                              subtitleEpisode: "Les jeux olympiques sont ils utilent",
                              totalTimeEpisode: "12:45",
                              favorite: true,
                              imageEpisode: Assets.aBientotDeTeRevoir.name)]))

        setupTitlePageViewController()
        setupPageController()
        setGradientBackground()
        
    }

    private func setupTitlePageViewController() {

        view.addSubview(favoriteTitle)
        view.addSubview(seeLaterTitle)
        view.addSubview(line)

        favoriteTitle.translatesAutoresizingMaskIntoConstraints = false
        seeLaterTitle.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false

        leftContainer = line.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40)
        
        favoriteTitle.isUserInteractionEnabled = true
        seeLaterTitle.isUserInteractionEnabled = true

        [
            leftContainer!,
            favoriteTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            favoriteTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            seeLaterTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            seeLaterTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            line.topAnchor.constraint(equalTo: favoriteTitle.bottomAnchor, constant: 5),
            line.widthAnchor.constraint(equalToConstant: favoriteTitle.intrinsicContentSize.width),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.centerXAnchor.constraint(equalTo: favoriteTitle.centerXAnchor)

        ].forEach{$0.isActive = true}
        
        let tapFavorite = UITapGestureRecognizer(target: self, action: #selector(self.previousPageController))
        favoriteTitle.addGestureRecognizer(tapFavorite)
        
        let tapSeeLater = UITapGestureRecognizer(target: self, action: #selector(self.nextPageController))
        seeLaterTitle.addGestureRecognizer(tapSeeLater)
        
    }

    private func setGradientBackground() {
        let colorTop = Colors.ligthBlue.color.cgColor
        let colorBottom = Colors.white.color.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
 
}
