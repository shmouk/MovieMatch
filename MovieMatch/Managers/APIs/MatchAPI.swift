import Foundation
import UIKit

private enum RequestType {
    case random
    
    var info: String {
        switch self {
            
        case .random:
            "random?votes.kp=1000-9999999"
        }
    }
}

class MatchAPI: APIProtocol {
    static var shared = MatchAPI()

    private let apiKey: String = "AMVAJSD-JN9MN1G-GRGMXMQ-670EAEW"
    private let preferredLanguage: String
    
    private init()  {
        self.preferredLanguage = Locale.preferredLanguages.first ?? "EN"
    }
    
    func getMovieData(urlSuffix: String = RequestType.random.info, completion: @escaping MovieResult) {
        guard let url = URL(string: "https://api.kinopoisk.dev/v1.4/movie/" + urlSuffix) else {
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
    
    private func parse(json: [String: Any], completion: @escaping MovieCompletion) {
        var parsedMovie: Movie?
        
        let parseGroup = DispatchGroup()
        parseGroup.enter()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
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
            let worldPremiereDateString = json["premiere"] as? [String: String]
            let worldPremiereDateStr = worldPremiereDateString?["world"]
            let worldPremiereDate = Constants.formattedDate(isoDate: worldPremiereDateStr)
            let movieLength = json["movieLength"] as? Int
            let ageRating = json["ageRating"] as? Int
            let description = json["description"] as? String
            let shortDescription = json["shortDescription"] as? String
            let ratings = json["rating"] as? [String: Any]
            let persons = json["persons"] as? [[String: Any]]
            
            var previewImage = UIImage()
            
            parseGroup.enter()
            
            self.loadImageFromURL(url: previewURL) { results in
                switch results {
                case .success(let image):
                    previewImage = image
                
                case .failure(_):
                    break
                }
                parseGroup.leave()
            }
            
            let nameObjects = self.fetchNameObject(data: nameList)
            
            let countryList = self.fetchList(array: countryArray, key: "name")
            
            let genreList = self.fetchList(array: genreArray, key: "name")
            
            let trailerObjects = self.fetchTrailerObjects(data: trailers)
            
            let ratingsObjects = self.fetchRatingsObjects(data: ratings)
            
            var personsTuple = self.fetchPersons(data: persons)
            
            parseGroup.leave()
            
            parseGroup.notify(queue: .main) {
                let parsedMovie = self.remakeData(
                    nameObjects,
                    id,
                    year,
                    trailerObjects,
                    previewImage,
                    countryList,
                    genreList,
                    worldPremiereDate,
                    movieLength,
                    ageRating,
                    description,
                    shortDescription,
                    ratingsObjects,
                    personsTuple
                )
                completion(parsedMovie)
            }
        }
    }
    
    private func fetchNameObject(data: [[String : Any]]?) -> String? {
        let result = data?.compactMap { item -> String? in
            let name = item["name"] as? String
            var language = item["language"] as? String
            
            if let firstItem = data?.first,
                NSDictionary(dictionary: firstItem).isEqual(to: item) {
                language = "RU"
            }
            
            if let secondItem = data?.dropFirst().first,
               NSDictionary(dictionary: secondItem).isEqual(to: item) {
                language = "EN"
            }
            return (language?.contains(preferredLanguage) != nil) ? name : nil
            
        }.first
        return result
    }
    
    private func fetchList(array: [[String : Any]]?, key: String) -> [String]? {
        let array: [String]? = array?.compactMap { json in
            guard let name = json[key] as? String else {
                return nil
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
    
    private func fetchPersons(data: [[String: Any]]?) -> PersonsTuple {
        var persons: PersonsTuple = ([], [])
        
        data?.forEach { actorJSON in
            guard let enName = actorJSON["enName"] as? String else {
                return
            }
            
            let name = actorJSON["name"] as? String ?? enName
            let profession = actorJSON["enProfession"] as? String
            let resultName = preferredLanguage.contains("RU") ? name : enName

            switch profession {
            case .some("director"):
                persons.directors.append(resultName)

            case .some("actor"):
                persons.actors.append(resultName)
                
            case .some(_):
                break
                
            case .none:
                break
            }
        }
        
        return persons
    }

    
    private func remakeData(_ nameObjects: String?,
                            _ id: Int?,
                            _ year: Int?,
                            _ trailerObjects: [Movie.Trailer]?,
                            _ previewImage: UIImage,
                            _ countryList: [String]?,
                            _ genreList: [String]?,
                            _ worldPremiereDate: String,
                            _ movieLength: Int?,
                            _ ageRating: Int?,
                            _ description: String?,
                            _ shortDescription: String?,
                            _ ratingsObjects: Movie.Ratings?,
                            _ personsTuple: PersonsTuple?) -> Movie {
        Movie(
            name: nameObjects ?? Constants.emptyString,
            id: id ?? Constants.randomInt,
            year: MainTitleForUI.year.text + String(year ?? Constants.blankInt),
            trailers: trailerObjects ?? [Movie.Trailer.mock],
            preview: previewImage,
            countryList: MainTitleForUI.countries.text + (countryList?.prefix(2).joined(separator: ", ") ?? Constants.emptyString),
            genreList: genreList?.prefix(4).joined(separator: ", ") ?? Constants.emptyString,
            directorList: MainTitleForUI.directors.text + (personsTuple?.directors.prefix(2).joined(separator: ", ") ?? Constants.emptyString),
            worldPremiereDate: worldPremiereDate,
            movieLength: String(movieLength ?? Constants.blankInt) + MainTitleForUI.min.text,
            ageRating: String(ageRating ?? Constants.blankInt) + "+",
            description: String(description?.prefix(280) ?? Constants.emptyString.prefix(0)) + Constants.emptyString,
            shortDescription: shortDescription ?? Constants.emptyString,
            ratings: ratingsObjects ?? Movie.Ratings.mock,
            actorList: MainTitleForUI.actors.text + (personsTuple?.actors.prefix(4).joined(separator: ", ") ?? Constants.emptyString)
        )
    }
}
