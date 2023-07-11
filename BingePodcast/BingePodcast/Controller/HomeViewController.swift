
import UIKit

class HomeViewController: UIViewController {
  
    let molecule = SwitchPlayer(title: "EPISODE 78", subtitle: "Cuisines indiennes, clichés en sauce, et ça pique", imageString: Assets.aBientotDeTeRevoir.name)
    let molecule2 = SwitchPlayer(title: "EPISODE 90", subtitle: "Cuisines indiennes", imageString: Assets.aBientotDeTeRevoir.name)

 
 //   let test = SlideToActionButton(title: "EPISODE 78", subtitle: "Cuisines indiennes, clichés en sauce, et ça pique", imageString: Assets.aBientotDeTeRevoir.name)

    override func viewDidLoad() {
        super.viewDidLoad()
/*
        view.backgroundColor = .lightGray
        view.addSubview(test)
        test.translatesAutoresizingMaskIntoConstraints = false
        [
            test.widthAnchor.constraint(equalToConstant: view.frame.width - 70),
            test.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            test.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            test.heightAnchor.constraint(equalToConstant: 102),
            test.topAnchor.constraint(equalTo: view.topAnchor, constant: 300)
        ].forEach{$0.isActive = true}
*/
    
    let image = Assets.logo.image
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        [
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 260)
        ].forEach{$0.isActive = true}

        view.addSubview(molecule)
        molecule.translatesAutoresizingMaskIntoConstraints = false
        [
            molecule.widthAnchor.constraint(equalToConstant: view.frame.width - 70),
            molecule.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            molecule.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            molecule.heightAnchor.constraint(equalToConstant: 102),
            molecule.topAnchor.constraint(equalTo: view.topAnchor, constant: 300)
        ].forEach{$0.isActive = true}

        view.addSubview(molecule2)
        molecule2.translatesAutoresizingMaskIntoConstraints = false
        [
            molecule2.widthAnchor.constraint(equalToConstant: view.frame.width - 70),
            molecule2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            molecule2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            molecule2.heightAnchor.constraint(equalToConstant: 102),
            molecule2.topAnchor.constraint(equalTo: view.topAnchor, constant: 450)
        ].forEach{$0.isActive = true}

        setGradientBackground()

    }
    
    func setGradientBackground() {
        let colorTop = Colors.ligthBlue.color.cgColor
        let colorBottom = Colors.white.color.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    // Top image
    
    // molécule swipe 1
    
    // molécule swipe 2
    
    // collection view "Nos podcasts"

    private func toggleSelectedSwitchPlayer() {
        
    }

}

