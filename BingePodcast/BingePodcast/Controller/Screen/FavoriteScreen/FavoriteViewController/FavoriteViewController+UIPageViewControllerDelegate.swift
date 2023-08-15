import Foundation
import UIKit

// MARK: - Extension Page Controller
extension FavoriteViewController: UIPageViewControllerDelegate {
    
    private func nextPagePoint() {
        seeLaterTitle.adjustsFontSizeToFitWidth = true
        favoriteTitle.adjustsFontSizeToFitWidth = true
        
        if currentIndex == 0 {
            seeLaterTitle.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 24)
            favoriteTitle.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 24)
            UIView.animate(withDuration: 0.3) {
                self.leftContainer!.constant += UIScreen.main.bounds.width -
                    (self.favoriteTitle.intrinsicContentSize.width / 2) -
                    (self.seeLaterTitle.intrinsicContentSize.width / 2) - 80
                self.view.layoutIfNeeded() // Assurez-vous d'appeler cette méthode pour mettre à jour l'affichage.
            }
            currentIndex += 1
        }
    }
    
    private func previousPagePoint() {
        if currentIndex == 1 {
            seeLaterTitle.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 24)
            favoriteTitle.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 24)
           
            UIView.animate(withDuration: 0.3) {
                self.leftContainer!.constant -= UIScreen.main.bounds.width -
                    (self.favoriteTitle.intrinsicContentSize.width / 2) -
                    (self.seeLaterTitle.intrinsicContentSize.width / 2) - 80
                self.view.layoutIfNeeded() // Assurez-vous d'appeler cette méthode pour mettre à jour l'affichage.
            }
            currentIndex -= 1
        }
    }
    
    @objc func nextPageController() {
        guard let pageController = pageController else {return}
        pageController.setViewControllers([PageListFavorite(with: seeLater)],
                                          direction: .forward,
                                          animated: true,
                                          completion: nil)
        nextPagePoint()
    }
    
    @objc func previousPageController() {
        guard let pageController = pageController else {return}
        pageController.setViewControllers([PageListFavorite(with: podcastSaved)],
                                          direction: .reverse,
                                          animated: true,
                                          completion: nil)
        previousPagePoint()
    }
    
    func setupPageController() {
        
        self.pageController = UIPageViewController(transitionStyle: .scroll,
                                                   navigationOrientation: .horizontal,
                                                   options: nil)
        // nil dataSour to disable the swipe gesture on PageController
        self.pageController?.dataSource = nil
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear

        self.pageController?.view.frame = CGRect(
            x: 0,
            y: 120,
            width: self.view.frame.width,
            height: self.view.frame.height - 120
        )
        
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        
        let initialVC = PageListFavorite(with: podcastSaved)
        
        self.pageController?.setViewControllers([initialVC], direction: .forward,
                                                animated: true,
                                                completion: nil)
        
        self.pageController?.didMove(toParent: self)
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}
