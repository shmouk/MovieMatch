import Foundation
import FirebaseStorage
import FirebaseDatabase
import Firebase

class ProfileAPI: APIProtocol {
    static var shared = ProfileAPI()
    let defaults = UserDefaultsManager.shared
    
    var userId: String { return getCurrentUserTuple().id }
    
    private init() { }
    
    private func userIsExist(completion: @escaping BoolCompletion) {
        databaseReference().child("users").child(userId).observeSingleEvent(of: .value) { snapshot in
            completion(snapshot.exists())
        }
    }
    
    func getDefaultsProfileInfo() -> UserModel {
        var user = defaults.getValue(forKey: "profileInfo") ?? UserModel.mock
        user.icon = UIImage(data: user.iconData ?? Data())
        return user
    }
    
    func getProfileInfo(completion: @escaping ProfileInfoRequestCompletion) {
        userIsExist() { [weak self] exist in
            guard let self = self else {
                completion(.failure(RequestError.noData))
                return
            }
            print("getProfileInfo")
            if !exist {
                self.setProfileInfo { result in completion(result)}
            } else {
                self.fetchProfileInfo(userId: self.userId) { result in completion(result)}
            }
        }
    }
    
    private func setProfileInfo(completion: @escaping ProfileInfoRequestCompletion) {
        let name = String(userId.prefix(5))
        let email = getCurrentUserTuple().email
        let defaultImage = ImageForUI.profileDefault.image
        let userId = userId

        saveImageToStorage(image: defaultImage) { [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let url):
                    let user = UserModel(icon: defaultImage, name: name, email: email, photoURL: url.absoluteString)
                    let defaultUser = user.toDictionary()
                    
                    print("setProfileInfo")
                    
                    let userRef = self?.databaseReference().child("users").child(userId)
                    userRef?.setValue(defaultUser) { error, ref in
                        if let error = error as? any Error {
                            completion(.failure(error))
                        } else {
                            self?.defaults.saveValue(user, forKey: "profileInfo")
                            print("setValue")
                            completion(.success(user))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    
    func fetchProfileInfo(userId: String, completion: @escaping ProfileInfoRequestCompletion) {
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            databaseReference().child("users").child(userId).observeSingleEvent(of: .value) { snapshot, error in
                DispatchQueue.main.async {
                    if let error = error as? any Error {
                        completion(.failure(error))
                        return
                    }
                    self.unpackSnapshot(snapshot: snapshot, completion: completion)
                }
            }
        }
    }
    
    func fetchFriendsInfo(userId: String, completion: @escaping ProfileInfoRequestCompletion) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.databaseReference().child("users").queryOrderedByKey().queryStarting(atValue: userId).queryEnding(atValue: userId + "\u{FFFF}")
                .observeSingleEvent(of: .value)  { snapshot in
                    
                    snapshot.children.forEach { child in
                        DispatchQueue.main.async {
                            guard let childSnapshot = child as? DataSnapshot else {
                                completion(.failure(RequestError.noData))
                                return
                            }
                            
                            self?.unpackSnapshot(snapshot: childSnapshot, completion: completion)
                        }
                    }
                }
        }
    }
    
    private func unpackSnapshot(snapshot: DataSnapshot, completion: @escaping ProfileInfoRequestCompletion) {
        guard let userDict = snapshot.value as? [String: Any],
              let name = userDict["name"] as? String,
              let email = userDict["email"] as? String,
              let photoURLString = userDict["photoURL"] as? String else {
            completion(.failure(RequestError.noData))
            return
        }
        let photoURL = URL(string: photoURLString)
        loadImageFromURL(url: photoURL) { result in
            switch result {
            case .success(let image):
                let user = UserModel(icon: image, name: name, email: email, photoURL: photoURLString)
                self.defaults.saveValue(user, forKey: "profileInfo")
                completion(.success(user))
                print("fetchProfileInfo")
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func saveImageToStorage(image: UIImage, completion: @escaping URLResult) {
        guard let imageData = image.pngData() else {
            completion(.failure(RequestError.imageError))
            return
        }
        let ref = storageReference().child("userIcons").child(userId)
        
        DispatchQueue.global(qos: .userInitiated).async {
            ref.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    print("putData")
                    ref.downloadURL(completion: completion)
                }
            }
        }
    }
}
