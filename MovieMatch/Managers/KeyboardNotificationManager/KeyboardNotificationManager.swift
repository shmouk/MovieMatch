import UIKit

class KeyboardManager {
    private var view: UIView?
    
    init(view: UIView) {
        self.view = view
    }
    
    func startObservingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func stopObservingKeyboard() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc 
    private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
        
        UIView.animate(withDuration: duration) {
            self.view?.frame.origin.y = -3/4 * keyboardHeight
        }
    }
    
    @objc 
    private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
        
        UIView.animate(withDuration: duration) {
            self.view?.frame.origin.y = 0
        }
    }
}
