import UIKit

final class MatchCoordinator: TabBarPresentableCoorinator {
    let alertManager = AlertManager.shared
    
    var tabBarItem: UITabBarItem = {
        let selectedIcon = UIImage(systemName: "play.house.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let unselectedIcon = UIImage(systemName: "play.house.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let item = UITabBarItem()
        item.title = MainTitleForTabBar.match.text
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
        self.navigationController.pushViewController(createMatchController(), animated: false)
    }
    
    func stop() {
        didFinish?()
    }
}

extension MatchCoordinator {
    private func createMatchController() -> UIViewController {
        let viewModel = MatchViewModel()
        let controller = MatchViewController(viewModel: viewModel)
        
//        controller.didTapLogIn = { [weak self] text in
//            self?.alertManager.showAlert(title: text, viewController: controller)
//        }
//        
//        controller.didTapCreateAccount = { [self] in
//            self.navigationController.present(createRegisterController(), animated: true)
//        }
//        
//        viewModel.authStateHandler = { [weak self] authState in
//            guard authState else {
//                self?.navigationController.popViewController(animated: true)
//                return
//            }
//            self?.stop()
//        }
//        
        return controller
    }
}
