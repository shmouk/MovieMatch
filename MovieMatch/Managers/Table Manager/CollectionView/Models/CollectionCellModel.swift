import UIKit

struct CollectionCellModel {
    let icon: UIImage?
    let title: String
    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
        self.title = movie.name
        self.icon = movie.preview
    }
}

