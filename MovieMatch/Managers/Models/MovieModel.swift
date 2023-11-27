import Foundation
import UIKit

struct Movie {
    let name: String
    let id: Int
    let year: String
    let trailers: [Trailer]
    let preview: UIImage
    let countryList: String
    let genreList: String
    let director: String
    let worldPremiereDate: String
    let movieLength: String
    let ageRating: String
    let description: String
    let shortDescription: String
    let ratings: Ratings
    let actors: [Actor]

    struct Trailer {
        let url: URL?
        let name: String
        let site: String?
    }
    
    struct Ratings {
        let kp: String
        let imdb: String
//        let filmCritics: Int
//        let russianFilmCritics: Int
    }
    
    struct Actor {
        let photo: UIImage?
        let firstName: String?
        let lastName: String?
    }
}

extension Movie {
    static var mock: Movie = .mock
}

extension Movie.Trailer {
    static var mock: Movie.Trailer = .mock
}

extension Movie.Ratings {
    static var mock: Movie.Ratings = .mock
}

extension Movie.Actor {
    static var mock: Movie.Actor = .mock
}
