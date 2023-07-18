
import Foundation
import UIKit

class DescriptionPlayerViewController: UIViewController {
    
    let titlePodcast: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white.color
        label.text = "A bientot te revoir"
        label.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 20)
        label.textColor = .white
        return label
    }()

    let authorPodcast: UILabel = {
        let label = UILabel()
        label.text = "Remi Sourcier"
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 12)
        label.textColor = .white
        return label
    }()

    let imageReturn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 33 / 2
        btn.backgroundColor = .lightGray
        btn.setImage(Assets.Picto.chevronDown.image, for: .normal)
        let image = Assets.Picto.chevronDown.image
        return btn
    }()
    
    let titleDescriptionPodcast : UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 20)
        return label
    }()
    
    let descriptionPodcast: UITextView = {
        let label = UITextView()
        label.text = """
            Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices. Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices. Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices.
            """
        return label
    }()
    
    let imageAuthor: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = Assets.aBientotDeTeRevoir.image
        imageView.layer.cornerRadius = 50 / 2
        return imageView
    }()


    override func viewDidLoad() {
        view.backgroundColor = Colors.purpleGradientMax.color.withAlphaComponent(0.8)
        headerDescription()
    }
    
    private func headerDescription() {
        let stackHeaderSDescription = UIStackView()
        stackHeaderSDescription.axis = .horizontal
        stackHeaderSDescription.translatesAutoresizingMaskIntoConstraints = false
        

        let stackImageReturn = UIStackView()
        stackImageReturn.axis = .vertical
        stackImageReturn.alignment = .fill
        stackImageReturn.distribution = .fill
        
        let viewTop = UIView()
        let viewBottom = UIView()
        
        
        
        stackImageReturn.translatesAutoresizingMaskIntoConstraints = false
        viewTop.translatesAutoresizingMaskIntoConstraints = false
        viewBottom.translatesAutoresizingMaskIntoConstraints = false
        
        stackImageReturn.addArrangedSubview(viewTop)
        stackImageReturn.addArrangedSubview(imageReturn)
        stackImageReturn.addArrangedSubview(viewBottom)
        
        [
            viewTop.heightAnchor.constraint(equalToConstant: (50 - 33)/2),
            viewBottom.heightAnchor.constraint(equalToConstant: (50 - 33)/2),
            // imageReturn.heightAnchor.constraint(equalToConstant: 50 - ),
            
            
        ].forEach{$0.isActive = true}
        
        let stackTitle = UIStackView()
        stackTitle.axis = .vertical
        stackTitle.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        stackHeaderSDescription.addArrangedSubview(stackImageReturn)
        stackHeaderSDescription.addArrangedSubview(titlePodcast)
        stackHeaderSDescription.addArrangedSubview(imageAuthor)
        
        view.addSubview(stackHeaderSDescription)
        [
            stackHeaderSDescription.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            stackHeaderSDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            stackHeaderSDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            stackHeaderSDescription.heightAnchor.constraint(equalToConstant: 50),
            
            imageAuthor.widthAnchor.constraint(equalToConstant: 50),
            
            imageReturn.widthAnchor.constraint(equalToConstant: 33),
            
            
        ].forEach{$0.isActive = true}
        
        stackHeaderSDescription.backgroundColor = .red
    }
    
    
}
