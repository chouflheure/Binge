import UIKit

class CustomField: UIView {
    
    var viewTest = UIView()

    func initTest(view: UIView) {
        self.viewTest = view
        
    }

    override func layoutSubviews() {
        // super.layoutSubviews()
        // viewTest.layoutSubviews()
        applyDesign()
    }


    func applyDesign() {
    
        let innerShadow = CALayer()
        
        print("@@@ viewTest frame = \(viewTest.frame)")
        print("@@@ viewTest bounds = \(viewTest.bounds)")

        innerShadow.frame = viewTest.bounds

        // Shadow path (1pt ring around bounds)
        let radius = self.frame.size.height/2

        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -1, dy:-1), cornerRadius:radius)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius:radius).reversing()


        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        // Shadow properties
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 2)
        innerShadow.shadowOpacity = 0.8
        innerShadow.shadowRadius = 2
        innerShadow.cornerRadius = self.frame.size.height/2
        viewTest.layer.addSublayer(innerShadow)
    }
}
