//
//  HomeViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 03/07/2023.
//

/*
 let closeButton = CloseButton(action: { [weak self] in
     self?.closeButtonAction()
 })
 
 
 
 class CloseButton: UIButton {

     private let action: () -> Void

     init(action: @escaping () -> Void) {
         self.action = action
         super.init(frame: .zero)
         setup()
     }

     @available(*, unavailable)
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

 }


 // MARK: - Setup

 private extension CloseButton {

     func setup() {
         addTarget(self, action: #selector(didTap), for: .touchUpInside)
         let image = Assets.crossButton.image
         accessibilityLabel = Strings.SportSkin.Accessibility.close

         setBackgroundImage(image, for: .normal)
         clipsToBounds = true
         heightAnchor.constraint(equalToConstant: Constant.heightAnchor).isActive = true
         widthAnchor.constraint(equalToConstant: Constant.widthAnchor).isActive = true
     }

     @objc private func didTap() {
         action()
     }

 }
 
 */


import UIKit

class HomeViewController: UIViewController {
  
    let molecule = SwitchPlayer()
    let molecule2 = SwitchPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

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
        molecule.initSwitch(view: molecule)
        
        view.addSubview(molecule2)
        molecule2.translatesAutoresizingMaskIntoConstraints = false
        [
            molecule2.widthAnchor.constraint(equalToConstant: view.frame.width - 70),
            molecule2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            molecule2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            molecule2.heightAnchor.constraint(equalToConstant: 102),
            molecule2.topAnchor.constraint(equalTo: view.topAnchor, constant: 450)
        ].forEach{$0.isActive = true}
        molecule2.initSwitch(view: molecule2)
         
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

