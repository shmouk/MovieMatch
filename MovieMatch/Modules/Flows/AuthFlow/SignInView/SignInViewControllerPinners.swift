import UIKit

extension SignInViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            emailLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 42)
        ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 4),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 42)
        ])
        
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 48),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            logInButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 54)
        ])
        
        NSLayoutConstraint.activate([
            createAccountLabel.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 12),
            createAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            createAccountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            createAccountLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
    }
}
