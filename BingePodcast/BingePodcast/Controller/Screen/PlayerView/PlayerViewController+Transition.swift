
import Foundation
import UIKit

extension PlayerViewController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationPlayerDescriptionPresent(firstViewController: self, secondViewController: DescriptionPlayerViewController())
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationPlayerDescriptionDismiss()
    }

}
