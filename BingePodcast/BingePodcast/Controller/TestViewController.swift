//
//  TestViewController.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 17/06/2023.
//

import UIKit

class TestViewController: UIViewController {
    
    // MARK: - Var initialisation
    // Scroll View
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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        setupUI()
    }

    private func setupUI() {
        setupGenralView()
        setupScrollView()
    }

   
    let playerView: UIView = {
        let view = UIView()

        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 150 ).isActive = true
        view.backgroundColor = .red

        view.addSubview(stackViewGeneral)

        stackViewGeneral.translatesAutoresizingMaskIntoConstraints = false
        [
            stackViewGeneral.topAnchor.constraint(equalTo: view.topAnchor),
            stackViewGeneral.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackViewGeneral.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackViewGeneral.rightAnchor.constraint(equalTo: view.rightAnchor)
        ].forEach{ $0.isActive = true }
        
        // image view
        stackViewGeneral.addArrangedSubview(verticalStackImage)
        
        // title
        stackViewGeneral.addArrangedSubview(horizontalStackTitle)
    
        // subtitle
        stackViewGeneral.addArrangedSubview(horizontalStackSubtitle)
        
        // slider
        stackViewGeneral.addArrangedSubview(verticalStackSlider)
        
        // Time - time
        stackViewGeneral.addArrangedSubview(horizontalStackTime)
        
        // button
        stackViewGeneral.addArrangedSubview(horizontalStackButtonPlayer)
        
        return view
    }()

    let descriptionView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.backgroundColor = .blue
        
        let title = UILabel()
        let descritpion = UILabel()
        descritpion.numberOfLines = 4
        title.text = "Description"
        descritpion.text = """
            Cet été, A bientôt de te revoir accompagne les auditeur·ices avec le meilleur des quatre saisons ...
            """
        
        view.layer.cornerRadius = 20
        
        view.addSubview(title)
        view.addSubview(descritpion)

        title.translatesAutoresizingMaskIntoConstraints = false
        [
            title.topAnchor.constraint(equalTo: view.topAnchor),
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            title.rightAnchor.constraint(equalTo: view.rightAnchor)
        ].forEach{ $0.isActive = true }
        
        descritpion.translatesAutoresizingMaskIntoConstraints = false
        [
            descritpion.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
            descritpion.heightAnchor.constraint(equalToConstant: 70),
            descritpion.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descritpion.rightAnchor.constraint(equalTo: view.rightAnchor)
        ].forEach{ $0.isActive = true }

        return view
    }()

}

// MARK: - Static Var
private extension TestViewController {

    static var stackViewGeneral: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.backgroundColor = .gray
        return stack
    }()

    static var verticalStackImage: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        let imageView = UIImageView()
        stack.addArrangedSubview(imageView)
        stack.backgroundColor = .green
        return stack
    }()
    
    static var horizontalStackTitle: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .horizontal
        
        let title = UILabel()
        title.text = "A Bientot te revoir"
        
        let heartButton = UIButton()
        heartButton.frame.size = CGSize(width: 30, height: 30)
        heartButton.backgroundColor = .red
        
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(heartButton)
        return stack
    }()
    
    static var horizontalStackSubtitle: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .horizontal
        
        let subtitle = UILabel()
        subtitle.text = "Episode 112"
        
        let viewSpacer = UIView()
        viewSpacer.frame.size.width = 30
        
        stack.addArrangedSubview(subtitle)
        stack.addArrangedSubview(viewSpacer)
        return stack
    }()
    
    static var verticalStackSlider: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical

        let slider = UISlider()
        
        stack.addArrangedSubview(slider)
        return stack
    }()
    
    static var horizontalStackTime: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .horizontal
        
        let spendTime = UILabel()
        spendTime.text = "00:10"
        
        let totalTime = UILabel()
        totalTime.text = "09:48"

        stack.addArrangedSubview(spendTime)
        stack.addArrangedSubview(totalTime)
        return stack
    }()
    
    static var horizontalStackButtonPlayer: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        
        let seekLessButton = UIButton()
        let playPauseButton = UIButton()
        let seekMoreButton = UIButton()
        
        seekLessButton.frame.size = CGSize(width: 50, height: 50)
        seekMoreButton.frame.size = CGSize(width: 50, height: 50)
        playPauseButton.frame.size = CGSize(width: 70, height: 70)
        
        stack.addArrangedSubview(seekLessButton)
        stack.addArrangedSubview(playPauseButton)
        stack.addArrangedSubview(seekMoreButton)
        
        seekLessButton.backgroundColor = .red
        playPauseButton.backgroundColor = .blue
        seekMoreButton.backgroundColor = .green

        return stack
    }()
    
}

// MARK: - SetUp UI
private extension TestViewController {
    
    
    private func setupGenralView() {
        // Add here gradient
        view.backgroundColor = .lightGray
    }
    
    private func setupScrollView() {

        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(playerView)
        scrollViewContainer.addArrangedSubview(descriptionView)

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -40).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
}

// Action
private extension TestViewController {
    
    func actionSliderValueChanged() {
        print("@@@ slider call change")
    }
    
    func actionPressFavoriteButton() {
        print("@@@ click favorite")
    }
    
    func actionPressMoinsSeekButton() {
        print("@@@ click moins seed")
    }
    
    func actionPressPlayPauseButton() {
        print("@@@ click play pause")
    }
    
    func actionPressPlusSeekButton() {
        print("@@@ click plus seed")
    }
}
