
import UIKit

let pi = CGFloat.pi
let pi2 = CGFloat.pi / 2

extension CGFloat {
    public func toRadians() -> CGFloat {
        return self * CGFloat.pi / 180.0
    }
}

class FloatingTabBarViewController: UITabBar {

    private var barBackColor : UIColor = .white.withAlphaComponent(0.5)
    private var barHeight : CGFloat = 65
    private var barTopRadius : CGFloat = 27
    private var barBottomRadius : CGFloat = 27
    private var circleBackColor : UIColor = .white
    private var circleRadius : CGFloat = 40
    private var marginBottom : CGFloat = 20
    private var marginTop : CGFloat = 70
    private let marginLeft : CGFloat = 15
    private let marginRight : CGFloat = 15
    private let pitCornerRad : CGFloat = 0
    private let pitCircleDistanceOffset : CGFloat = 0

    private var barRect : CGRect{
        get{
            let h = self.barHeight
            let w = bounds.width - (marginLeft + marginRight)
            let x = bounds.minX + marginLeft
            let y = marginTop
            
            let rect = CGRect(x: x, y: y, width: w, height: h)
            return rect
        }
    }
    
    private func createCircleRect() -> CGRect{

        let backRect = barRect
        let radius = circleRadius
        let circleXCenter = getCircleCenter()
        let x : CGFloat = circleXCenter - radius + 15
        let y = backRect.origin.y - radius + 25
        let pos = CGPoint(x: x, y: y)
        let result = CGRect(origin: pos, size: CGSize(width: radius * 2 - 30, height: radius * 2 - 30))
        
        return result
    }
    
    private func createCirclePath() -> CGPath{
        let circleRect = createCircleRect()
        let result = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.height / 2);
        
