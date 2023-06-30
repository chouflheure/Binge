//
//  PodcastViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 25/06/2023.
//

import UIKit


// https://guides.codepath.com/ios/Moving-and-Transforming-Views-with-Gestures
// lien pour faire bouger les view => Home page



class PodcastViewController: UIViewController {

    @IBOutlet weak var carouselView: UIView!
    @IBOutlet weak var titleTableView: UILabel!
    @IBOutlet weak var tableViewEpisode: UITableView!
    
    var actualIndexPathRow = 0
    
    private let cellPodcast = "cellPodcast"
    private let cellEpisode = "cellEpisode"
    private let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"
    private var myCollectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGenralView()
        titleSetUp()
        initTableView()
        initGeneralView()
        initViewCarouselView()
        carouselView.backgroundColor = .clear
        setCollectionView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setCollectionView() {
 
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: carouselView.frame.size.width - 150, height: 300)
        print("@@@ carouselView width  = \(carouselView.frame.size.width - 150)")
        print("@@@ carouselView height = \(carouselView.frame.size.height - 40)")

        layout.scrollDirection = .horizontal

        myCollectionView?.showsVerticalScrollIndicator = false
        myCollectionView?.showsHorizontalScrollIndicator = false

        myCollectionView = UICollectionView(frame: CGRect(x: carouselView.frame.origin.x, y: carouselView.frame.origin.y, width: UIScreen.main.bounds.width, height: 300), collectionViewLayout: layout)
        
        myCollectionView?.register(CellPodcastCollectionViewCell.self, forCellWithReuseIdentifier: cellPodcast)
        myCollectionView?.backgroundColor = UIColor.white
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self

        // positionCellWithIdexPath(indexCell: 0)

        carouselView.addSubview(myCollectionView ?? UICollectionView())

        let swipeGestureRecognizerDownLeftToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftToRight(_:)))
        let swipeGestureRecognizerDownRightToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightToLeft(_:)))
        swipeGestureRecognizerDownRightToLeft.direction = .left
        swipeGestureRecognizerDownLeftToRight.direction = .right
        
        carouselView.addGestureRecognizer(swipeGestureRecognizerDownLeftToRight)
        carouselView.addGestureRecognizer(swipeGestureRecognizerDownRightToLeft)

        positionCellWithIdexPath(indexCell: 0)
        
        myCollectionView?.isScrollEnabled = false

    }
    
    @objc private func swipeLeftToRight(_ sender: UISwipeGestureRecognizer) {
        print("@@@ swipe left to right")
        if actualIndexPathRow != 0 {
            positionCellWithIdexPath(indexCell: actualIndexPathRow - 1)
        }
    }
    
    @objc private func swipeRightToLeft(_ sender: UISwipeGestureRecognizer) {
        print("@@@ swipe right to left")
        if actualIndexPathRow != 6 {
            positionCellWithIdexPath(indexCell: actualIndexPathRow + 1)
        }
    }
    
    private func setupGenralView() {
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            Colors.ligthBlue.color.cgColor,
            UIColor.white.cgColor
        ]
        gradient.locations = [0, 1, 1]
        return gradient
    }()
    
    
    private func initGeneralView() {
        view.backgroundColor = Colors.ligthBlue.color
    }
    
    private func initViewCarouselView() {
        carouselView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    let cellSpacingHeight: CGFloat = 5
        
        let episodeArray = ["Episode 1", "Episode 2", "Episode 3", "Episode 4", "Episode 5", "Episode 6", "Episode 7", "Episode 8"]
        
        let titleEpisode = ["Les jeux olympiques sont ils utilent", "À quoi ca sert de courir ?", "Peut-on toujours repous…",
                            "Pourquoi les ballons no…", "Les jeux olympiques s…", "À quoi ca sert de courir ?",
                            "Peut-on toujours repous…", "Pourquoi les ballons no…"]
        
        let favorite = [true, false, false, true, false, true, true, true]

        let time = ["12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45"]
    
    let imagePodcastString = Assets.aBientotDeTeRevoir.name
    
    
    
    private func titleSetUp() {
        titleTableView.text = L10n.allEpisodes
        titleTableView.font = UIFont(name: .fonts.proximaNova_Thin.fontName(), size: 18)
        titleTableView.textColor = Colors.darkBlue.color
    }
    
    private func initTableView() {
        tableViewEpisode.delegate = self
        tableViewEpisode.dataSource = self
        tableViewEpisode.register(UINib(nibName: cellEpisodeTabViewCell, bundle: nil), forCellReuseIdentifier: cellEpisode)
        tableViewEpisode.backgroundColor = .clear
    }
}

extension PodcastViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        print("@@@ select at \(indexPath)")

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        self.present(mainViewController, animated: true, completion: nil)
        
        }
}
        
extension PodcastViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        episodeArray.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let index = indexPath.section

        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellEpisode,
            for: indexPath as IndexPath) as? CellEpisodeTabViewCell

        guard let cell = cell else {return UITableViewCell()}

        cell.setupCell(title: episodeArray[index], subtitle: titleEpisode[index], imageEpisode: imagePodcastString, time: time[index], favorite: favorite[index])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            cellSpacingHeight
        }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        82
    }

}


extension PodcastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7 // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPodcast, for: indexPath) as? CellPodcastCollectionViewCell
        
        guard let myCell = myCell else {return UICollectionViewCell()}
        // myCell.backgroundColor = UIColor.gray
        myCell.setUpUI(title: "Title Test")

        switch indexPath.row {
        case 0:  myCell.backgroundColor = .red
        case 1:  myCell.backgroundColor = .blue
        case 2:  myCell.backgroundColor = .green
        case 3:  myCell.backgroundColor = .brown
        case 4:  myCell.backgroundColor = .black
        case 5:  myCell.backgroundColor = .darkGray
        case 6:  myCell.backgroundColor = .orange
        default: myCell.backgroundColor = UIColor.gray
        }

        return myCell
    }
}

extension PodcastViewController: UICollectionViewDelegate {
 
    private func positionCellWithIdexPath(indexCell: Int) {
        
        
        let attributes = myCollectionView?.layoutAttributesForItem(at: IndexPath(row: indexCell, section: 0))
        print("@@@ attributes = \(attributes)")
        print("@@@ attributes zIndex = \(attributes?.zIndex)")
        print("@@@ attributes origin = \(attributes?.frame.origin)")
        var height: CGFloat? = 0.0
        var width: CGFloat? = 0.0
        print("@@@ carousel cennter : \(carouselView.frame.width)")
        if attributes != nil {
            width = attributes!.frame.origin.x - attributes!.frame.width/2 + 40
            height = 0
        }
        
        let position = CGPoint(x: width ?? 0, y: height ?? 0)
        print("@@@ position = \(position)")
        
        myCollectionView?.setContentOffset(position, animated: true)
        actualIndexPathRow = indexCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("@@@ User tapped on item \(indexPath.row)")

        positionCellWithIdexPath(indexCell: indexPath.row)
        
    }
}



    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

