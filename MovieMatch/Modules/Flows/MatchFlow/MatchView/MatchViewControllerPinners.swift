import UIKit

extension MatchViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            posterImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            posterImageView.heightAnchor.constraint(equalTo: view.heightAnchor,  multiplier: 0.6)
        ])

        pullUpViewTopConstraint = pullUpView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor)
        NSLayoutConstraint.activate([
            pullUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pullUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pullUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pullUpViewTopConstraint
        ])
        
        NSLayoutConstraint.activate([
            ageRatingLabel.topAnchor.constraint(equalTo: pullUpView.topAnchor, constant: 16),
            ageRatingLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor, constant: -48),
            ageRatingLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            ageRatingLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            lengthMovieLabel.topAnchor.constraint(equalTo: pullUpView.topAnchor, constant: 16),
            lengthMovieLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor, constant: 48),
            lengthMovieLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            lengthMovieLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: lengthMovieLabel.bottomAnchor, constant: 8),
            genreLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            genreLabel.widthAnchor.constraint(equalTo: pullUpView.widthAnchor, multiplier: 0.9),
            genreLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 8),
            ratingLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            ratingLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            ratingLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            nameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            decriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            decriptionLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            decriptionLabel.widthAnchor.constraint(lessThanOrEqualTo: pullUpView.widthAnchor),
            decriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: decriptionLabel.bottomAnchor, constant: 16),
            countryLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            countryLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            countryLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 16),
            yearLabel.centerXAnchor.constraint(equalTo: pullUpView.centerXAnchor),
            yearLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            yearLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            approveImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            approveImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -64),
            approveImageView.widthAnchor.constraint(equalToConstant: 64),
            approveImageView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            discardImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            discardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 64),
            discardImageView.widthAnchor.constraint(equalToConstant: 64),
            discardImageView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}
