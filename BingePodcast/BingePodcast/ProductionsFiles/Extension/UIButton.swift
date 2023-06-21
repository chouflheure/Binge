
import Foundation
import UIKit

extension UIButton {
    
    // J'ai créé cette extension car sinon en faisant une méthode dans le ViewController j'avais cette erreur
    // "Cannot use instance member 'setUpButton' within property initializer; property initializers run before 'self' is available"
    
    func generatedButton(isBordering: Bool,
                         width: CGFloat,
                         height: CGFloat,
                         button: UIButton,
                         image: String,
                         borderColor: UIColor,
                         backGroundColor: UIColor)
    {
    
        button.translatesAutoresizingMaskIntoConstraints = false
        [
            button.widthAnchor.constraint(equalToConstant: width),
            button.heightAnchor.constraint(equalToConstant: height)
        ].forEach{$0.isActive = true}
        
        let image = UIImage(named: image)

        if isBordering {
            button.layer.cornerRadius = height / 2
            button.layer.borderWidth = 2.5
            button.layer.borderColor = borderColor.cgColor
        }

        button.contentMode = .scaleAspectFit
        button.setImage(image, for: .normal)
        button.backgroundColor = backGroundColor
    }

    func changeSizeButton(button: UIButton, imageWidth: CGFloat, imageString: String) {
        let image = UIImage(named: imageString)
        button.contentMode = .scaleAspectFit
        button.setImage(image, for: .normal)
    }
}
