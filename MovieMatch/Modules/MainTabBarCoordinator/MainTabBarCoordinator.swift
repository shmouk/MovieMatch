import UIKit

// MARK: - TabBarPresentableCoorinator
protocol TabBarPresentableCoorinator: Coordinator {
    var tabBarItem: UITabBarItem { get }
}

final class MainTabbarCoordinator: UITabBarController {
    
    private var coordinators: [TabBarPresentableCoorinator]!
    private lazy var underView = InterfaceBuilder.makeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarAppearance()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setUI() {
        self.tabBar.invalidateIntrinsicContentSize()
        self.tabBar.layoutSubviews()
        self.fillCoordinators()
    }
    
    private func setupTabBarAppearance() {
        let customTabBar = CustomizedTabBar(frame: self.tabBar.frame)
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
    private func fillCoordinators() {
        let matchCoordinator = MatchCoordinator(navigation: UINavigationController())
        let favoriteCoordinator = FavoriteCoordinator(navigation: UINavigationController())
        let profileCoordinator = ProfileCoordinator(navigation: UINavigationController())
        
        coordinators = [matchCoordinator,
                        favoriteCoordinator,
                        profileCoordinator]
        
        coordinators.forEach {
            $0.navigationController.tabBarItem = $0.tabBarItem
            $0.navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: -12, left: 0, bottom: 0, right: 0)
            $0.navigationController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
            $0.navigationController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
            $0.navigationController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        }
        
        self.viewControllers = coordinators.map { $0.navigationController }
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
