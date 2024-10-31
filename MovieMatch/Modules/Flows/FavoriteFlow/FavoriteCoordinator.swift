import UIKit

final class FavoriteCoordinator: TabBarPresentableCoorinator {
    let alertManager = AlertManager.shared
    
    var tabBarItem: UITabBarItem = {
        let selectedIcon = UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let unselectedIcon = UIImage(systemName: "star")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let item = UITabBarItem()
        item.title = MainTitleForTabBar.favorite.text
        item.selectedImage = selectedIcon
        item.image = unselectedIcon
        return item
    }()
    
    var navigationController: UINavigationController
    
    var didFinish: (() -> Void)?
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        self.navigationController.pushViewController(createFavoriteController(), animated: false)
    }
    
    func stop() {
        didFinish?()
    }
}

extension FavoriteCoordinator {
    private func createFavoriteController() -> UIViewController {
        let viewModel = FavoriteViewModel()
        let controller = FavoriteViewController(viewModel: viewModel)
        
        controller.didTapCell = { movie in
            print(movie.name)
        }
        
        return controller
    }
}
