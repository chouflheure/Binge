import Foundation
import UIKit

extension PlayerViewController {
    
    // MARK: - Return View
    // return view is a method for generating the return bouton
    func returnView() {
        let spacingBetweenImageAndTitle = UIView()
        spacingBetweenImageAndTitle.translatesAutoresizingMaskIntoConstraints = false
        let chevronReturn = UIImageView(image: UIImage(named: Assets.Picto.chevronReturn.name))
        chevronReturn.translatesAutoresizingMaskIntoConstraints = false

        let marginOnTop = UIView()
        marginOnTop.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContainer.addArrangedSubview(marginOnTop)

        if isReturnButtonChevronLeft {
            let titleReturn: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = L10n.podcast
                label.textColor = Colors.white.color
                label.font = UIFont(name: .fonts.proximaNova_Alt_Light.fontName(), size: 20)
                return label
            }()
            stackReturnView.addArrangedSubview(chevronReturn)
            stackReturnView.addArrangedSubview(spacingBetweenImageAndTitle)
            stackReturnView.addArrangedSubview(titleReturn)
        } else {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            chevronReturn.transform = chevronReturn.transform.rotated(by: .pi * 1.5)
            stackReturnView.addArrangedSubview(chevronReturn)
            stackReturnView.addArrangedSubview(view)
        }
        
        stackVerticalMenu.addArrangedSubview(generateVerticalSpace(height: 8))
        stackVerticalMenu.addArrangedSubview(setup3ButtonMenu())
        stackVerticalMenu.addArrangedSubview(generateVerticalSpace(height: 8))

        let spacingBetweenReturnAndMenu = UIView()
        spacingBetweenReturnAndMenu.translatesAutoresizingMaskIntoConstraints = false
        
    
        stackTopViewPlayer.addArrangedSubview(stackReturnView)
        stackTopViewPlayer.addArrangedSubview(spacingBetweenReturnAndMenu)
        stackReturnView.addArrangedSubview(stackVerticalMenu)
        
        scrollViewContainer.addArrangedSubview(stackTopViewPlayer)

        [
            marginOnTop.heightAnchor.constraint(equalToConstant: 10),
            chevronReturn.widthAnchor.constraint(equalToConstant: 12),
            spacingBetweenImageAndTitle.widthAnchor.constraint(equalToConstant: 10),
            stackVerticalMenu.widthAnchor.constraint(equalToConstant: 25),
            stackVerticalMenu.rightAnchor.constraint(equalTo: stackTopViewPlayer.rightAnchor),
            stackTopViewPlayer.heightAnchor.constraint(equalToConstant: 21),
            
        ].forEach{$0.isActive = true}
        
    }
    
    // MARK: - Three button Menu
    // this methode is a method for generating the 3 buttons menu
    func setup3ButtonMenu() -> UIStackView {
        
        let stackThreePoint = UIStackView()
        stackThreePoint.axis = .horizontal
        stackThreePoint.distribution = .fill

        let point1 = UIView()
        let point2 = UIView()
        let point3 = UIView()
        let spacingBetweenPoint1 = UIView()
        let spacingBetweenPoint2 = UIView()
        
        [
            stackThreePoint, point1, point2, point3, spacingBetweenPoint1, spacingBetweenPoint2
        ].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}

        stackThreePoint.addArrangedSubview(generatePoint(width: 5))
        stackThreePoint.addArrangedSubview(generateHorizontalSpace(width: 5))
        stackThreePoint.addArrangedSubview(generatePoint(width: 5))
        stackThreePoint.addArrangedSubview(generateHorizontalSpace(width: 5))
        stackThreePoint.addArrangedSubview(generatePoint(width: 5))

        stackThreePoint.widthAnchor.constraint(equalToConstant: 25).isActive = true
        stackThreePoint.heightAnchor.constraint(equalToConstant: 5).isActive = true

        return stackThreePoint
    }
    
}
