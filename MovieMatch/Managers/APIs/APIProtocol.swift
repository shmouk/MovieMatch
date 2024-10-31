import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import Firebase

protocol APIProtocol { }

extension APIProtocol {
    func getCurrentUserTuple() -> (id: String, email: String) {
        let id = Auth.auth().currentUser?.uid ?? MainTitleForUI.undefined.text
        let email = Auth.auth().currentUser?.email ?? MainTitleForUI.undefined.text
        return (id: id, email: email)
    }
    
    func firebaseConfigure() {
        FirebaseApp.configure()
    }
    
    func databaseReference() -> DatabaseReference {
        Database.database(url: "https://moviematch-666-default-rtdb.europe-west1.firebasedatabase.app").reference()
    }
    
    func storageReference() -> StorageReference {
        Storage.storage(url: "gs://moviematch-666.appspot.com").reference()
    }
    
    func signOutAccount() {
        do {
            try Auth.auth().signOut()
            print("signOut")
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
    
    func loadImageFromURL(url: URL?, completion: @escaping ImageCompletion) {
        guard let url = url else {
            completion(.failure(RequestError.invalidURL))
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    guard let data = data,
                          let image = UIImage(data: data) else {
                        completion(.failure(RequestError.imageError))
                        return
                    }

                    completion(.success(image))
                }
            }.resume()
        }
    }

}

