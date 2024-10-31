import UIKit

protocol TableCellConfiguration: AnyObject {
    var cellIdentifier: String { get }
    var didTapCell: (() -> Void)? { get set }
    var type: TableCellCategory { get }
    func configureCell(_ cell: UITableViewCell)
}

class TableCellConfigurator: TableCellConfiguration {
    var cellIdentifier: String = String(describing: TableViewCell.self)
    var didTapCell: (() -> Void)?
    let model: TableCellModel
    var type: TableCellCategory
    
    init(_ model: TableCellModel) {
        self.model = model
        self.type = model.type
    }
    
    func configureCell(_ cell: UITableViewCell) {
        guard let cell = cell as? TableViewCell else { return }
        cell.mainLabel.text = model.title
        cell.icon.image = model.icon
    }
}

