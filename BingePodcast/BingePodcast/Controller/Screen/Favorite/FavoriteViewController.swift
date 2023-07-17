
import UIKit


enum Pages: CaseIterable {
    case pageZero
    case pageOne
    
    var name: String {
        switch self {
        case .pageZero:
            return "This is page zero"
        case .pageOne:
            return "This is page two"
        }
    }
    
    var index: Int {
        switch self {
        case .pageZero:
            return 0
        case .pageOne:
            return 1
  
        }
    }
}

class FavoriteViewController: UIViewController {
    
    private var pageController: UIPageViewController?
    private var pages = Pages.allCases
    private var currentIndex: Int = 0
    private var leftContainer: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupTitlePageViewController()
        setupPageController()
        setGradientBackground()
    }
    
    private func nextPagePoint() {
        seeLaterTitle.adjustsFontSizeToFitWidth = true
        favoriteTitle.adjustsFontSizeToFitWidth = true
        
        if currentIndex == 0 {
            seeLaterTitle.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 24)
            favoriteTitle.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 24)
            UIView.animate(withDuration: 0.3) {
                self.leftContainer!.constant += UIScreen.main.bounds.width - (self.favoriteTitle.intrinsicContentSize.width / 2) - (self.seeLaterTitle.intrinsicContentSize.width / 2) - 80
                self.view.layoutIfNeeded() // Assurez-vous d'appeler cette méthode pour mettre à jour l'affichage.
            }
            currentIndex += 1
        }
    }
    
    private func previousPagePoint() {
        if currentIndex == 1 {
            seeLaterTitle.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 24)
            favoriteTitle.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 24)
           
            UIView.animate(withDuration: 0.3) {
                self.leftContainer!.constant -= UIScreen.main.bounds.width - (self.favoriteTitle.intrinsicContentSize.width / 2) - (self.seeLaterTitle.intrinsicContentSize.width / 2) - 80
                self.view.layoutIfNeeded() // Assurez-vous d'appeler cette méthode pour mettre à jour l'affichage.
            }
            currentIndex -= 1
        }
    }
    
    @objc private func nextPageController() {
        guard let pageController = pageController else {return}
        pageController.setViewControllers([PageList(with: pages[1])], direction: .forward, animated: true, completion: nil)
        nextPagePoint()
    }
    
    @objc private func previousPageController() {

        guard let pageController = pageController else {return}
        pageController.setViewControllers([PageList(with: pages[0])], direction: .reverse, animated: true, completion: nil)
        previousPagePoint()
    }
    
    let favoriteTitle : UILabel = {
        let label = UILabel()
        label.text = L10n.favorite
        label.font = UIFont(name: .fonts.proximaNova_Bold.fontName(), size: 24)
        label.textColor = Colors.darkBlue.color
        return label
    }()
    
    let seeLaterTitle : UILabel = {
        let label = UILabel()
        label.text = L10n.seeLater
        label.font = UIFont(name: .fonts.proximaNova_Regular.fontName(), size: 24)
        label.textColor = Colors.darkBlue.color
        return label
    }()
    
    let line : UIView = {
        let line = UIView()
        line.backgroundColor = Colors.yellow.color
        line.layer.cornerRadius = 2
        return line
    }()
    
    private func setupTitlePageViewController() {

        view.addSubview(favoriteTitle)
        view.addSubview(seeLaterTitle)
        view.addSubview(line)

        favoriteTitle.translatesAutoresizingMaskIntoConstraints = false
        seeLaterTitle.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false

        leftContainer = line.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40)
        
        favoriteTitle.isUserInteractionEnabled = true
        seeLaterTitle.isUserInteractionEnabled = true

        [
            leftContainer!,
            favoriteTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            favoriteTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            seeLaterTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            seeLaterTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            line.topAnchor.constraint(equalTo: favoriteTitle.bottomAnchor, constant: 5),
            line.widthAnchor.constraint(equalToConstant: favoriteTitle.intrinsicContentSize.width),
            line.heightAnchor.constraint(equalToConstant: 2),
            line.centerXAnchor.constraint(equalTo: favoriteTitle.centerXAnchor)

        ].forEach{$0.isActive = true}
        
        let tapFavorite = UITapGestureRecognizer(target: self, action: #selector(self.previousPageController))
        favoriteTitle.addGestureRecognizer(tapFavorite)
        
        let tapSeeLater = UITapGestureRecognizer(target: self, action: #selector(self.nextPageController))
        seeLaterTitle.addGestureRecognizer(tapSeeLater)
        
    }
    
    
    private func setGradientBackground() {
        let colorTop = Colors.ligthBlue.color.cgColor
        let colorBottom = Colors.white.color.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    
    private func setupPageController() {
        
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        // nil dataSource to disable the swipe gesture on PageController
        self.pageController?.dataSource = nil
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .clear

        self.pageController?.view.frame = CGRect(
            x: 0,
            y: 120,
            width: self.view.frame.width,
            height: self.view.frame.height - 120
        )
        
        self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        
        let initialVC = PageList(with: pages[0])
        
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        
        self.pageController?.didMove(toParent: self)
    }
    
}

extension FavoriteViewController: UIPageViewControllerDelegate {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}



























