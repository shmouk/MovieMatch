import UIKit
import FirebaseAuth
import SkeletonView

class MatchViewController: BaseViewController {
    let viewModel: MatchViewModel
    let skeletonManager = SkeletonManager()
    
    let posterImageView = InterfaceBuilder.makeImageView()
    let separatorView = InterfaceBuilder.makeSeparatorView()
    let stackView = InterfaceBuilder.makeStackView()
    let nameLabel = InterfaceBuilder.makeLabel(font: .mediumBold)
    let lengthMovieLabel = InterfaceBuilder.makeLabel(font: .big, textAlignment: .center)
    let genreLabel = InterfaceBuilder.makeLabel(font: .big, textAlignment: .center)
    let ageRatingLabel = InterfaceBuilder.makeLabel(font: .big, textAlignment: .center)
    let ratingLabel = InterfaceBuilder.makeLabel(font: .bigBold, textAlignment: .center)
    let discardImageView = InterfaceBuilder.makeImageView(contentMode: .scaleAspectFit)
    let approveImageView = InterfaceBuilder.makeImageView(contentMode: .scaleAspectFit)
    let pullUpView = InterfaceBuilder.makeView()
    let shortDecriptionLabel = InterfaceBuilder.makeLabel(font: .big)
    let bgButtonStackView = InterfaceBuilder.makeStackView()
    let bgButtonView = InterfaceBuilder.makeView()
    let yearLabel = InterfaceBuilder.makeLabel(font: .big)
    let decriptionLabel = InterfaceBuilder.makeLabel(font: .big, textAlignment: .natural)
    let trailerPreviewImageView = InterfaceBuilder.makeImageView()
    let worldPremiereDate = InterfaceBuilder.makeLabel(font: .big)
    let countryLabel = InterfaceBuilder.makeLabel(font: .big)
    let actorsLabel = InterfaceBuilder.makeLabel(font: .big)
    let directorLabel = InterfaceBuilder.makeLabel(font: .big)
    
    var didTapRegister: StringCompletion?
    var didTapApprove: Handler?
    var didTapDiscard: Handler?
    
    var constantHeight: CGFloat = -10
    var initialY: CGFloat = 0
    var pullUpViewTopConstraint: NSLayoutConstraint!
    var isPullUpViewVisible = false
    lazy var pullUpViewFullHeight: CGFloat = posterImageView.frame.height - 48
    
    init(viewModel: MatchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        //        self.pickData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shouldHideNavBar(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupResponsibilities()
        pickData()
        bindViewModel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupAppearance()
    }
    
    private func setUI() {
        setSubviews()
        setupConstraints()
    }
    
    private func setupAppearance() {
        [pullUpView, bgButtonView].forEach { $0.backgroundColor = ColorForUI.bg.color }
        pullUpView.roundCorners([.topLeft, .topRight])
        
    }
    
    private func setSubviews() {
        approveImageView.image = ImageForUI.approve.image
        discardImageView.image = ImageForUI.discard.image
        
        view.addSubviews(posterImageView,
                         pullUpView,
                         bgButtonView,
                         bgButtonStackView
        )
        
        bgButtonStackView.addArrangedSubviews(discardImageView,
                                              approveImageView)
        
        stackView.addArrangedSubviews(ageRatingLabel,
                                      ratingLabel,
                                      lengthMovieLabel
        )
        
        pullUpView.addSubviews(
            separatorView,
            stackView,
            genreLabel,
            nameLabel,
            //            shortDecriptionLabel,
            yearLabel,
            decriptionLabel,
            //            trailerPreviewImageView,
            countryLabel,
            actorsLabel,
            directorLabel
        )
    }
    
    private func bindViewModel() {
        viewModel.movieData.bind { [weak self] movieData in
            self?.setupUIData(data: movieData)
        }
    }
    
    private func setupUIData(data: Movie) {
        DispatchQueue.main.async { [self] in
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
            actorsLabel.text = data.actorList
            directorLabel.text = data.directorList
            print("setupUIData")
            
        }
        isSkeletonAnimationActive()
    }
    
    private func pickData() {
        isSkeletonAnimationActive()
        
        viewModel.getMovie { text in
            print(text?.localized)
        }
    }
    
    private func isSkeletonAnimationActive() {
        var stackViews = stackView.arrangedSubviews.compactMap { $0 }
        let pullUpViews = pullUpView.subviews.compactMap { $0 }
        stackViews.append(contentsOf: pullUpViews)
        stackViews.append(posterImageView)
        skeletonManager.toggleSkeleton(for: stackViews)
    }
    
    private func setupResponsibilities() {
        let swipeGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePullGesture))
        pullUpView.addGestureRecognizer(swipeGestureRecognizer)
        
        let approveGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(approveHandler))
        approveImageView.addGestureRecognizer(approveGestureRecognizer)

        let discardGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(discardHandler))
        discardImageView.addGestureRecognizer(discardGestureRecognizer)
        
//        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
//        swipeUpGesture.direction = .up
//        pullUpView.addGestureRecognizer(swipeUpGesture)
//        
//        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
//        swipeDownGesture.direction = .down
//        pullUpView.addGestureRecognizer(swipeDownGesture)

    }
}

private extension MatchViewController {
    
//    @objc
//    func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
//        
//        switch sender.direction {
//        case .up:
//            pullUpViewTopConstraint.constant = -posterImageView.frame.height
//            print( 1, pullUpView.frame.origin)
//            UIView.animate(withDuration: 0.3) {
//                self.view.layoutIfNeeded()
//            }
//        case .down:
//            pullUpViewTopConstraint.constant = constantHeight
//            print( 2, pullUpView.frame.origin)
//            UIView.animate(withDuration: 0.3) {
//                self.view.layoutIfNeeded()
//            }
//        default:
//            break
//        }
//    }
    
    @objc
    func approveHandler(_ sender: UITapGestureRecognizer) {
        viewModel.saveMovie()
        hidePullUpView()
        AnimationManager.animateAlphaChange(view: approveImageView, targetAlpha: 0.3)
        pickData()
    }
    
    @objc
    func discardHandler(_ sender: UITapGestureRecognizer) {
        hidePullUpView()
        AnimationManager.animateAlphaChange(view: discardImageView, targetAlpha: 0.3)
        pickData()
    }
    
    @objc
    func handlePullGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        switch sender.state {
        case .began:
            initialY = pullUpViewTopConstraint.constant
            
        case .changed:
            changedStatePullUpView(translation)
            
        case .ended, .cancelled:
            endedStatePullUpView()
            
        default:
            break
        }
    }
    
    private func hidePullUpView() {
        pullUpViewTopConstraint.constant = constantHeight
        isPullUpViewVisible = false
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func changedStatePullUpView(_ translation: CGPoint) {
        if isPullUpViewVisible {
            let offset = initialY + min(translation.y, pullUpViewFullHeight)
            pullUpViewTopConstraint.constant = max(offset, initialY)
        } else {
            let offset = initialY + max(translation.y, -pullUpViewFullHeight)
            pullUpViewTopConstraint.constant = min(offset, initialY)
        }
    }
    
    private func endedStatePullUpView() {
        let checkOffset = pullUpViewTopConstraint.constant > -posterImageView.frame.height * 0.5
        isPullUpViewVisible = !checkOffset
        pullUpViewTopConstraint.constant = checkOffset ? constantHeight : -pullUpViewFullHeight
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
