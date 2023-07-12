
import UIKit

class HomeViewController: UIViewController {
  
    // MARK: - Variables déclaration
    
    let authorArray = ["Sophie-Marie Larrouy", "Anne-Cécile Genre", "Victoire Tuaillon", "Victoire Tuaillon", "", "Thomas Rozec" ]
    let titleArray = ["À bientôt de te revoir", "Du Sport", "Le Coeur Sur La Table", "Les couilles sur la table", "Panier Piano", "Programme B"]
    let cellPodcast = "cellPodcast"

    let scrollViewGeeral: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let imageView: UIImageView = {
        var imageView = UIImageView()
        let image = Assets.logo.image
        imageView = UIImageView(image: image)
        return imageView
    }()

    let titleSwitchPlayer: UILabel = {
        let label = UILabel()
        label.text = "À écouter"
        label.font = UIFont(name: .fonts.proximaNova_Alt_Thin.fontName(), size: 22)
        label.textColor = Colors.darkBlue.color
        return label
    }()

    let switchPlayerFirst = SwitchPlayer(
        title: "EPISODE 78",
        subtitle: "Cuisines indiennes, clichés en sauce, et ça pique",
        imageString: Assets.aBientotDeTeRevoir.name
    )
    
    let switchPlayerSecond = SwitchPlayer(
        title: "EPISODE 90",
        subtitle: "Cuisines indiennes",
        imageString: Assets.aBientotDeTeRevoir.name
    )

    let titlePodcast: UILabel = {
        let label = UILabel()
        label.text = "Nos Podcasts"
        label.font = UIFont(name: .fonts.proximaNova_Alt_Thin.fontName(), size: 22)
        label.textColor = Colors.darkBlue.color
        return label
    }()
    
    let myCollectionViewPodcast: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35)
        layout.itemSize = CGSize(width: 148, height: 200)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        let myCollectionViewPodcast = UICollectionView(frame: CGRect(x: 0, y: 30, width: UIScreen.main.bounds.width, height: 200), collectionViewLayout: layout)
        myCollectionViewPodcast.backgroundColor = .clear
        myCollectionViewPodcast.isScrollEnabled = true
        myCollectionViewPodcast.translatesAutoresizingMaskIntoConstraints = false
        myCollectionViewPodcast.showsVerticalScrollIndicator = false
        myCollectionViewPodcast.showsHorizontalScrollIndicator = false

        return myCollectionViewPodcast
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initCollectionView()
        setGradientBackground()

        titleSwitchPlayer.translatesAutoresizingMaskIntoConstraints = false
        titlePodcast.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        switchPlayerFirst.translatesAutoresizingMaskIntoConstraints = false
        switchPlayerSecond.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Constraint ImageView
        view.addSubview(imageView)
        [
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 260)
        ].forEach{$0.isActive = true}

        // MARK: - Constraint title Switch Player
        view.addSubview(titleSwitchPlayer)
        [
            titleSwitchPlayer.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            titleSwitchPlayer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants_HomeViewController.horizontalMarginLeftAndRightMolecule),
            titleSwitchPlayer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants_HomeViewController.horizontalMarginLeftAndRightMolecule),
            titleSwitchPlayer.heightAnchor.constraint(equalToConstant: 23)
        ].forEach{$0.isActive = true}

        // MARK: - Constraint Switch Player First
        view.addSubview(switchPlayerFirst)
        [
            switchPlayerFirst.widthAnchor.constraint(equalToConstant: view.frame.width - 70),
            switchPlayerFirst.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants_HomeViewController.horizontalMarginLeftAndRightMolecule),
            switchPlayerFirst.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants_HomeViewController.horizontalMarginLeftAndRightMolecule),
            switchPlayerFirst.heightAnchor.constraint(equalToConstant: Constants_HomeViewController.heightSwipePlayer),
            switchPlayerFirst.topAnchor.constraint(equalTo: titleSwitchPlayer.bottomAnchor, constant: 10)
        ].forEach{$0.isActive = true}

        // MARK: - Constraint Switch Player Second
        view.addSubview(switchPlayerSecond)
        [
            switchPlayerSecond.widthAnchor.constraint(equalToConstant: view.frame.width - Constants_HomeViewController.horizontalMarginLeftAndRightMolecule * 2),
            switchPlayerSecond.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants_HomeViewController.horizontalMarginLeftAndRightMolecule),
            switchPlayerSecond.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants_HomeViewController.horizontalMarginLeftAndRightMolecule),
            switchPlayerSecond.heightAnchor.constraint(equalToConstant: Constants_HomeViewController.heightSwipePlayer),
            switchPlayerSecond.topAnchor.constraint(equalTo: switchPlayerFirst.bottomAnchor, constant: 20)
        ].forEach{$0.isActive = true}

        // MARK: - Constraint title Podcast
        view.addSubview(titlePodcast)
        [
            titlePodcast.topAnchor.constraint(equalTo: switchPlayerSecond.bottomAnchor, constant: 15),
            titlePodcast.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants_HomeViewController.horizontalMarginLeftAndRightMolecule),
            titlePodcast.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants_HomeViewController.horizontalMarginLeftAndRightMolecule),
            titlePodcast.heightAnchor.constraint(equalToConstant: 23)
        ].forEach{$0.isActive = true}
        
        
        view.addSubview(myCollectionViewPodcast)
         [
            myCollectionViewPodcast.topAnchor.constraint(equalTo: titlePodcast.bottomAnchor, constant: 10),
            myCollectionViewPodcast.leftAnchor.constraint(equalTo: view.leftAnchor),
            myCollectionViewPodcast.rightAnchor.constraint(equalTo: view.rightAnchor),
            myCollectionViewPodcast.heightAnchor.constraint(equalToConstant: 200),

        ].forEach{$0.isActive = true}
         
         
    }
    
    private func initCollectionView() {
        myCollectionViewPodcast.register(PodcastHomePageCollectionViewCell.self, forCellWithReuseIdentifier: cellPodcast)
        myCollectionViewPodcast.dataSource = self
        myCollectionViewPodcast.delegate = self
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

    private func toggleSelectedSwitchPlayer() {
        
    }

}


extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPodcast, for: indexPath) as? PodcastHomePageCollectionViewCell
        guard let myCell = myCell else {return UICollectionViewCell()}
        myCell.setup(imagePodcastName:Assets.aBientotDeTeRevoir.name, titlePodcast: titleArray[indexPath.row], authorPodcast: authorArray[indexPath.row])
        return myCell
    }
    
    
}
