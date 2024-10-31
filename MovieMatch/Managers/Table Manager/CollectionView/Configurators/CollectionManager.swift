import UIKit

protocol CollectionManagement: AnyObject {
    func attach(_ collectionView: UICollectionView)
    func update(with configurators: [CollectionCellConfiguration])
}

final class CollectionManager: NSObject, CollectionManagement {
    private var configurators = [CollectionCellConfiguration]()
    private weak var collectionView: UICollectionView?

    func attach(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let cellID = String(describing: CollectionViewCell.self)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.bounces = false
        collectionView.isUserInteractionEnabled = true
        self.collectionView = collectionView
    }

    func update(with configurators: [CollectionCellConfiguration]) {
        self.configurators = configurators
        collectionView?.reloadData()
    }
}

extension CollectionManager: UICollectionViewDataSource {
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

extension CollectionManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let configurator = configurators[indexPath.row]
        configurator.didTapCell?()
    }
}

extension CollectionManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 , height: collectionView.frame.width * 0.8)
    }
}
