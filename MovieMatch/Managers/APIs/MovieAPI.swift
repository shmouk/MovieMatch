import Foundation
import FirebaseStorage
import FirebaseDatabase
import Firebase

class MovieAPI: APIProtocol {
    static var shared = MovieAPI()
    let defaults = UserDefaultsManager.shared
    
    var userId: String { return getCurrentUserTuple().id }
    
    private init() { }
    
    func setMovieId(isFavorite: Bool, id: Int, completion: @escaping RequestCompletion) {
        let userRef = databaseReference().child("movieIds").child(userId).child(String(id))
        userRef.setValue(isFavorite) { (error, ref) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(.successUpdate))
            }
        }
    }
    
    func getMovieIds(completion: @escaping IntCompletion) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            let userRef = self.databaseReference().child("movieIds").child(self.userId)
            userRef.observeSingleEvent(of: .value) { snapshot in
                var movieIds = [Int]()
                for child in snapshot.children {
                    let childSnapshot = child as! DataSnapshot
                    guard let _ = childSnapshot.value as? Bool,
                          let id = Int(childSnapshot.key) else {
                        completion(movieIds)
                        return
                    }
                    movieIds.append(id)
                }
                completion(movieIds)
            }
        }
    }
}
