import UIKit

extension MatchViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            posterImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            posterImageView.heightAnchor.constraint(equalTo: view.heightAnchor,  multiplier: 0.6)
        ])

        pullUpViewTopConstraint = pullUpView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: constantHeight)
        NSLayoutConstraint.activate([
            pullUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pullUpView.widthAnchor.constraint(equalTo: view.widthAnchor),
            pullUpView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -88-48),
            pullUpViewTopConstraint
        ])

        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: pullUpView.topAnchor, constant: 8),
            separatorView.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: 100),
            separatorView.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: separatorView.topAnchor, constant: 24),
            stackView.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: pullUpView.widthAnchor, multiplier: 0.7),
            stackView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            ageRatingLabel.widthAnchor.constraint(equalToConstant: 64),
            ratingLabel.widthAnchor.constraint(equalToConstant: 64),
            lengthMovieLabel.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            genreLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            genreLabel.widthAnchor.constraint(equalTo: pullUpView.widthAnchor, multiplier: 0.9),
            genreLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 28),
            nameLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            nameLabel.widthAnchor.constraint(lessThanOrEqualTo: pullUpView.widthAnchor, multiplier: 0.9),
            nameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            decriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            decriptionLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            decriptionLabel.widthAnchor.constraint(equalTo: pullUpView.widthAnchor, multiplier: 0.9),
            decriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: view.frame.height * 0.24)
        ])
        
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: decriptionLabel.bottomAnchor, constant: 16),
            countryLabel.leadingAnchor.constraint(equalTo: decriptionLabel.leadingAnchor),
            countryLabel.widthAnchor.constraint(equalTo: pullUpView.widthAnchor, multiplier: 0.9),
            countryLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 16),
            yearLabel.leadingAnchor.constraint(equalTo: decriptionLabel.leadingAnchor),
            yearLabel.widthAnchor.constraint(equalTo: pullUpView.widthAnchor, multiplier: 0.9),
            yearLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            directorLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 16),
            directorLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            directorLabel.widthAnchor.constraint(equalTo: pullUpView.widthAnchor, multiplier: 0.9),
            directorLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            actorsLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 16),
            actorsLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            actorsLabel.widthAnchor.constraint(equalTo: pullUpView.widthAnchor, multiplier: 0.9),
            actorsLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            bgButtonView.heightAnchor.constraint(equalToConstant: 88),
            bgButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bgButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            bgButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2)
        ])
        
        NSLayoutConstraint.activate([
            bgButtonStackView.bottomAnchor.constraint(equalTo: bgButtonView.bottomAnchor, constant: -12),
            bgButtonStackView.centerXAnchor.constraint(equalTo: bgButtonView.centerXAnchor),
            bgButtonStackView.widthAnchor.constraint(equalTo: bgButtonView.widthAnchor, multiplier: 0.5),
            bgButtonStackView.topAnchor.constraint(equalTo: bgButtonView.topAnchor, constant: 12)
        ])

        NSLayoutConstraint.activate([
            discardImageView.widthAnchor.constraint(equalToConstant: 64),
            approveImageView.widthAnchor.constraint(equalToConstant: 64)
        ])
    }
}
