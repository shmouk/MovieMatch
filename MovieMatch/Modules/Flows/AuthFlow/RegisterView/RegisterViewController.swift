import UIKit

class RegisterViewController: BaseViewController {
    let viewModel: AuthViewModel
    
    let emailLabel = InterfaceBuilder.makeLabel(font: .big)
    let passwordLabel = InterfaceBuilder.makeLabel(font: .big)
    let emailTextField = InterfaceBuilder.makeTextField(isPassword: false, placeholder: .enterEmail)
    let passwordTextField = InterfaceBuilder.makeTextField(isPassword: true, placeholder: .enterPassword)
    let registerButton = InterfaceBuilder.makeButton(withTitle: .register)
    let separatorView = InterfaceBuilder.makeSeparatorView()

    var didTapRegister: StringCompletion?

    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        emailLabel.text = MainTitleForUI.email.text
        passwordLabel.text = MainTitleForUI.password.text
        
        view.addSubviews(separatorView,
                         emailLabel,
                         emailTextField,
                         passwordLabel,
                         passwordTextField,
                         registerButton)
    }
    
    private func setupResponsibilities() {
        emailTextField.delegate = self
        passwordTextField.delegate = self

        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
}

private extension RegisterViewController {
    @objc
    private func registerTapped() {
        collectData()
    }
    
    private func collectData() {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        viewModel.registerUser(email: email, password: password) { [weak self] text in
            self?.didTapRegister?(text)
        }
    }
}


extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        !isStartsWithEmptyLine(textField, range, string)
    }
}
