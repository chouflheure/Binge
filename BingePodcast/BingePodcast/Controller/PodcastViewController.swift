//
//  PodcastViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 23/06/2023.
//

import UIKit

class PodcastViewController: UIViewController {
        
    @IBOutlet weak var episodeTableView: UITableView!
    @IBOutlet weak var viewCaroussel: UIView!
    @IBOutlet weak var titleTableView: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        episodeTableView.register(UINib(nibName: "CellPodcastViewController", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    private func editSizeViewCarouselAndTableView() {
        viewCaroussel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    

}

extension PodcastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10 // recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath as IndexPath) as? CellPodcastViewController

        guard var cell = cell else {return UITableViewCell()}
        
        cell.title.text = "test"
        // cell = cell.setupUI(cell: cell, recipeList: recipeList, indexPath: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       85
    }
}

extension PodcastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
