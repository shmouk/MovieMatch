import UIKit

class SignInViewController: BaseViewController {
    let viewModel: AuthViewModel
    
    lazy var logoImageView = InterfaceBuilder.makeImageView()
    lazy var emailLabel = InterfaceBuilder.makeLabel(title: .email, font: .big)
    lazy var passwordLabel = InterfaceBuilder.makeLabel(title: .password, font: .big)
    lazy var emailTextField = InterfaceBuilder.makeTextField(isPassword: false, placeholder: .enterEmail)
    lazy var passwordTextField = InterfaceBuilder.makeTextField(isPassword: true, placeholder: .enterPassword)
    lazy var logInButton = InterfaceBuilder.makeButton(withTitle: .signIn)
    lazy var createAccountLabel = InterfaceBuilder.makeLabel(title: .createAccount, font: .regular, textAlignment: .center)

    var didTapLogIn: StringCompletion?
    var didTapCreateAccount: TapHandler?

    private var keyboardManager: KeyboardManager?

    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   deinit {
       keyboardManager?.stopObservingKeyboard()
   }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupResponsibilities()
    }
    
    private func setUI() {
        setSubviews()
        setupConstraints()
    }
    
    private func setSubviews() {
        view.addSubviews(logoImageView,
                         emailLabel,
                         emailTextField,
                         passwordLabel,
                         passwordTextField,
                         logInButton,
                         createAccountLabel)
    }
    
    private func setupResponsibilities() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        keyboardManager = KeyboardManager(view: view)
        keyboardManager?.startObservingKeyboard()

        logInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        let createAccountGesture = UITapGestureRecognizer(target: self, action: #selector(createAccountTapped))
        createAccountLabel.addGestureRecognizer(createAccountGesture)
    }
}

private extension SignInViewController {
    @objc
    private func signInTapped() {
        collectData()
    }
    
    @objc
    private func createAccountTapped() {
        didTapCreateAccount?()
    }
    
    private func collectData() {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        viewModel.signInUser(email: email, password: password) { [weak self] text in
            self?.didTapLogIn?(text)
        }
    }
}


extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        !isStartsWithEmptyLine(textField, range, string)
    }
}
