import UIKit

final class AuthCoordinator: Coordinator {
    let alertManager = AlertManager.shared
    
    var navigationController: UINavigationController
    
    var didFinish: (() -> Void)?
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        self.navigationController.pushViewController(createAuthController(), animated: false)
    }
    
    func stop() {
        didFinish?()
    }
}

extension AuthCoordinator {
    private func createAuthController() -> UIViewController {
        let viewModel = AuthViewModel()
        let controller = SignInViewController(viewModel: viewModel)
        
        controller.didTapLogIn = { [weak self] text in
            self?.alertManager.showAlert(title: text, viewController: controller)
        }
        
        controller.didTapCreateAccount = { [self] in
            self.navigationController.present(createRegisterController(), animated: true)
        }
        
        viewModel.authStateHandler = { [weak self] authState in
            guard authState else {
                self?.navigationController.popViewController(animated: true)
                return
            }
            self?.stop()
        }
        
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
