import Foundation
import UIKit

import Foundation
import UIKit

final class FavoriteViewModel {
    let collectionManager: CollectionManager
    let movieAPI = MovieAPI.shared
    let matchAPI = MatchAPI.shared
    
    private var movieData: [Movie] = []
    private var ids: [Int] = []
    
    var didTapCell: ((Movie) -> Void)?

    init(_ collectionManager: CollectionManager = .init()) {
        self.collectionManager = collectionManager
    }

    func attach(_ collectionView: UICollectionView) {
        collectionManager.attach(collectionView)
    }
    
    func update() {
        fetchFavoriteMovieData { movieData in
            self.movieData = movieData
            self.updateCollectionView(with: movieData)
        }
    }

    private func fetchFavoriteMovieData(completion: @escaping MovieDataCompletion) {
        movieAPI.getMovieIds { [self] idArray in
            let dispatchGroup = DispatchGroup()
            var fetchedMovies: [Movie] = []
            
            idArray.forEach { id in
                guard !ids.contains(where: { $0 == id }) else { return }
                
                ids.append(id)

                dispatchGroup.enter()
                
                self.matchAPI.getMovieData(urlSuffix: String(id)) { result in
                    defer { dispatchGroup.leave() }
                    
                    switch result {
                    case .success(let movie):
                        fetchedMovies.append(movie)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                let sortedMovies = fetchedMovies.sorted { $0.id < $1.id }
                completion(sortedMovies)
            }
        }
    }

    private func updateCollectionView(with movieData: [Movie]) {
        let output: [CollectionCellConfiguration] = movieData.map { movie in
            let model = CollectionCellModel(movie: movie)
            return makeOptionConfigurator(with: model)
        }

        output.forEach { configurator in
            configurator.didTapCell = { [weak self] in
                self?.didTapCell?(configurator.movie)
            }
        }

        collectionManager.update(with: output)
    }
}

private extension FavoriteViewModel {
    func makeOptionConfigurator(with model: CollectionCellModel) -> CollectionCellConfiguration {
        return CollectionCellConfigurator(model)
    }
}
