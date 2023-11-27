import UIKit

final class MatchCoordinator: TabBarPresentableCoorinator {
    let alertManager = AlertManager.shared
    
    var tabBarItem: UITabBarItem = {
        var icon = UIImage(systemName: "play.house.fill")
        let item = UITabBarItem(title: nil, image: icon, tag: 0)
        return item
    }()
    
    var navigationController: UINavigationController
    
    var didFinish: (() -> Void)?
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        self.navigationController.pushViewController(createMainAuthController(), animated: false)
    }
    
    func stop() {
        didFinish?()
    }
}

extension MatchCoordinator {
    private func createMainAuthController() -> UIViewController {
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
    
    private func createRegisterController() -> UIViewController {
        let viewModel = AuthViewModel()
        let controller = RegisterViewController(viewModel: viewModel)
        
        controller.didTapRegister = { [weak self] text in
            self?.alertManager.showAlert(title: text, viewController: controller)
        }
        
        return controller
    }
}
