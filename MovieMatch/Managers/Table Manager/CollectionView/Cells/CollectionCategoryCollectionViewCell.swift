import UIKit

class CollectionViewCell: UICollectionViewCell {
    var model: CollectionCellModel?
    
    let containerView = InterfaceBuilder.makeView()
    let mainLabel = InterfaceBuilder.makeLabel(font: .bigBold, textAlignment: .center)
    let icon = InterfaceBuilder.makeImageView(contentMode: .scaleAspectFill)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        contentView.addSubview(containerView)
        
        containerView.addSubviews(
            icon,
            mainLabel
        )
        
        containerView.backgroundColor = ColorForUI.tint.color.withAlphaComponent(0.3)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6)
        ])
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: containerView.topAnchor),
            icon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            icon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            icon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: icon.bottomAnchor),
            mainLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func configure(with model: CollectionCellModel) {
        self.model = model
        icon.image = model.icon
        mainLabel.text = model.title
    }
}
