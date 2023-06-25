//
//  PodcastViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 25/06/2023.
//

import UIKit

class PodcastViewController: UIViewController {
    
    
    
    @IBOutlet weak var titleTableView: UILabel!
    
    @IBOutlet weak var carouselView: UIView!
    @IBOutlet weak var tableViewEpisode: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleSetUp()
        initTableView()
        // Do any additional setup after loading the view.
    }
    
    
    let cellSpacingHeight: CGFloat = 5
        
        let episodeArray = ["Episode 1", "Episode 2", "Episode 3", "Episode 4", "Episode 5", "Episode 6",
                            "Episode 7", "Episode 8"]
        
        let titleEpisode = ["Les jeux olympiques s…", "À quoi ca sert de courir ?", "Peut-on toujours repous…",
                            "Pourquoi les ballons no…", "Les jeux olympiques s…", "À quoi ca sert de courir ?",
                            "Peut-on toujours repous…", "Pourquoi les ballons no…"]
        
        let favorite = [true, false, false, true, false, true, true, true]

        let time = ["12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45", "12:45"]
    let imagePodcastString = Assets.aBientotDeTeRevoir.name
    
    
    
    private func titleSetUp() {
        titleTableView.text = L10n.allEpisodes
    }
    
    private func initTableView() {
        tableViewEpisode.delegate = self
        tableViewEpisode.dataSource = self
        tableViewEpisode.register(UINib(nibName: "CellPodcastViewController", bundle: nil), forCellReuseIdentifier: "cell")
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
