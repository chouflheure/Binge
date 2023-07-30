//
//  HomeViewController+CollectionView.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 30/07/2023.
//

import Foundation
import UIKit

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
