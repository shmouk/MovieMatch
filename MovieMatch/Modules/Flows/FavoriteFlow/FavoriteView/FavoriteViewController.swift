import UIKit

class FavoriteViewController: BaseViewController {
    private let viewModel: FavoriteViewModel
    
    let collectionView = InterfaceBuilder.makeCollectionView()
    
    var didTapCell: ((Movie) -> Void)?
    
    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupResponsibilities()
        viewModel.attach(collectionView)
//        viewModel.getFavoriteMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
//        viewModel.update()
    }
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubviews(collectionView)
    }
    
    private func setupResponsibilities() {
        viewModel.didTapCell = { [weak self] movie in
            self?.didTapCell?(movie)
        }
    }
}
    
    
