class MatchViewModel {
    let matchAPI = MatchAPI.shared
    
    let movieData = Bindable(Movie.mock)
    
    init() {}
    
    func getMovie(completion: @escaping StringCompletion) {
        matchAPI.getRandomMovie { [weak self] result in
            switch result {
            case .success(let movie):
                self?.movieData.value = movie
                completion(nil)
                
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
}
