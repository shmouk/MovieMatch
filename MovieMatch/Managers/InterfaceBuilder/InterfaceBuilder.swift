import UIKit

final class InterfaceBuilder {
    static func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .red
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
    
    static func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
    
    static func makeLabel(title: TitleForUI = .undefined, font: FontForUI, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.textColor = UIColor(named: "TintColor")
        label.textAlignment = textAlignment
        label.font = font.size
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = title.text
        return label
    }
    
    static func makeView(blurIsNeeded: Bool = false) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if blurIsNeeded {
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
            view.addSubview(blurView)
            blurView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                blurView.topAnchor.constraint(equalTo: view.topAnchor),
                blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        return view
    }
    
    static func makeSeparatorView(alpha: CGFloat = 0.4) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "OtherColor")?.withAlphaComponent(alpha)
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = false
        return view
    }
    
    static func makeCustomNavBarButton() -> UIBarButtonItem {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        button.tintColor = UIColor(named: "TintColor")
        return button
    }
    
    static func makeButton(withTitle: TitleForUI) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(withTitle.text, for: .normal)
        button.tintColor = UIColor(named: "TintColor")
        button.titleLabel?.font = FontForUI.bigBold.size
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(named: "FgColor")
        return button
    }
    
    static func makeTextField(isPassword: Bool, placeholder: TitleForUI) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = isPassword
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.borderStyle = .line
        textField.font = FontForUI.regular.size
        textField.layer.borderColor = UIColor(named: "FgColor")?.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 16
        textField.layer.masksToBounds = true
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray]
        let attributedPlaceholder = NSAttributedString(string: placeholder.text, attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        let leftPaddingView = UIView(frame: CGRect(x: 8, y: 0, width: 10, height: 48))
        leftPaddingView.isUserInteractionEnabled = false
        leftPaddingView.backgroundColor = .clear
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }
    
    static func makeTextView() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.layer.borderColor = UIColor(named: "OtherColor")?.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 16
        textView.font?.withSize(16)
        textView.textAlignment = .left
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.text = "inputText".localized
        textView.isScrollEnabled = false
        textView.layer.masksToBounds = true
        textView.isEditable = true
        return textView
    }
    
    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logoIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}

