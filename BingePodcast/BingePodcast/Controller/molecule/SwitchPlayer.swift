//
//  switchPlayer.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 04/07/2023.
//

import Foundation
import UIKit

class SwitchPlayer: UIView {

    var view = UIView()
    let viewBase = UIView()
    let imageRond = UIImageView()
    let playerOnImage = UIImageView()
    let text = UIStackView()
    let title = UILabel()
    let line = UIView()
    let subtitle = UILabel()
    let containerImageRond = UIView()
    let innerShadowTop = CALayer()

    var isActive: Bool = false

    func active() {
        if isActive {
            UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut]) {
                self.containerImageRond.frame.origin.x += UIScreen.main.bounds.width - 70 - 107
                self.text.frame.origin.x -= 70
                self.playerOnImage.image = Assets.Picto.pause.image
                
            }
            self.innerShadowTop.isHidden = true
        } else {
            UIView.animate(withDuration: 0.5) {
                self.containerImageRond.frame.origin.x -= UIScreen.main.bounds.width - 70 - 107
                self.text.frame.origin.x += 70
                self.playerOnImage.image = Assets.Picto.play.image
                self.innerShadowTop.isHidden = false
            }
        }
        
    }
    override func layoutSubviews() {
        applyDesign()
    }
    
    func initSwitch(/*view: UIView*/) {

        // self.view = view
        
        backgroundColor = .white
        layer.cornerRadius = 50
        
        
        // Image Podcast
        imageRond.image = Assets.aBientotDeTeRevoir.image
        imageRond.translatesAutoresizingMaskIntoConstraints = false


         
        addSubview(containerImageRond)
        containerImageRond.translatesAutoresizingMaskIntoConstraints = false
        [
            containerImageRond.widthAnchor.constraint(equalToConstant: 90),
            containerImageRond.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            containerImageRond.heightAnchor.constraint(equalToConstant: 90),
            containerImageRond.topAnchor.constraint(equalTo: topAnchor, constant: 7)
        ].forEach{$0.isActive = true}
        
        containerImageRond.layer.shadowColor = UIColor.black.cgColor
        containerImageRond.layer.shadowOpacity = 0.4
        containerImageRond.layer.shadowOffset = .zero
        containerImageRond.layer.shadowRadius = 6
        
        containerImageRond.addSubview(imageRond)
        
        imageRond.layer.masksToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        containerImageRond.isUserInteractionEnabled = true
        containerImageRond.addGestureRecognizer(tapGestureRecognizer)
        
        containerImageRond.layer.zPosition = 1
        imageRond.layer.zPosition = 1

        imageRond.translatesAutoresizingMaskIntoConstraints = false
        imageRond.layer.cornerRadius = 45
        

        [
            imageRond.widthAnchor.constraint(equalToConstant: 90),
            imageRond.leftAnchor.constraint(equalTo: containerImageRond.leftAnchor, constant: 0),
            imageRond.heightAnchor.constraint(equalToConstant: 90),
            imageRond.topAnchor.constraint(equalTo: containerImageRond.topAnchor, constant: 0)
        ].forEach{$0.isActive = true}

        // Image player
        
        
        playerOnImage.image = Assets.Picto.play.image
        imageRond.addSubview(playerOnImage)

        playerOnImage.translatesAutoresizingMaskIntoConstraints = false
        [
            playerOnImage.widthAnchor.constraint(equalToConstant: 30),
            playerOnImage.centerXAnchor.constraint(equalTo: imageRond.centerXAnchor),
            playerOnImage.heightAnchor.constraint(equalToConstant: 30),
            playerOnImage.centerYAnchor.constraint(equalTo: imageRond.centerYAnchor),
        ].forEach{$0.isActive = true}
 
        
        text.backgroundColor = .clear
        text.axis = .vertical
        text.distribution = .fill
        text.alignment = .fill

        title.text = "EPISODE 82"
        title.frame.size.height = 20
        title.font = UIFont(name: .fonts.proximaNova_Thin.fontName(), size: 19)
        title.textColor = Colors.darkBlue.color

        line.frame.size.height = 3
        line.backgroundColor = Colors.darkBlue.color

       
        subtitle.text = "Cuisines indiennes, clichés en sauce"
        subtitle.font = UIFont(name: .fonts.proximaNova_Thin.fontName(), size: 14)
        subtitle.textColor = Colors.darkBlue.color
        subtitle.numberOfLines = 2

        text.addArrangedSubview(title)
        text.addArrangedSubview(line)
        text.addArrangedSubview(subtitle)

        text.translatesAutoresizingMaskIntoConstraints = false

        addSubview(text)
        
        [
            text.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            text.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            text.leftAnchor.constraint(equalTo: leftAnchor, constant: 105),
            text.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            line.heightAnchor.constraint(equalToConstant: 1),
            title.heightAnchor.constraint(equalToConstant: 30)
        ].forEach{$0.isActive = true}
     
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("@@@ tapGestureRecognizer = \(tapGestureRecognizer)")
        let tappedImage = tapGestureRecognizer.view
        print("@@@ tapped Image = \(tappedImage)")
        isActive.toggle()
        active()
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func applyDesign() {
        
        
        

        innerShadowTop.frame = bounds

        // Shadow path (1pt ring around bounds)
        let radius = frame.size.height/2

        let path = UIBezierPath(roundedRect: innerShadowTop.bounds.insetBy(dx: -3, dy: -3), cornerRadius:radius)
        let cutout = UIBezierPath(roundedRect: innerShadowTop.bounds, cornerRadius:radius).reversing()

        

        path.append(cutout)
        innerShadowTop.shadowPath = path.cgPath
        innerShadowTop.masksToBounds = true
        
        // Shadow properties
        innerShadowTop.shadowColor = UIColor.black.cgColor
        innerShadowTop.shadowOffset = CGSize(width: 1, height: 4)
        innerShadowTop.shadowOpacity = 0.8
        innerShadowTop.shadowRadius = 4
        innerShadowTop.cornerRadius = radius
        layer.addSublayer(innerShadowTop)
    }
    
}
