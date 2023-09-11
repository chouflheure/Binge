import Foundation
import UIKit

extension PlayerViewController {
    
    // MARK: - Set up Description
    // this methode is a method for generating the description view
    func setupDescription() {

        descriptionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        let marginTop = UIView()
        marginTop.translatesAutoresizingMaskIntoConstraints = false
        marginTop.heightAnchor.constraint(equalToConstant: Constants.verticalSmallSpacer).isActive = true
        
        var stackTitleAndFullScreen = UIStackView()
        stackTitleAndFullScreen = stackTitleAndFullScreen.horizontalStack()
        stackTitleAndFullScreen.alignment = .center
        stackTitleAndFullScreen.distribution = .fill
        
        let title = UILabel()
        title.text = L10n.description
        title.font = UIFont(name: .fonts.proximaNova_Alt_Bold.fontName(), size: 18)
        title.textColor = Colors.yellow.color

        let fullScreenButton = UIButton()
        fullScreenButton.generatedButton(isBordering: true,
                                         width: 30,
                                         height: 30,
                                         button: fullScreenButton,
                                         image: Assets.Picto.fullScreen.name,
                                         borderColor: .white.withAlphaComponent(0),
                                         backGroundColor: .white.withAlphaComponent(0.3)
        )
        
        fullScreenButton.addTarget(self, action: #selector(actionFullScreenButton), for: .touchUpInside)
        
        stackTitleAndFullScreen.addArrangedSubview(title)
        stackTitleAndFullScreen.addArrangedSubview(fullScreenButton)

        descriptionView.layer.cornerRadius = 33
        descriptionView.backgroundColor = Colors.purpleGradientMax.color.withAlphaComponent(0.8)

        descriptionView.addSubview(stackTitleAndFullScreen)
        descriptionView.addSubview(descriptionPodcast)
        
        descriptionView.layer.shadowRadius = 3
        descriptionView.layer.shadowOffset = CGSize(width: -2, height: -2)
        descriptionView.layer.shadowOpacity = 0.3
        descriptionView.layer.shadowColor = UIColor.black.cgColor
        descriptionView.layer.masksToBounds = false

        stackTitleAndFullScreen.translatesAutoresizingMaskIntoConstraints = false
        [
            stackTitleAndFullScreen.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 20),
            stackTitleAndFullScreen.heightAnchor.constraint(equalToConstant: 30),
            stackTitleAndFullScreen.leftAnchor.constraint(equalTo: descriptionView.leftAnchor, constant: 20),
            stackTitleAndFullScreen.rightAnchor.constraint(equalTo: descriptionView.rightAnchor, constant: -20),
            fullScreenButton.widthAnchor.constraint(equalToConstant: 30),
            fullScreenButton.heightAnchor.constraint(equalToConstant: 30)
        ].forEach{ $0.isActive = true }
        
        descriptionPodcast.translatesAutoresizingMaskIntoConstraints = false
        [
            descriptionPodcast.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            descriptionPodcast.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -20),
            descriptionPodcast.leftAnchor.constraint(equalTo: descriptionView.leftAnchor, constant: 20),
            descriptionPodcast.rightAnchor.constraint(equalTo: descriptionView.rightAnchor, constant: -20)
        ].forEach{ $0.isActive = true }
        
        scrollViewContainer.addArrangedSubview(marginTop)
        scrollViewContainer.addArrangedSubview(descriptionView)
    }
    
}
