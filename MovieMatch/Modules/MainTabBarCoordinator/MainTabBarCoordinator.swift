import UIKit

// MARK: - TabBarPresentableCoorinator
protocol TabBarPresentableCoorinator: Coordinator {
    var tabBarItem: UITabBarItem { get }
}

final class MainTabbarCoordinator: UITabBarController {
    
    private var coordinators: [TabBarPresentableCoorinator]!
            
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBar.invalidateIntrinsicContentSize()
        self.tabBar.layoutSubviews()
        self.setupTabbarAppearance()
        self.addTabbarShadow()
        self.fillCoordinators()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupTabbarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(named: "TintColor")]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        tabBar.standardAppearance = appearance
        UITabBar.appearance().backgroundColor = UIColor(named: "OtherColor")
    }
    
    private func addTabbarShadow() {
        tabBar.layer.shadowOffset = .zero
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
    }
    
    private func fillCoordinators() {
        // TODO: - clean mocks
        let matchCoordinator = MatchCoordinator(navigation: UINavigationController())
        let browserCoordinator = MockCoordinator(title: "Browser",
                                                 imageActive: UIImage(),
                                                 imageInactive: UIImage())
        let mainVPNCoordinator = MockCoordinator(title: "VPN",
                                                 imageActive: UIImage(),
                                                 imageInactive: UIImage())

        coordinators = [matchCoordinator,
                        browserCoordinator,
                        mainVPNCoordinator]

        coordinators.forEach {
            $0.navigationController.tabBarItem = $0.tabBarItem
        }
        self.viewControllers = coordinators.map {
            $0.navigationController
        }
        coordinators.forEach { $0.start() }
    }
    
    func hideTabbar() {
        self.tabBar.isHidden = true
    }
    
    func showTabbar() {
        self.tabBar.isHidden = false
    }
    
    func hideNavbar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func showNavbar() {
        self.navigationController?.navigationBar.isHidden = false
    }
}
