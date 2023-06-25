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
        // Do any additional setup after loading the view.
    }
    
    private func titleSetUp() {
        titleTableView.text = L10n.allEpisodes
    }


}
