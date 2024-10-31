import UIKit

class TableViewCell: UITableViewCell {
    var model: TableCellModel?
    
    let containerView = InterfaceBuilder.makeView()
    let mainLabel = InterfaceBuilder.makeLabel(font: .bigBold)
    let icon = InterfaceBuilder.makeImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        icon.addShadow()
        containerView.backgroundColor = ColorForUI.tint.color.withAlphaComponent(0.3)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.6),
            icon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
            mainLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            mainLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            mainLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(with model: TableCellModel) {
        self.model = model
        icon.image = model.icon
        mainLabel.text = model.title
    }
}