        return result.cgPath
    }
    
    private func getCircleCenter() -> CGFloat{
        let totalWidth = self.bounds.width
        var x = totalWidth / 2
        if let v = getViewForItem(item: self.selectedItem){
            x = v.frame.minX + (v.frame.width / 2)
        }
        return x
    }

    private func createPitMaskPath(rect: CGRect) -> CGMutablePath {
        // create the tab bar
        let maskPath = CGMutablePath()
        maskPath.addRect(rect)
        return maskPath
    }

    private func createBackgroundPath() -> CGPath{
        let rect = barRect
        let topLeftRadius = self.barTopRadius
        let topRightRadius = self.barTopRadius
        let bottomRigtRadius = self.barBottomRadius
        let bottomLeftRadius = self.barBottomRadius
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - topLeftRadius, y: rect.minY))
        path.addArc(withCenter: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius), radius: topRightRadius, startAngle:3 * pi2, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRigtRadius))
        path.addArc(withCenter: CGPoint(x: rect.maxX - bottomRigtRadius, y: rect.maxY - bottomRigtRadius), radius: bottomRigtRadius, startAngle: 0, endAngle: pi2, clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX + bottomRigtRadius, y: rect.maxY))
        path.addArc(withCenter: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius), radius: bottomLeftRadius, startAngle: pi2, endAngle: pi, clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        path.addArc(withCenter: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius), radius: topLeftRadius, startAngle: pi, endAngle: 3 * pi2, clockwise: true)
        path.close()
        return path.cgPath
    }
    
    private lazy var background: CAShapeLayer = {
        let result = CAShapeLayer()
        result.fillColor = self.barBackColor.cgColor
        result.mask = self.backgroundMask
        return result
    }()
    
    private lazy var circle : CAShapeLayer = {
        let result = CAShapeLayer()
        result.fillColor = circleBackColor.cgColor
        result.strokeColor = Colors.yellow.color.cgColor
        result.lineWidth = 2
        return result
    }()
    
    private lazy var backgroundMask : CAShapeLayer = {
        let result = CAShapeLayer()
        result.fillRule = CAShapeLayerFillRule.evenOdd
        return result
    }()

    // Tab bar size
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = self.barHeight + marginTop + marginBottom
        return sizeThatFits
    }
    
    private func getTabBarItemViews() -> [(item : UITabBarItem, view : UIView)]{
        guard let items = self.items else{
            return[]
        }

        var result : [(item : UITabBarItem, view : UIView)] = []
        for item in items {
            item.image = item.image?.withRenderingMode(.alwaysOriginal)
            if let v = getViewForItem(item: item) {
                result.append((item: item, view: v))
            }
        }
        return result
    }
    
    private func getViewForItem(item : UITabBarItem?) -> UIView?{
        if let item = item {
            let v = item.value(forKey: "view") as? UIView
            return v
        }
        return nil
    }
    
    private func positionItem(barRect : CGRect, totalCount : Int, idx : Int, item : UITabBarItem, view : UIView){
        let margin : CGFloat = 5
        let x = view.frame.origin.x
        var y = barRect.origin.y + margin
        var h = barHeight - (margin * 3)
        let w = view.frame.width
        if self.selectedItem == item {
            h = 83
            y = barRect.origin.y - (self.circleRadius) + 13
        }
        view.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    private func animateHideAndShowItem(itemView : UIView){
        itemView.alpha = 1
        itemView.isHidden = false

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(200) , execute: {
            UIView.animate(withDuration: 0.5) {
                itemView.alpha = 1
            }
        })

    }

    private func createPathMoveAnimation(toVal: CGPath) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 1
        animation.toValue = toVal
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        return animation
    }
    
    private func replaceAnimation(layer: CAShapeLayer, withNew: CABasicAnimation, forKey: String){
        let existing = layer.animation(forKey: forKey) as? CABasicAnimation
        if existing != nil{
            withNew.fromValue = existing!.toValue
        }

        layer.removeAnimation(forKey: forKey)
        layer.add(withNew, forKey: forKey)
    }
    
    private func moveCircleAnimated(){
        let circleNewPath = self.createCirclePath()
        let circleAni = createPathMoveAnimation(toVal: circleNewPath)
        self.replaceAnimation(layer: circle, withNew: circleAni, forKey: "move_animation")
    }
    
    private func layoutElements(selectedChanged : Bool){
        self.background.path = self.createBackgroundPath()
        if self.backgroundMask.path == nil {
            self.backgroundMask.path = self.createPitMaskPath(rect: self.bounds)
            self.circle.path = self.createCirclePath()
        }
        else{
            moveCircleAnimated()
        }
        
        let items = getTabBarItemViews()
        if items.count <= 0 {
            return
        }
        
        let barR = barRect
        let total = items.count
        for (idx, item) in items.enumerated() {
            if selectedChanged {
                self.animateHideAndShowItem(itemView: item.view)
            }
            self.positionItem(barRect: barR, totalCount: total, idx: idx, item: item.item, view: item.view)
        }
    }

    override var selectedItem: UITabBarItem? {
        get{
            return super.selectedItem
        }
        set{
            let changed = (super.selectedItem != newValue)
            super.selectedItem = newValue
            if changed {
                layoutElements(selectedChanged: changed)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        background.fillColor = self.barBackColor.cgColor
        circle.backgroundColor = self.circleBackColor.cgColor
        circle.borderColor = Colors.yellow.color.cgColor

        self.layoutElements(selectedChanged: false)
    }
    
    private func shadow() {
        background.cornerRadius = 40
        background.shadowRadius = 3
        background.shadowOffset = CGSize(width: 0, height: -2)
        background.shadowOpacity = 0.4
        background.shadowColor = UIColor.black.cgColor
        
        viewTest.layer.cornerRadius = 40
        viewTest.layer.shadowRadius = 3
        viewTest.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewTest.layer.shadowOpacity = 0.2
        viewTest.layer.shadowColor = UIColor.black.cgColor
    }
    
    private func blur() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = CGRect(x: self.background.frame.origin.x + marginLeft, y: self.background.frame.origin.y , width: UIScreen.main.bounds.width - (marginLeft + marginRight), height: 130 )

        blurEffectView.layer.cornerRadius = barTopRadius
        blurEffectView.clipsToBounds = true
        blurEffectView.alpha = 1
        self.insertSubview(blurEffectView, at: 0)
        blurEffectView.effect = blurEffect
    }
    
    private func setUpTitleColor() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.darkBlue.color], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.lightBlueTabBar.color], for: .normal)
    }
    let viewTest = UIView()

    private func setup(){

        viewTest.frame = CGRect(x: self.background.frame.origin.x + marginLeft, y: self.background.frame.origin.y , width: UIScreen.main.bounds.width - (marginLeft + marginRight), height: 130 )
        viewTest.backgroundColor = .white.withAlphaComponent(0.5)
        viewTest.layer.cornerRadius = barTopRadius
        // self.addSubview(viewTest)
        
        self.isTranslucent = true
        self.backgroundColor = UIColor.clear
        self.backgroundImage = UIImage()
        self.shadowImage = UIImage()

        self.layer.frame.size.height = 0
        self.layer.insertSublayer(circle, at: 0)
        self.layer.insertSublayer(background, at: 0)

        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:))
        )
        
        viewTest.isUserInteractionEnabled = true
        viewTest.addGestureRecognizer(tapGestureRecognizer)
        
        
        self.tintColor = Colors.darkBlue.color

        shadow()
        blur()
        setUpTitleColor()
    }
 
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        print("@@@ click")
        viewTest.frame = CGRect(x: self.background.frame.origin.x + marginLeft, y: self.background.frame.origin.y + barHeight, width: UIScreen.main.bounds.width - (marginLeft + marginRight), height: 10 )
    }
    
    private func playerView() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
