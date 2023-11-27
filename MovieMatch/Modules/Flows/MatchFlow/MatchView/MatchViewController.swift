import UIKit

class MatchViewController: BaseViewController {
    let viewModel: MatchViewModel
    
    let scrollView = InterfaceBuilder.makeScrollView()
    let nameLabel = InterfaceBuilder.makeLabel(font: .big)
    let posterImageView = InterfaceBuilder.makeImageView()
    let lengthMovieLabel = InterfaceBuilder.makeLabel(font: .big)
    let genreLabel = InterfaceBuilder.makeLabel(font: .big, textAlignment: .center)
    let ageRatingLabel = InterfaceBuilder.makeLabel(font: .big)
    let ratingLabel = InterfaceBuilder.makeLabel(font: .big)
    let discardImageView = InterfaceBuilder.makeImageView()
    let approveImageView = InterfaceBuilder.makeImageView()
    let pullUpView = InterfaceBuilder.makeView(blurIsNeeded: true)
    let shortDecriptionLabel = InterfaceBuilder.makeLabel(font: .big)
    let bgView = InterfaceBuilder.makeView(blurIsNeeded: true)
    let yearLabel = InterfaceBuilder.makeLabel(font: .big)
    let decriptionLabel = InterfaceBuilder.makeLabel(font: .big)
    let trailerPreviewImageView = InterfaceBuilder.makeImageView()
    let worldPremiereDate = InterfaceBuilder.makeLabel(font: .big)
    let countryLabel = InterfaceBuilder.makeLabel(font: .big)
    let actorsLabel = InterfaceBuilder.makeLabel(font: .big)

    var didTapRegister: StringCompletion?
    
    var initialY: CGFloat = 0
    var pullUpViewTopConstraint: NSLayoutConstraint!
    var isPullUpViewVisible = false
    lazy var pullUpViewFullHeight: CGFloat = posterImageView.frame.height

    init(viewModel: MatchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickData()
        shouldHideNavBar(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupResponsibilities()
        bindViewModel()
    }
    
    private func setUI() {
        setSubviews()
        setupConstraints()
    }
    
    private func setSubviews() {
        view.addSubviews(posterImageView,
                         pullUpView,
                         approveImageView,
                         discardImageView)

        pullUpView.addSubviews(
            ageRatingLabel,
            lengthMovieLabel,
            genreLabel,
            ratingLabel,
            nameLabel,
            shortDecriptionLabel,
            yearLabel,
            decriptionLabel,
//            trailerPreviewImageView,
            countryLabel
//            actorsLabel
        )
    }
    
    private func bindViewModel() {
        viewModel.movieData.bind { [weak self] movieData in
            self?.setupUIData(data: movieData)
        }
    }
    
    private func setupUIData(data: Movie) {
        approveImageView.image = UIImage(named: "approveIcon")
        discardImageView.image = UIImage(named: "discardIcon")
        
        ageRatingLabel.text = data.ageRating
        lengthMovieLabel.text = data.movieLength
        genreLabel.text = data.genreList
        ratingLabel.text = data.ratings.kp
        posterImageView.image = data.preview
        nameLabel.text = data.name
        decriptionLabel.text = data.description
        yearLabel.text = data.year
//        decriptionLabel.text = data
        countryLabel.text = data.countryList
//        actorsLabel.text = data.actors.first?.firstName
    }
    
    private func pickData() {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.getMovie { text in
                print(text?.localized)
            }
        }
    }
    
    private func setupResponsibilities() {
        let swipeGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePullGesture))
        pullUpView.addGestureRecognizer(swipeGestureRecognizer)
    }
}

private extension MatchViewController {
    @objc
    func handlePullGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        switch sender.state {
        case .began:
            initialY = pullUpViewTopConstraint.constant
            
        case .changed:
            let offset = initialY + translation.y
            let newConstant = !isPullUpViewVisible ? min(offset, initialY) : max(offset, initialY)
            pullUpViewTopConstraint.constant = newConstant
            
        case .ended, .cancelled:
            if pullUpViewTopConstraint.constant > -view.frame.height * 0.5 {
                isPullUpViewVisible = false
                pullUpViewTopConstraint.constant = 0
            } else {
                isPullUpViewVisible = true
                pullUpViewTopConstraint.constant = -pullUpViewFullHeight
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
        default:
            break
        }
    }
}
