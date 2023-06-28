//
//  PodcastViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 25/06/2023.
//

import UIKit

class PodcastViewController: UIViewController {

    @IBOutlet weak var carouselView: UIView!
    @IBOutlet weak var titleTableView: UILabel!
    @IBOutlet weak var tableViewEpisode: UITableView!
    
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
        // initViewCarouselView()
        carouselView.backgroundColor = .clear
        // collectionViewPodcast.delegate = self
        // collectionViewPodcast.dataSource = self
        setCollectionView()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    
    // Methode qui permet de créer un scroll automatique 
    @objc func scrollAutomatically(_ timer1: Timer) {

        if let coll  = myCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < 7){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                    coll.center.x = carouselView.center.x
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }

            }
        }
    }
    
    private func setCollectionView() {
        
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: carouselView.frame.size.width - 150, height: carouselView.frame.size.height - 40)
        layout.scrollDirection = .horizontal
        
        
        
        myCollectionView = UICollectionView(frame: CGRect(x: carouselView.frame.origin.x, y: carouselView.frame.origin.y, width: UIScreen.main.bounds.width, height: carouselView.frame.size.height), collectionViewLayout: layout)
        
        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView?.backgroundColor = UIColor.white
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        
        carouselView.addSubview(myCollectionView ?? UICollectionView())
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
            /*
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailRecipeController") as? DetailRecipe
            
            var description = String()
            recipeList[indexPath.row].recipe.ingredients.forEach {
                description.append(" \($0.food.capitalizingFirstLetter()),")
            }
            description.removeLast()

            vc?.label = recipeList[indexPath.row].recipe.label
            vc?.yield = recipeList[indexPath.row].recipe.yield
            vc?.totalTime = recipeList[indexPath.row].recipe.totalTime ?? 0
            vc?.url = recipeList[indexPath.row].recipe.url
            vc?.ingredientLines = recipeList[indexPath.row].recipe.ingredientLines
            vc?.image = recipeList[indexPath.row].recipe.image ?? ""
            vc?.ingredients = description

            guard let vc = vc else {return}
            self.navigationController?.pushViewController(vc, animated: true)
             */
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
        return 9 // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.backgroundColor = UIColor.gray
        return myCell
    }
}

extension PodcastViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
        
    }
    
    
    
    func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        IndexPath(row: 3, section: 0)
    }
    
    func scrollToNextCell(){

            //get Collection View Instance
           

            //get cell size
            let cellSize = CGSizeMake(self.view.frame.width, self.view.frame.height);

            //get current content Offset of the Collection view
        let contentOffset = myCollectionView?.contentOffset;

            //scroll to next cell
        myCollectionView?.scrollRectToVisible(CGRectMake(contentOffset!.x + cellSize.width, contentOffset!.y, cellSize.width, cellSize.height), animated: true);


        }

        /**
         Invokes Timer to start Automatic Animation with repeat enabled
         */
        func startTimer() {

            let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("scrollToNextCell"), userInfo: nil, repeats: true);


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

