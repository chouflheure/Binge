//
//  FavoriteViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 09/07/2023.
//

import UIKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView.init(image: UIImage.init(named: Assets.aBientotDeTeRevoir.name))
        imageView.sizeToFit()
        imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan(recognizer:)))
        imageView.addGestureRecognizer(pan)
    }

    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }

}
