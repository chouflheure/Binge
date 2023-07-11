//import UIKit
//
//protocol SlideToActionButtonDelegate: AnyObject {
//    func didFinish()
//}
//
//class SwitchPlayer: UIView {
//    
//    let innerShadowTop = CALayer()
//    var title = String()
//    var subtitle = String()
//    var imageString = String()
//
//    private var leftContainerImageCircleViewConstraint: NSLayoutConstraint?
//    private var leftTextStackViewConstraint: NSLayoutConstraint?
//    private var leftTextMinConstrait: CGFloat = 25
//    private var leftTextMaxConstrait: CGFloat = 105
//    
//    weak var delegate: SlideToActionButtonDelegate?
//    
//    private var xEndingPoint: CGFloat {
//        return (bounds.width - containerCircleImage.bounds.width - 7)
//    }
//    
//    private var isFinished = false
//    
//    required init(title: String, subtitle: String, imageString: String) {
//        super.init(frame: .zero)
//        self.title = title
//        self.subtitle = subtitle
//        self.title = title
//        self.imageString = imageString
//        setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        applyDesign()
//    }
//    
//    func applyDesign() {
//        
//        innerShadowTop.frame = bounds
//        let radius = frame.size.height/2
//        let path = UIBezierPath(roundedRect: innerShadowTop.bounds.insetBy(dx: -3, dy: -3), cornerRadius: radius)
//        let cutout = UIBezierPath(roundedRect: innerShadowTop.bounds, cornerRadius: radius).reversing()
//        path.append(cutout)
//        innerShadowTop.shadowPath = path.cgPath
//        innerShadowTop.masksToBounds = true
//        
//        // Shadow properties
//        innerShadowTop.shadowColor = UIColor.black.cgColor
//        innerShadowTop.shadowOffset = CGSize(width: 1, height: 4)
//        innerShadowTop.shadowOpacity = 0.8
//        innerShadowTop.shadowRadius = 4
//        innerShadowTop.cornerRadius = radius
//        layer.addSublayer(innerShadowTop)
//    }
//
//    let containerCircleImage: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOpacity = 0.4
//        view.layer.shadowOffset = .zero
//        view.layer.shadowRadius = 6
//        view.layer.zPosition = 1
//        return view
//    }()
//
//    let imageCircle: UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.layer.masksToBounds = true
//        image.layer.cornerRadius = 45
//        image.layer.zPosition = 1
//        return image
//    }()
//    
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.frame.size.height = 20
//        label.font = UIFont(name: .fonts.proximaNova_Thin.fontName(), size: 19)
//        label.textColor = Colors.darkBlue.color
//        return label
//    }()
//    
//    let lineSeperator: UIView = {
//        let line = UIView()
//        line.translatesAutoresizingMaskIntoConstraints = false
//        line.frame.size.height = 3
//        line.backgroundColor = Colors.darkBlue.color
//        return line
//    }()
//    
//    let subtitleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: .fonts.proximaNova_Thin.fontName(), size: 14)
//        label.textColor = Colors.darkBlue.color
//        label.numberOfLines = 2
//        return label
//    }()
//    
//    let textStack: UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.backgroundColor = .clear
//        stack.axis = .vertical
//        stack.distribution = .fill
//        stack.alignment = .fill
//        return stack
//    }()
//
//    func setup() {
//        backgroundColor = .white
//        layer.cornerRadius = 50
//        
//        // Add view :
//        titleLabel.text = title
//        subtitleLabel.text = subtitle
//        imageCircle.image = UIImage(named: imageString)
//        
//        addSubview(containerCircleImage)
//        containerCircleImage.addSubview(imageCircle)
//        addSubview(textStack)
//        
//        textStack.addArrangedSubview(titleLabel)
//        textStack.addArrangedSubview(lineSeperator)
//        textStack.addArrangedSubview(subtitleLabel)
//
//        // handleView.addSubview(handleViewImage)
//        
//        //MARK: - Constraints
//        
//        leftContainerImageCircleViewConstraint = containerCircleImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 7)
//        leftTextStackViewConstraint = textStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 105)
//        print("@@@ bounds.width = \(bounds.width)")
//        print("@@@ frame.size.width = \(frame.size.width)")
//        print("@@@ = \(self.widthAnchor)")
//        
//        NSLayoutConstraint.activate([
//            leftContainerImageCircleViewConstraint!,
//            containerCircleImage.topAnchor.constraint(equalTo: topAnchor, constant: 7),
//            containerCircleImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 7),
//            containerCircleImage.widthAnchor.constraint(equalToConstant: 90),
//            imageCircle.widthAnchor.constraint(equalToConstant: 90),
//            imageCircle.leftAnchor.constraint(equalTo: containerCircleImage.leftAnchor, constant: 0),
//            imageCircle.heightAnchor.constraint(equalToConstant: 90),
//            imageCircle.topAnchor.constraint(equalTo: containerCircleImage.topAnchor, constant: 0),
//            // playerOnImage.widthAnchor.constraint(equalToConstant: 30),
//            // playerOnImage.centerXAnchor.constraint(equalTo: imageCircle.centerXAnchor),
//            // playerOnImage.heightAnchor.constraint(equalToConstant: 30),
//            // playerOnImage.centerYAnchor.constraint(equalTo: imageRond.centerYAnchor),
//            textStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            textStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
//            textStack.widthAnchor.constraint(equalTo: widthAnchor, constant: -130),
//            leftTextStackViewConstraint!,
//            lineSeperator.heightAnchor.constraint(equalToConstant: 1),
//            titleLabel.heightAnchor.constraint(equalToConstant: 30)
//        ])
//
//        // Swipe gesture
//        let panGestureRecognizer = UIPanGestureRecognizer(
//            target: self,
//            action: #selector(self.handlePanGesture(_:))
//        )
//        panGestureRecognizer.minimumNumberOfTouches = 1
//        containerCircleImage.addGestureRecognizer(panGestureRecognizer)
//        
//        // Tap gesture
//        let tapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(imageTapped(tapGestureRecognizer:))
//        )
//        
//        containerCircleImage.isUserInteractionEnabled = true
//        containerCircleImage.addGestureRecognizer(tapGestureRecognizer)
//    }
//
//    private func updateContainerImageCircleXPosition(_ x: CGFloat) {
//        leftContainerImageCircleViewConstraint?.constant = x
//    }
//
//    private func updateTextSkatXPosition(_ x: CGFloat) {
//        leftTextStackViewConstraint?.constant = x
//    }
//
//    func reset() {
//        isFinished = false
//        updateContainerImageCircleXPosition(7)
//    }
//
//    func active() {
//        if isFinished {
//            UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut]) {
//                self.updateTextSkatXPosition(self.leftTextMinConstrait)
//                self.updateContainerImageCircleXPosition(self.xEndingPoint)
//                self.titleLabel.font = UIFont(name: .fonts.proximaNova_Alt_Bold.fontName(), size: 19)
//                self.subtitleLabel.font = UIFont(name: .fonts.proximaNova_Alt_Bold.fontName(), size: 14)
//            }
//            self.innerShadowTop.isHidden = true
//        } else {
//            UIView.animate(withDuration: 1) {
//                self.updateTextSkatXPosition(self.leftTextMaxConstrait)
//                self.innerShadowTop.isHidden = false
//                self.titleLabel.font = UIFont(name: .fonts.proximaNova_Thin.fontName(), size: 19)
//                self.subtitleLabel.font = UIFont(name: .fonts.proximaNova_Thin.fontName(), size: 14)
//            }
//            reset()
//        }
//    }
//}
//
//extension SlideToActionButton {
//
//    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
//        isFinished.toggle()
//        active()
//    }
//
//    @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
//        if isFinished { return }
//        let translatedPoint = sender.translation(in: self).x
//
//        switch sender.state {
//        case .changed:
//
//            if translatedPoint <= 7 {
//                updateContainerImageCircleXPosition(7)
//            } else if translatedPoint >= xEndingPoint {
//                updateContainerImageCircleXPosition(xEndingPoint)
//            } else {
//                updateContainerImageCircleXPosition(translatedPoint)
//                if translatedPoint > 30 {
//                    self.textStack.isHidden = true
//                }
//            }
//        case .ended:
//            self.textStack.isHidden = false
//            if translatedPoint >= xEndingPoint {
//                self.updateContainerImageCircleXPosition(xEndingPoint)
//                isFinished = true
//                delegate?.didFinish()
//                active()
//            } else {
//                UIView.animate(withDuration: 1) {
//                    self.reset()
//                }
//            }
//        default:
//            break
//        }
//    }
//}
