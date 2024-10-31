import UIKit

protocol CollectionManagement: AnyObject {
    func attach(_ collectionView: UICollectionView)
    func update(with configurators: [ProfileCategoryCellConfiguration])
}

final class CollectionManager: NSObject, CollectionManagement {
    private var configurators = [CollectionCategoryCellConfiguration]()
    private weak var collectionView: UICollectionView?

    func attach(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let cleanerCellID = String(describing: CollectionCategoryCollectionViewCell.self)
        collectionView.register(CollectionCategoryCollectionViewCell.self, forCellWithReuseIdentifier: cleanerCellID)
        
        collectionView.bounces = false
        collectionView.isUserInteractionEnabled = true
        self.collectionView = collectionView
    }

    func update(with configurators: [CollectionCategoryCellConfiguration]) {
        self.configurators = configurators
        collectionView?.reloadData()
    }
}

extension ProfileManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator = configurators[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.cellIdentifier, for: indexPath)
        configurator.configureCell(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configurators.count
    }
}

extension ProfileManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let configurator = configurators[indexPath.row]
        configurator.didTapCell?()
    }
}

extension ProfileManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 86)
    }
}
