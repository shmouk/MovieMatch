import UIKit

final class MockCoordinator: TabBarPresentableCoorinator {
    var tabBarItem: UITabBarItem
    
    var navigationController: UINavigationController
    
    var didFinish: (() -> Void)?
    
    init(navigaton: UINavigationController = UINavigationController(),
         title: String = "",
         imageActive: UIImage? = UIImage(),
         imageInactive: UIImage? = UIImage()) {
        self.navigationController = navigaton
        self.tabBarItem = UITabBarItem(title: title, image: imageInactive, selectedImage: imageActive)
    }
    
    func start() {}
    
    func stop() {}
}
