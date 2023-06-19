
import Foundation
import UIKit

extension UIButton {
    
    // J'ai créé cette extension car sinon en faisant une méthode dans le ViewController j'avais cette erreur
    // "Cannot use instance member 'setUpButton' within property initializer; property initializers run before 'self' is available"
    
    func generatedButton(width: CGFloat, height: CGFloat, button: UIButton,
                         image: String, imageWidth: CGFloat, imageHeight: CGFloat) {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        [
            button.widthAnchor.constraint(equalToConstant: width),
            button.heightAnchor.constraint(equalToConstant: height)
        ].forEach{$0.isActive = true}
        
        button.layer.cornerRadius = height / 2
        button.layer.borderWidth = 2.5
        button.layer.borderColor = Colors.darkBlue.color.cgColor

        let image = UIImage(systemName: image)
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: width, height: height)
        imageView.tintColor = Colors.yellow.color

        button.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        [
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageWidth),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight)
        ].forEach{ $0.isActive = true }
    }
}
