import UIKit.UIImage
import Foundation

struct UserModel: Codable {
    var icon: UIImage?
    var iconData: Data?
    var name: String
    var email: String
    var photoURL: String
    
    enum CodingKeys: String, CodingKey  {
        case iconData, name, email, photoURL
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        //        icon = try container.decode(UIImage.self, forKey: .icon)
//        name = try container.decode(String.self, forKey: .name)
//        email = try container.decode(String.self, forKey: .email)
//        photoURL = try container.decode(String.self, forKey: .photoURL)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//        try container.encode(email, forKey: .email)
//        try container.encode(photoURL, forKey: .photoURL)
//        
//    }
    
    init(icon: UIImage? = nil, name: String, email: String, photoURL: String) {
        self.icon = icon
        self.iconData = icon?.pngData()
        self.name = name
        self.email = email
        self.photoURL = photoURL
    }
}

extension UserModel {
    func toDictionary() -> [String: String] {
        return ["name": name, "email": email, "photoURL": photoURL]
    }
}

extension UserModel {
    static var mock: UserModel = .mock
}
