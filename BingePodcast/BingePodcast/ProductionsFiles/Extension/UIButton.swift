
import Foundation
import UIKit

extension UIButton {
    
    // J'ai créé cette extension car sinon en faisant une méthode dans le ViewController j'avais cette erreur
    // "Cannot use instance member 'setUpButton' within property initializer; property initializers run before 'self' is available"
    
    func generatedButton(width: CGFloat, height: CGFloat, button: UIButton,
                         image: String, imageWidth: CGFloat) {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        [
            button.widthAnchor.constraint(equalToConstant: width),
            button.heightAnchor.constraint(equalToConstant: height)
        ].forEach{$0.isActive = true}
        
        let font = UIFont.systemFont(ofSize: imageWidth)
        let config = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: image, withConfiguration: config)
        
        button.layer.cornerRadius = height / 2
        button.layer.borderWidth = 2.5
        button.layer.borderColor = Colors.darkBlue.color.cgColor
        button.tintColor = Colors.yellow.color
        button.setImage(image, for: .normal)
    }
    
    func changeSizeButton(button: UIButton, imageWidth: CGFloat, imageString: String) {
        let font = UIFont.systemFont(ofSize: imageWidth)
        let config = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: imageString, withConfiguration: config)
        button.setImage(image, for: .normal)
    }
}
