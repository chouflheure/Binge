import Foundation
import UIKit

extension FavoriteViewController: UIPageViewControllerDelegate {

    @objc func nextPageController() {
        animationTransitionTitle()
        guard let pageController = pageController else {return}
        
        pageController.setViewControllers([arrayPageListFavorite[currentIndex]],
                                          direction: .forward,
                                          animated: true,
                                          completion: nil)
    }
    
    @objc func previousPageController() {
        animationTransitionTitle()
        guard let pageController = pageController else {return}
        pageController.setViewControllers([arrayPageListFavorite[currentIndex]],
                                          direction: .reverse,
                                          animated: true,
                                          completion: nil)
    }

    // This method is used to initialise the method which displays the transition of the yellow border showing the selected element
    private func animationTransitionTitle() {
        seeLaterTitle.adjustsFontSizeToFitWidth = true
        favoriteTitle.adjustsFontSizeToFitWidth = true

        if currentIndex == 1 {
            seeLaterTitle.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 24)
            favoriteTitle.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 24)
           
            UIView.animate(withDuration: 0.3) {
                self.leftContainer!.constant -= UIScreen.main.bounds.width -
                    (self.favoriteTitle.intrinsicContentSize.width / 2) -
                    (self.seeLaterTitle.intrinsicContentSize.width / 2) - 80
                self.view.layoutIfNeeded()
            }
            currentIndex -= 1
        } else {
            seeLaterTitle.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 24)
            favoriteTitle.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 24)
            UIView.animate(withDuration: 0.3) {
                self.leftContainer!.constant += UIScreen.main.bounds.width -
                    (self.favoriteTitle.intrinsicContentSize.width / 2) -
                    (self.seeLaterTitle.intrinsicContentSize.width / 2) - 80
                self.view.layoutIfNeeded()
            }
            currentIndex += 1
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        2
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentIndex
    }
}
