class MatchViewModel {
    let matchAPI = MatchAPI.shared
    let movieAPI = MovieAPI.shared
    
    let movieData = Bindable<Movie>()
    
    init() {}
    
    func getMovie(completion: @escaping StringCompletion) {
        matchAPI.getMovieData { [weak self] result in
            switch result {
            case .success(let movie):
                self?.movieData.value = movie
                completion(nil)
                
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
    
    func saveMovie() {  
        guard let movieData = self.movieData.value else { return }
        
        movieAPI.setMovieId(isFavorite: true, id: movieData.id) { result in
            switch result {
            case .success(let info):
                print(info)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
