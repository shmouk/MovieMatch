import UIKit

protocol ProfileCategoryCellConfiguration: AnyObject {
    var cellIdentifier: String { get }
    var didTapCell: (() -> Void)? { get set }
    var type: ProfileCategory { get }
    var state: CleanerCategoryState { get }
    func configureCell(_ cell: UIView)
}

final class CleanerCategoryCellConfigurator: ProfileCategoryCellConfiguration {
    var cellIdentifier = String(describing: CleanerCategoryCollectionViewCell.self)
    var didTapCell: (() -> Void)?
    var model: CleanerCategoryCellModel
    var state: CleanerCategoryState
    var type: ProfileCategory

    func configureCell(_ cell: UIView) {
        guard let cell = cell as? CleanerCategoryCollectionViewCell else { return }
        cell.configure(with: model)
    }

    init(_ model: CleanerCategoryCellModel) {
        self.model = model
        self.type = model.type
        self.state = model.state
    }
}
