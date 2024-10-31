import UIKit

class CustomizedTabBar: UITabBar {
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAppearance()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = .none
        shapeLayer.fillColor = ColorForUI.fgLight.color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.shadowColor = ColorForUI.fg.color.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: -4);
        shapeLayer.shadowOpacity = 0.2
        shapeLayer.shadowRadius = 6
        shapeLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: Constants.radii).cgPath
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: Constants.radii, height: .zero))
        
        return path.cgPath
    }
    
    private func setupAppearance() {
        self.isTranslucent = true
        barTintColor = .white
    }
}
