//
//  PodcastViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 23/06/2023.
//

import UIKit

class PodcastViewController: UIViewController {
        
    @IBOutlet weak var viewCarousel: UIView!
    @IBOutlet weak var episodeTableView: UITableView!
    @IBOutlet weak var titleTableView: UILabel!

    let cellSpacingHeight: CGFloat = 5
    
    let episodeArray = ["Episode 1", "Episode 2", "Episode 3", "Episode 4", "Episode 5", "Episode 6",
                        "Episode 7", "Episode 8"]
    
    let titleEpisode = ["Les jeux olympiques s…", "À quoi ca sert de courir ?", "Peut-on toujours repous…",
                        "Pourquoi les ballons no…", "Les jeux olympiques s…", "À quoi ca sert de courir ?",
                        "Peut-on toujours repous…", "Pourquoi les ballons no…"]
    
    let favorite = [true, false, false, true, false, true, true, true]

    let time = ["12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45"]
    let imagePodcastString = Assets.aBientotDeTeRevoir.name


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        episodeTableView.register(UINib(nibName: "CellPodcastViewController", bundle: nil), forCellReuseIdentifier: "cell")
        titleTableView.text = L10n.tousLesEpisodes
    }
    
    private func editSizeViewCarouselAndTableView() {
        viewCarousel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

extension PodcastViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1 // recipeList.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        episodeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.section

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath as IndexPath) as? CellPodcastViewController

        guard var cell = cell else {return UITableViewCell()}

        cell.setupCell(title: episodeArray[index], subtitle: titleEpisode[index], imageEpisode: imagePodcastString, time: time[index], favorite: favorite[index])
        
        // cell = cell.setupUI(cell: cell, recipeList: recipeList, indexPath: indexPath.row)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            cellSpacingHeight
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       85
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
