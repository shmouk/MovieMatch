import Foundation
import UIKit

class MatchAPI {
    static var shared = MatchAPI()
    private let apiKey = "AMVAJSD-JN9MN1G-GRGMXMQ-670EAEW"
    private let parseQueue = DispatchQueue(label: "com.example.parseQueue", attributes: .concurrent)

    func getRandomMovie(completion: @escaping MovieResult) {
        guard let url = URL(string: "https://api.kinopoisk.dev/v1.4/movie/random?votes.kp=1000-9999999") else {
            completion(.failure(RequestError.invalidRequest))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard error == nil else {
                completion(.failure(error ?? RequestError.invalidRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(RequestError.noData))
                return
            }

            guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                  let jsonDict = json as? [String: Any] else {
                completion(.failure(RequestError.invalidJson))
                return
            }
            
            self?.parse(json: jsonDict) { movie in
                guard let movie = movie else {
                    completion(.failure(RequestError.noData))
                    return
                }
                
                completion(.success(movie))
                
            }
            
        }.resume()
        
    }
    
    private func loadImageFromURL(url: URL?, completion: @escaping ImageCompletion) {
        guard let url = url else {
            completion(UIImage())
            return
        }
        
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    completion(UIImage())
                    return
                }
                
                guard let data = data,
                      let image = UIImage(data: data) else {
                    completion(UIImage())
                    return
                }
                completion(image)
                
            }.resume()
        }
    }
    
    private func parse(json: [String: Any], completion: @escaping MovieCompletion) {
        var parsedMovie: Movie?
        
        let parseGroup = DispatchGroup()
    
        parseGroup.enter()
        
        DispatchQueue.main.async { [weak self] in
            let videos = json["videos"] as? [String: Any]
            let trailers = videos?["trailers"] as? [[String: Any]]
            let poster = json["poster"] as? [String: Any]
            let id = json["id"] as? Int
            let year = json["year"] as? Int
            let previewString = poster?["previewUrl"] as? String ?? Constants.blankString
            let previewURL = URL(string: previewString)
            let fees = json["fees"] as? [String: Any]
            let worldFees = fees?["world"] as? [String: Any]
            let worldFeeValue = worldFees?["value"] as? Int
            let countryArray = json["countries"] as? [[String: Any]]
            let genreArray = json["genres"] as? [[String: Any]]
            let nameList = json["names"] as? [[String: Any]]
            let director = json["director"] as? String
            let worldPremiereDateString = json["premiere"] as? [String: String]
            let worldPremiereDateStr = worldPremiereDateString?["world"]
            let worldPremiereDate = Constants.formattedDate(isoDate: worldPremiereDateStr)
            let movieLength = json["movieLength"] as? Int
            let ageRating = json["ageRating"] as? Int
            let description = json["description"] as? String
            let shortDescription = json["shortDescription"] as? String
            let ratings = json["rating"] as? [String: Any]
            let actors = json["persons"] as? [[String: Any]]
            
            var previewImage = UIImage()
            
            parseGroup.enter()
            
            self?.loadImageFromURL(url: previewURL) { image in
                previewImage = image
                parseGroup.leave()
            }
            
            let nameObjects = self?.fetchNameObjects(data: nameList)
            
            let countryList = self?.fetchList(array: countryArray, key: "name")
            
            let genreList = self?.fetchList(array: genreArray, key: "genre")
            
            let trailerObjects = self?.fetchTrailerObjects(data: trailers)
            
            let ratingsObject = self?.fetchRatingsObjects(data: ratings)
            
            var actorObjects: [Movie.Actor]?
            
            parseGroup.enter()

            self?.fetchActorsObjects(data: actors) { actors in
                actorObjects = actors
                parseGroup.leave()
            }
            parseGroup.leave()

            parseGroup.notify(queue: .main) {
                let parsedMovie = Movie(
                    name: nameObjects ?? Constants.emptyString,
                    id: id ?? Constants.randomInt,
                    year: String(year ?? Constants.blankInt),
                    trailers: trailerObjects ?? [Movie.Trailer.mock],
                    preview: previewImage,
                    countryList: (countryList ?? [Constants.emptyString]).joined(separator: ", "),
                    genreList: (genreList ?? [Constants.emptyString]).joined(separator: ", "),
                    director: director ?? Constants.emptyString,
                    worldPremiereDate: worldPremiereDate,
                    movieLength: String(movieLength ?? Constants.blankInt) + TitleForUI.min.text,
                    ageRating: String(ageRating ?? Constants.blankInt) + "+",
                    description: description ?? Constants.emptyString,
                    shortDescription: shortDescription ?? Constants.emptyString,
                    ratings: ratingsObject ?? Movie.Ratings.mock,
                    actors: actorObjects ?? [Movie.Actor.mock]
                )
                completion(parsedMovie)
            }
        }
    }
    
    private func fetchNameObjects(data: [[String : Any]]?) -> String? {
        let preferredLanguage = Locale.preferredLanguages.first ?? "EN"
        
        let filteredNames = data?.compactMap { item -> String? in
            let name = item["name"] as? String
            let language = item["language"] as? String
            print(name, language)
            print(language?.contains(preferredLanguage))
            return nil
        }
        
        return filteredNames?.first
    }


    private func fetchList(array: [[String : Any]]?, key: String) -> [String]? {
        let array: [String]? = array?.compactMap { countryJson in
            guard let name = countryJson["name"] as? String else {
                return Constants.emptyString
            }
            
            return name
        }
        return array
    }
    
    private func fetchTrailerObjects(data: [[String : Any]]?) -> [Movie.Trailer]? {
        let trailerObjects: [Movie.Trailer]? = data?.compactMap { trailerJSON in
            let urlStr = trailerJSON["url"] as? String ?? Constants.blankString
            let url = URL(string: urlStr)
            let name = trailerJSON["name"] as? String ?? Constants.emptyString
            let site = trailerJSON["site"] as? String
            
            return Movie.Trailer(url: url, name: name, site: site)
        }
        return trailerObjects
    }
    
    private func fetchRatingsObjects(data: [String: Any]?) -> Movie.Ratings? {
        let kp = data?["kp"] as? Double ?? Constants.blankDouble
        let imdb = data?["imdb"] as? Double ?? Constants.blankDouble
        
        return Movie.Ratings(kp: String(kp), imdb: String(imdb))
    }
    
    
    private func fetchActorsObjects(data: [[String: Any]]?, completion: @escaping MovieActorsCompletion) {
        var actors: [Movie.Actor]? = [Movie.Actor.mock]
          
        data?.forEach { actorJSON in
            let photoURLStr = actorJSON["photo"] as? String ?? Constants.blankString
            let photoURL = URL(string: photoURLStr)
            let firstName = actorJSON["name"] as? String
            let lastName = actorJSON["enName"] as? String
            
            loadImageFromURL(url: photoURL) { image in
                let movie = Movie.Actor(photo: image, firstName: firstName, lastName: lastName)
                actors?.append(movie)
                
                if actors?.count == data?.count {
                    completion(actors)
                }
            }
        }
    }
}
