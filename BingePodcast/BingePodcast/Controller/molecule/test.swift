import UIKit

class InnerShadowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        let shadowColor = UIColor.black
        let shadowOffset = CGSize(width: 0, height: 0)
        let shadowBlurRadius: CGFloat = 10.0

        context.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color: shadowColor.cgColor)

        let contentRect = bounds.insetBy(dx: shadowBlurRadius, dy: shadowBlurRadius)
        let path = UIBezierPath(rect: contentRect)
        path.addClip()

        // Dessinez le contenu de votre vue ici
        // Par exemple, dessinez un rectangle rouge à l'intérieur du chemin clip

        UIColor.red.setFill()
        path.fill()
    }
}


class CustomField: UIView {

    lazy var innerShadow: CALayer = {
        let innerShadow = CALayer()
        layer.addSublayer(innerShadow)
        return innerShadow
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        applyDesign()
    }

    func applyDesign() {
        innerShadow.frame = bounds

        // Shadow path (1pt ring around bounds)
        let radius = self.frame.size.height/2
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -1, dy:-1), cornerRadius:radius)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius:radius).reversing()


        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        // Shadow properties
        innerShadow.shadowColor = UIColor.darkGray.cgColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 2)
        innerShadow.shadowOpacity = 0.5
        innerShadow.shadowRadius = 2
        innerShadow.cornerRadius = self.frame.size.height/2
    }
}
