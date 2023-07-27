
import Foundation
import UIKit

extension UIButton {
    
    func generatedButton(isBordering: Bool,
                         width: CGFloat,
                         height: CGFloat,
                         button: UIButton,
                         image: String,
                         borderColor: UIColor,
                         backGroundColor: UIColor)
    {
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
