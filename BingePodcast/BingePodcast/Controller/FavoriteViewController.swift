/*
 //
//  FavoriteViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 03/07/2023.
//

import UIKit

class FavoriteViewController: UIViewController {

    let carouselView = UIView()
    var actualIndexPathRow = 0

    private let cellPodcast = "cellPodcast"
    private let cellEpisode = "cellEpisode"
    private let cellEpisodeTableView = "cellEpisodeTableView"
    private let cellEpisodeTabViewCell = "CellEpisodeTabViewCell"
    private var myCollectionViewPodcast: UICollectionView?
    private var myCollectionViewEpisode: UICollectionView?
    private var tableViewEpisode = UITableView()
    
    let cellSpacingHeight: CGFloat = 5
        
    let episodeArray = ["Episode 1", "Episode 2", "Episode 3", "Episode 4", "Episode 5", "Episode 6", "Episode 7", "Episode 8"]
        
    let titleEpisode = ["Les jeux olympiques sont ils utilent", "À quoi ca sert de courir ?", "Peut-on toujours repous…",
                            "Pourquoi les ballons no…", "Les jeux olympiques s…", "À quoi ca sert de courir ?",
                            "Peut-on toujours repous…", "Pourquoi les ballons no…"]
        
    let favorite = [true, false, false, true, false, true, true, true]

    let time = ["12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45"]
    
    let imagePodcastString = Assets.aBientotDeTeRevoir.name
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(carouselView)
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        [
            carouselView.heightAnchor.constraint(equalToConstant: 300),
            carouselView.leftAnchor.constraint(equalTo: view.leftAnchor),
            carouselView.rightAnchor.constraint(equalTo: view.rightAnchor),
            carouselView.topAnchor.constraint(equalTo: view.topAnchor),
            carouselView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 82)

        ].forEach{$0.isActive = true}
        
        carouselView.backgroundColor = .clear
        
        setupCollectionViewPodcast()
        setupCollectionViewEpisode()
        setupGradietView()
        initTableView()
    }
    
    private func initTableView() {
        tableViewEpisode.delegate = self
        tableViewEpisode.dataSource = self
        tableViewEpisode.register(UINib(nibName: "CellEpisodeTabViewCell", bundle: nil), forCellReuseIdentifier: "cellEpisode")
        tableViewEpisode.backgroundColor = .clear
    }
    
    private func setupGradietView() {
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
    
    private func setupCollectionViewPodcast() {
 
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 200, height: 300)
        layout.scrollDirection = .horizontal

        myCollectionViewPodcast?.showsVerticalScrollIndicator = false
        myCollectionViewPodcast?.showsHorizontalScrollIndicator = false

        myCollectionViewPodcast = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300), collectionViewLayout: layout)
        
        myCollectionViewPodcast?.register(CellPodcastCollectionViewCell.self, forCellWithReuseIdentifier: cellPodcast)
        myCollectionViewPodcast?.backgroundColor = .clear
        
        myCollectionViewPodcast?.dataSource = self
        myCollectionViewPodcast?.delegate = self

        // positionCellWithIdexPath(indexCell: 0)

        carouselView.addSubview(myCollectionViewPodcast ?? UICollectionView())

        let swipeGestureRecognizerDownLeftToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftToRight(_:)))
        let swipeGestureRecognizerDownRightToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightToLeft(_:)))
        swipeGestureRecognizerDownRightToLeft.direction = .left
        swipeGestureRecognizerDownLeftToRight.direction = .right
        
        carouselView.addGestureRecognizer(swipeGestureRecognizerDownLeftToRight)
        carouselView.addGestureRecognizer(swipeGestureRecognizerDownRightToLeft)

        positionCellWithIdexPath(indexCell: 0)
        
        myCollectionViewPodcast?.isScrollEnabled = false

    }
    
    private func setupCollectionViewEpisode() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 300)
        layout.scrollDirection = .horizontal

        myCollectionViewEpisode?.showsVerticalScrollIndicator = false
        myCollectionViewEpisode?.showsHorizontalScrollIndicator = false
        myCollectionViewEpisode = UICollectionView(frame: CGRect(x: 0, y: 300, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 300), collectionViewLayout: layout)
        myCollectionViewEpisode?.register(CellEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: cellEpisode)
        myCollectionViewEpisode?.backgroundColor = .clear
        
        myCollectionViewEpisode?.dataSource = self
        myCollectionViewEpisode?.delegate = self
        // positionCellWithIdexPath(indexCell: 0)
        carouselView.addSubview(myCollectionViewEpisode ?? UICollectionView())
        
        let swipeGestureRecognizerDownLeftToRight = UISwipeGestureRecognizer(target: self, action:      #selector(swipeLeftToRight(_:)))
        let swipeGestureRecognizerDownRightToLeft = UISwipeGestureRecognizer(target: self, action:      #selector(swipeRightToLeft(_:)))
        swipeGestureRecognizerDownRightToLeft.direction = .left
        swipeGestureRecognizerDownLeftToRight.direction = .right
        
        carouselView.addGestureRecognizer(swipeGestureRecognizerDownLeftToRight)
        carouselView.addGestureRecognizer(swipeGestureRecognizerDownRightToLeft)
        positionCellWithIdexPath(indexCell: 0)
        
        myCollectionViewEpisode?.isScrollEnabled = false
    }
    
    
    
    
    @objc private func swipeLeftToRight(_ sender: UISwipeGestureRecognizer) {
        print("@@@ swipe left to right")
        if actualIndexPathRow != 0 {
            positionCellWithIdexPath(indexCell: actualIndexPathRow - 1)
        }
        /*
        guard let cell = myCollectionView?.cellForItem(at: IndexPath(row: actualIndexPathRow, section: 0)) as? CellPodcastCollectionViewCell else {return}
        cell.imageViewPodcast.isHidden = false
         */
        
    }
    
    @objc private func swipeRightToLeft(_ sender: UISwipeGestureRecognizer) {
        print("@@@ swipe right to left")
        if actualIndexPathRow != 6 {
            positionCellWithIdexPath(indexCell: actualIndexPathRow + 1)
        }
        /*
        guard let cell = myCollectionView?.cellForItem(at: IndexPath(row: actualIndexPathRow, section: 0)) as? CellPodcastCollectionViewCell else {return}
        cell.imageViewPodcast.isHidden = false
         */
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7 // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == myCollectionViewEpisode {
            print("@@@ here collectio,View 2")
            let myCell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellEpisode, for: indexPath) as? CellEpisodeCollectionViewCell

            guard let myCell2 = myCell2 else {return UICollectionViewCell()}
            switch indexPath.row {
            case 0:  myCell2.backgroundColor = .blue
            case 1:  myCell2.backgroundColor = .green
            case 2:  myCell2.backgroundColor = .brown
            case 3:  myCell2.backgroundColor = .black
            case 4:  myCell2.backgroundColor = .darkGray
            case 5:  myCell2.backgroundColor = .orange
            case 6:  myCell2.backgroundColor = .orange
            default: myCell2.backgroundColor = UIColor.gray
            }
            
            myCell2.addElement(tableEpisode: tableViewEpisode, height: myCollectionViewEpisode?.frame.height ?? 0)
            
            
            return myCell2
        }
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPodcast, for: indexPath) as? CellPodcastCollectionViewCell
        
        guard let myCell = myCell else {return UICollectionViewCell()}
        // myCell.backgroundColor = UIColor.gray
        myCell.setUpUI(title: "", subtitlePodcast: Assets.aBientotDeTeRevoir.name, imagePodcastString: "")

        switch indexPath.row {
        case 0:  myCell.backgroundColor = .gray
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

extension FavoriteViewController: UICollectionViewDelegate {
 
    private func positionCellWithIdexPath(indexCell: Int) {
        
        let attributesCollectionViewPodcast = myCollectionViewPodcast?.layoutAttributesForItem(
            at: IndexPath(row: indexCell, section: 0)
        )

        let attributesCollectionViewEpisode = myCollectionViewEpisode?.layoutAttributesForItem(
            at: IndexPath(row: indexCell, section: 0)
        )
        
        var height: CGFloat? = 0.0
        var width: CGFloat? = 0.0

        if attributesCollectionViewPodcast != nil {
            width = attributesCollectionViewPodcast!.frame.origin.x - attributesCollectionViewPodcast!.frame.width/2 - 10
            height = 0
        }

        let position = CGPoint(x: width ?? 0, y: height ?? 0)

        myCollectionViewEpisode?.setContentOffset(
            CGPoint(x: attributesCollectionViewEpisode?.frame.origin.x ?? 0, y: 0),
            animated: true
        )

        myCollectionViewPodcast?.setContentOffset(position, animated: true)
        actualIndexPathRow = indexCell
    }

    // Methode qui permet de changer la tronche de la cell ( cacher le text, enlever le blur ... )
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("@@@ User tapped on item \(indexPath.row)")
        guard let cell = myCollectionViewPodcast?.cellForItem(at: indexPath) as? CellPodcastCollectionViewCell else {return}
        // cell.imageViewPodcast.isHidden = false
        // TODO : ajouter une animation to blur

        positionCellWithIdexPath(indexCell: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = myCollectionViewPodcast?.cellForItem(at: indexPath) as? CellPodcastCollectionViewCell else {return}
        // cell.imageViewPodcast.isHidden = true
    }

}



extension FavoriteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        print("@@@ select at \(indexPath)")

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        self.present(mainViewController, animated: true, completion: nil)
        
        }
}
        
extension FavoriteViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        episodeArray.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        
        let index = indexPath.section

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cellEpisode",
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
*/
