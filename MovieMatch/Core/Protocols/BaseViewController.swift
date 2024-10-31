import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorForUI.bg.color
    }
    
    func shouldHideNavBar(_ status: Bool) {
        if let tabController = self.tabBarController as? MainTabbarCoordinator {
            status ? tabController.hideNavbar(): tabController.showNavbar()
        }
    }
}
