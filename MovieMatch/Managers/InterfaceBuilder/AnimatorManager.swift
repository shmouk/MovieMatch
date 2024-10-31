import UIKit

class AnimationManager {
    
    static func animateAlphaChange(view: UIView, targetAlpha: CGFloat) {
        UIView.animate(withDuration: 0.2, animations: {
            view.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                view.alpha = 1.0
            }
        }
    }
}


