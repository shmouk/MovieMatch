import Foundation
import UIKit

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    func saveValue<T: Codable>(_ value: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            defaults.set(encoded, forKey: key)
        }
    }

    func getValue<T: Codable>(forKey key: String) -> T? {
        guard let encodedData = defaults.data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: encodedData)
    }

    
    func removeData(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
