import UIKit

extension RegisterViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: 64),
            separatorView.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 14),
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
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 48),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            registerButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 54)
        ])
    }
}
