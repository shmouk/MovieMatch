import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: Constants.radii, height: Constants.radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
//        layer.borderColor = UIColor(named: "FgColorLight")?.cgColor
//        layer.borderWidth = 2.0
        layer.cornerRadius = Constants.radii
        layer.masksToBounds = true
        layoutIfNeeded()
    }
}

extension UIImageView {
    func addShadow(offset: CGSize = CGSize(width: 0, height: 0),
                   radius: CGFloat = 20,
                   color: UIColor = ColorForUI.fg.color,
                   opacity: Float = 0.8) {
        
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
        layer.cornerRadius = frame.height / 2
    }
}



