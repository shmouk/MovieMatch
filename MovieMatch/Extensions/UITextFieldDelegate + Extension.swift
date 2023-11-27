import UIKit

extension UITextFieldDelegate {
    func isStartsWithEmptyLine(_ textField: UITextField, _ range: NSRange, _ string: String) -> Bool {
        guard let currentText = textField.text,
              let textRange = Range(range, in: currentText) else {
            return true
        }
        
        let newText = currentText.replacingCharacters(in: textRange, with: string)
        let trimmedText = newText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedText.isEmpty && !newText.isEmpty {
            textField.text = nil
            return true
        }
        
        return false
    }
}
