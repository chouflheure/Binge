
import Foundation
import UIKit

class DescriptionPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        
        headerDescription()
        scrollView.backgroundColor = Colors.purpleGradientMax.color.withAlphaComponent(0.8)
        descriptionPart()

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scrollViewContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30).isActive = true
        
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60).isActive = true
        
        imageReturn.addTarget(self, action: #selector(actionReturnButton), for: .touchDown)
    }

    @objc func actionReturnButton() {
        dismiss(animated: true)
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()

        view.axis = .vertical
        view.spacing = 10

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titlePodcast: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white.color
        label.text = "À bientôt te revoir"
        label.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 20)
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()

    let authorPodcast: UILabel = {
        let label = UILabel()
        label.text = "Remi Sourcier"
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 12)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()

    let imageReturn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 33 / 2
        btn.backgroundColor = Colors.white.color.withAlphaComponent(0.3)
        btn.setImage(Assets.Picto.chevronDown.image, for: .normal)
        return btn
    }()
    
    let titleDescriptionPodcast : UILabel = {
        let label = UILabel()
        label.text = L10n.description
        label.font = UIFont(name: .fonts.proximaNova_Alt_Bold.fontName(), size: 18)
        label.textColor = Colors.yellow.color
        return label
    }()
    
    let descriptionPodcast: UITextView = {
        let textView = UITextView()
        
        
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false

        let string = """
            Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices. Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices. Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons. Le premier best-of est est A bientôt de te revoir accompagne les auditeur·ices.
            """

        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        textView.attributedText = attributedString
        
        textView.font = UIFont(name: .fonts.proximaNova_Alt_Light.fontName(), size: 18)
        textView.textColor = Colors.white.color
        textView.backgroundColor = .clear
        
        return textView
    }()
    
    let imageAuthor: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = Assets.aBientotDeTeRevoir.image
        imageView.layer.cornerRadius = 50 / 2
        return imageView
    }()

    
    let stackHeaderSDescription: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    
    let stackImageReturn: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let stackTitle: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func headerDescription() {
       
        let viewTopImageButton = UIView()
        let viewBottomImageButton = UIView()
        viewTopImageButton.translatesAutoresizingMaskIntoConstraints = false
        viewBottomImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackImageReturn.addArrangedSubview(viewTopImageButton)
        stackImageReturn.addArrangedSubview(imageReturn)
        stackImageReturn.addArrangedSubview(viewBottomImageButton)
        
        [
            viewTopImageButton.heightAnchor.constraint(equalToConstant: (50 - 33)/2),
            viewBottomImageButton.heightAnchor.constraint(equalToConstant: (50 - 33)/2),
        ].forEach{$0.isActive = true}
        
        
        
        let viewBetweenTitle = UIView()
        
        
        
        let spaceBeteweenReturnBtnAndTitle = UIView()
        spaceBeteweenReturnBtnAndTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let spaceBeteweenTitleAndImageAuthor = UIView()
        spaceBeteweenTitleAndImageAuthor.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackHeaderSDescription.addArrangedSubview(stackImageReturn)
        stackHeaderSDescription.addArrangedSubview(spaceBeteweenReturnBtnAndTitle)
        stackHeaderSDescription.addArrangedSubview(stackTitle)
        stackHeaderSDescription.addArrangedSubview(spaceBeteweenTitleAndImageAuthor)
        stackHeaderSDescription.addArrangedSubview(imageAuthor)
        
        

        stackTitle.addArrangedSubview(titlePodcast)
        stackTitle.addArrangedSubview(viewBetweenTitle)
        stackTitle.addArrangedSubview(authorPodcast)

        stackTitle.translatesAutoresizingMaskIntoConstraints = false

        [
            titlePodcast.topAnchor.constraint(equalTo: stackTitle.topAnchor),
            authorPodcast.bottomAnchor.constraint(equalTo: stackTitle.bottomAnchor),
            
            stackTitle.leftAnchor.constraint(equalTo: spaceBeteweenReturnBtnAndTitle.rightAnchor),
            stackTitle.rightAnchor.constraint(equalTo: spaceBeteweenTitleAndImageAuthor.leftAnchor),
            
            spaceBeteweenTitleAndImageAuthor.widthAnchor.constraint(equalToConstant: 10),
            spaceBeteweenReturnBtnAndTitle.widthAnchor.constraint(equalToConstant: 10),
            
        ].forEach{$0.isActive = true}
        
        
        let viewTopHeaderDescription = UIView()
        scrollViewContainer.addArrangedSubview(viewTopHeaderDescription)

        scrollViewContainer.addArrangedSubview(stackHeaderSDescription)
        stackHeaderSDescription.translatesAutoresizingMaskIntoConstraints = false
        [
            viewTopHeaderDescription.heightAnchor.constraint(equalToConstant: 30),
            stackHeaderSDescription.heightAnchor.constraint(equalToConstant: 50),
            imageAuthor.widthAnchor.constraint(equalToConstant: 50),
            imageReturn.widthAnchor.constraint(equalToConstant: 33),
        ].forEach{$0.isActive = true}
    }
    
    private func descriptionPart() {
        
        let spaceBetweenTitleAndDescription: UIView = {
            let view = UIView()
            return view
        }()
        
        let stackDescription: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            return stack
        }()
        let spaceBetweenHeaderAndDescription = UIView()
        
        stackDescription.addArrangedSubview(spaceBetweenHeaderAndDescription)
        stackDescription.addArrangedSubview(titleDescriptionPodcast)
        stackDescription.addArrangedSubview(spaceBetweenTitleAndDescription)
        stackDescription.addArrangedSubview(descriptionPodcast)

        scrollViewContainer.addArrangedSubview(stackDescription)
        
        [
            spaceBetweenHeaderAndDescription.heightAnchor.constraint(equalToConstant: 40),
            spaceBetweenTitleAndDescription.heightAnchor.constraint(equalToConstant: 15),
        ].forEach{$0.isActive = true}
    }
    
}
