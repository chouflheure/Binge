//
//  FavoriteViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 09/07/2023.
//

import UIKit

class HomeViewController: UIViewController {

    let authorArray = ["Sophie-Marie Larrouy", "Anne-Cécile Genre", "Victoire Tuaillon", "Victoire Tuaillon", "", "Thomas Rozec" ]
    let titleArray = ["À bientôt de te revoir", "Du Sport", "Le Coeur Sur La Table", "Les couilles sur la table", "Panier Piano", "Programme B"]
    let cellPodcast = "cellPodcast"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(imageView)
        scrollViewContainer.addArrangedSubview(spacingImageWithTitle)
        scrollViewContainer.addArrangedSubview(containerMargin())
        scrollViewContainer.addArrangedSubview(spacingTitleWithCollectionView)
        scrollViewContainer.addArrangedSubview(collectionViewPodcast)
        scrollViewContainer.addArrangedSubview(viewOffsetCollectionnView)

        [
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -45),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollViewContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            scrollViewContainer.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            imageView.heightAnchor.constraint(equalToConstant: 260),
            collectionViewPodcast.heightAnchor.constraint(equalToConstant: 200),
            viewOffsetCollectionnView.heightAnchor.constraint(equalToConstant: 70)
        ].forEach{$0.isActive = true}

        initCollectionView()
        setGradientBackground()

    }

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func containerMargin() -> UIStackView {
        
        let spacingTitleWithSwitch = UIView()
        let spacingBetweenSwith = UIView()
        let spacingSwitchWithTitlePodcast = UIView()
        
        let viewVertical = UIStackView()
        viewVertical.axis = .vertical
        viewVertical.distribution = .fill
        viewVertical.translatesAutoresizingMaskIntoConstraints = false
        viewVertical.addArrangedSubview(titleSwitchPlayer)
        viewVertical.addArrangedSubview(spacingTitleWithSwitch)
        viewVertical.addArrangedSubview(switchPlayerFirst)
        viewVertical.addArrangedSubview(spacingBetweenSwith)
        viewVertical.addArrangedSubview(switchPlayerSecond)
        viewVertical.addArrangedSubview(spacingSwitchWithTitlePodcast)
        viewVertical.addArrangedSubview(titlePodcast)
        
        let viewHorizontal = UIStackView()
        viewHorizontal.axis = .horizontal
        viewHorizontal.translatesAutoresizingMaskIntoConstraints = false
        let viewLeft = UIView()
        let viewRight = UIView()
        
        viewHorizontal.addArrangedSubview(viewLeft)
        viewHorizontal.addArrangedSubview(viewVertical)
        viewHorizontal.addArrangedSubview(viewRight)
        
        [
            viewLeft.widthAnchor.constraint(equalToConstant: 35),
            viewRight.widthAnchor.constraint(equalToConstant: 35),
            
            titleSwitchPlayer.heightAnchor.constraint(equalToConstant: 23),
            spacingTitleWithSwitch.heightAnchor.constraint(equalToConstant: 10),
            switchPlayerFirst.heightAnchor.constraint(equalToConstant: 102),
            spacingBetweenSwith.heightAnchor.constraint(equalToConstant: 20),
            switchPlayerSecond.heightAnchor.constraint(equalToConstant: 102),
            spacingSwitchWithTitlePodcast.heightAnchor.constraint(equalToConstant: 45),
            titlePodcast.heightAnchor.constraint(equalToConstant: 23),
        ].forEach{$0.isActive = true}
       
        return viewHorizontal
    }

    let imageView: UIImageView = {
        var imageView = UIImageView()
        let image = Assets.logo.image
        imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let spacingImageWithTitle: UIView = {
        let spacingTitleSwitch = UIView()
        spacingTitleSwitch.frame.size.height = 10
        return spacingTitleSwitch
    }()
    
    let titleSwitchPlayer: UILabel = {
        let label = UILabel()
        label.text = "À écouter"
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 22)
        label.textColor = Colors.darkBlue.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let switchPlayerFirst: SwitchPlayer = {
        let switchPlayerFirst = SwitchPlayer(
            title: "EPISODE 78",
            subtitle: "Cuisines indiennes, clichés en sauce, et ça pique",
            imageString: Assets.aBientotDeTeRevoir.name
        )
        switchPlayerFirst.translatesAutoresizingMaskIntoConstraints = false
        return switchPlayerFirst
    }()

    let switchPlayerSecond: SwitchPlayer = {
        let switchPlayerSecond = SwitchPlayer(
            title: "EPISODE 90",
            subtitle: "Cuisines indiennes",
            imageString: Assets.aBientotDeTeRevoir.name
        )
        switchPlayerSecond.translatesAutoresizingMaskIntoConstraints = false
        return switchPlayerSecond
    }()
    
    let titlePodcast: UILabel = {
        let label = UILabel()
        label.text = "Nos Podcasts"
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 22)
        label.textColor = Colors.darkBlue.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let spacingTitleWithCollectionView: UIView = {
        let spacingTitleSwitch = UIView()
        spacingTitleSwitch.frame.size.height = 20
        return spacingTitleSwitch
    }()
    
    let collectionViewPodcast: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 35)
        layout.itemSize = CGSize(width: 148, height: 200)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        let collectionViewPodcast = UICollectionView(frame: CGRect(x: 0, y: 30, width: UIScreen.main.bounds.width, height: 200), collectionViewLayout: layout)
        collectionViewPodcast.backgroundColor = .clear
        collectionViewPodcast.isScrollEnabled = true
        collectionViewPodcast.translatesAutoresizingMaskIntoConstraints = false
        collectionViewPodcast.showsVerticalScrollIndicator = false
        collectionViewPodcast.showsHorizontalScrollIndicator = false
        return collectionViewPodcast
    }()
    
    let viewOffsetCollectionnView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private func initCollectionView() {
        collectionViewPodcast.register(PodcastHomePageCollectionViewCell.self, forCellWithReuseIdentifier: cellPodcast)
        collectionViewPodcast.dataSource = self
        collectionViewPodcast.delegate = self
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tabBarController?.selectedIndex = 1
    }
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
