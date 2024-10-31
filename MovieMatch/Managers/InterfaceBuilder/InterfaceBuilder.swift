import UIKit
import SkeletonView

final class InterfaceBuilder {
    static func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .red
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
    
    static func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }
    
    static func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = true
        collectionView.backgroundColor = .clear
        //collectionView.roundCorners(.allCorners)
        return collectionView
    }
    
    static func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
   
    static func makeLabel(font: FontForUI, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.textColor = ColorForUI.tint.color
        label.textAlignment = textAlignment
        label.font = font.size
        label.numberOfLines = 0
        label.text = "..."
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
    static func makeView(blurIsNeeded: Bool = false) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if blurIsNeeded {
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
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
        view.backgroundColor = .white.withAlphaComponent(alpha)
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = false
        return view
    }
    
    static func makeCustomNavBarButton() -> UIBarButtonItem {
        let button = UIBarButtonItem()
        button.image = ImageForUI.arrowRight.image
        button.tintColor = ColorForUI.tint.color
        return button
    }
    
    static func makeButton(withTitle: MainTitleForUI) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(withTitle.text, for: .normal)
        button.tintColor = ColorForUI.tint.color
        button.titleLabel?.font = FontForUI.mediumBold.size
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.backgroundColor = ColorForUI.fg.color
        return button
    }
    
    static func makeTextField(isPassword: Bool, placeholder: MainTitleForUI) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = isPassword
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.borderStyle = .line
        textField.font = FontForUI.regular.size
        textField.layer.borderColor = ColorForUI.fg.color.cgColor
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
        textView.layer.borderColor = ColorForUI.other.color.cgColor
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
    
    static func makeImageView(contentMode: UIView.ContentMode = .scaleToFill) -> UIImageView {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = ImageForUI.mock.image
        imageView.contentMode = contentMode
        imageView.clipsToBounds = true
        return imageView
    }
}

final class SkeletonManager {
    private var isSkeletonActive = true
    
    func toggleSkeleton(for views: [UIView]) {
        for view in views {
            view.isSkeletonable = isSkeletonActive
            isSkeletonActive ? view.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: ColorForUI.bg.color.lighter, secondaryColor: .gray),
                                                                 transition: .crossDissolve(0.25)) : view.hideSkeleton(transition: .crossDissolve(0.25))
            view.layoutSkeletonIfNeeded()
            view.setNeedsLayout()
            view.reloadInputViews()
        }
        isSkeletonActive.toggle()
    }
}
