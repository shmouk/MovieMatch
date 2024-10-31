import UIKit

protocol CollectionCellConfiguration: AnyObject {
    var cellIdentifier: String { get }
    var didTapCell: (() -> Void)? { get set }
    var movie: Movie { get }
    func configureCell(_ cell: UIView)
}

final class CollectionCellConfigurator: CollectionCellConfiguration {
    var cellIdentifier = String(describing: CollectionViewCell.self)
    var didTapCell: (() -> Void)?
    var model: CollectionCellModel
    var movie: Movie

    func configureCell(_ cell: UIView) {
        guard let cell = cell as? CollectionViewCell else { return }
        cell.configure(with: model)
    }

    init(_ model: CollectionCellModel) {
        self.model = model
        self.movie = model.movie
    }
}

