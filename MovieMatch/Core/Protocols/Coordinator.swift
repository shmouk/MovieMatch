import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var didFinish: (() -> Void)? { get set }
    
    func start()
    func stop()
}
