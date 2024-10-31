import Foundation
import FirebaseAuth
import UIKit

typealias BoolCompletion = (Bool) -> Void
typealias Handler = () -> Void
typealias RegisterResult = (AuthDataResult?, Error?) -> Void
typealias StringCompletion = (String?) -> Void
typealias IntCompletion = ([Int]) -> Void
typealias URLResult = (Result<URL, Error>) -> Void
typealias MovieResult = (Result<Movie, Error>) -> Void
typealias RequestCompletion = (Result<RequestComplete, Error>) -> Void
typealias MovieCompletion = (Movie?) -> Void
typealias MovieDataCompletion = ([Movie]) -> Void
typealias ImageCompletion = (Result<UIImage, Error>) -> Void
typealias PersonsTuple = (actors: [String], directors: [String])
typealias ProfileInfoCompletion = (UserModel) -> Void
typealias ProfileInfoRequestCompletion = (Result<UserModel, Error>) -> Void


enum RequestError: Error {
    case invalidEmail
    case invalidPassword
    case invalidRegister
    case invalidSignIn
    case noData
    case invalidRequest
    case invalidJson
    case invalidURL
    case emptyFields
    case imageError
    case authError
    
    var info: NSError {
        switch self {
            
        case .invalidEmail:
            NSError(domain: "invalidEmail".localized, code: 401, userInfo: nil)

        case .invalidPassword:
            NSError(domain: "invalidPassword".localized, code: 401, userInfo: nil)
            
        case .invalidRegister:
            NSError(domain: "invalidRegister".localized, code: 401, userInfo: nil)
            
        case .invalidSignIn:
            NSError(domain: "invalidSignIn".localized, code: 401, userInfo: nil)
            
        case .emptyFields:
            NSError(domain: "emptyFields".localized, code: 400, userInfo: nil)
            
        case .noData:
            NSError(domain: "noData".localized, code: 404, userInfo: nil)
            
        case .invalidRequest:
            NSError(domain: "invalidRequest".localized, code: 400, userInfo: nil)
            
        case .invalidJson:
            NSError(domain: "invalidJson".localized, code: 400, userInfo: nil)
            
        case .invalidURL:
            NSError(domain: "invalidURL".localized, code: 400, userInfo: nil)
            
        case .imageError:
            NSError(domain: "imageError".localized, code: 404, userInfo: nil)
            
        case .authError:
            NSError(domain: "authError".localized, code: 403, userInfo: nil)
        }
    }
}

enum RequestComplete {
    case successSignIn
    case successRegister
    case successUpdate
    
    var info: String {
        switch self {
            
        case .successSignIn:
            "successSignIn".localized
            
        case .successRegister:
            "successRegister".localized
            
        case .successUpdate:
            "successUpdate".localized
        }
    }
}

enum ProfileTitleForUI {
    case pair
    case friends

    var text: String {
        switch self {
        case .pair:
            "pair".localized
            
        case .friends:
            "friends".localized
            
        default:
            "undefined"
        }
    }
}

enum MainTitleForTabBar {
    case profile
    case match
    case favorite
    
    var text: String {
        switch self {
            
        case .match:
            "match".localized
            
        case .profile:
            "profile".localized
            
        case .favorite:
            "favorite".localized
        }
    }
}
        
enum MainTitleForUI {
    case email
    case password
    case enterEmail
    case enterPassword
    case signIn
    case register
    case createAccount
    case match
    case undefined
    case noDate
    case min
    case actors
    case countries
    case year
    case directors
    
    var text: String {
        switch self {
            
        case .match:
            "match".localized
            
        case .email:
            "email".localized + ":"
            
        case .password:
            "password".localized + ":"
            
        case .enterEmail:
            "emailPlaceholder".localized

        case .enterPassword:
            "passwordPlaceholder".localized

        case .signIn:
            "signIn".localized

        case .register:
            "register".localized
            
        case .createAccount:
            "createAccount".localized
            
        case .noDate:
            "noDate".localized
            
        case .min:
            " " + "minute".localized
            
        case .actors:
            "actors".localized + ": "
            
        case .countries:
            "countries".localized + ": "
            
        case .year:
            "year".localized + ": "
            
        case .directors:
            "directors".localized + ": "
            
        case .undefined:
            "undefined"
        }
    }
}

enum FontForUI {
    case regular
    case small
    case big
    case defaultBold
    case smallBold
    case mediumBold
    case bigBold
    
    var size: UIFont {
        switch self {
            
        case .regular:
            UIFont.systemFont(ofSize: 16.0)
            
        case .small:
            UIFont.systemFont(ofSize: 12.0)
            
        case .big:
            UIFont.systemFont(ofSize: 18.0)
            
        case .defaultBold:
            UIFont.boldSystemFont(ofSize: 16.0)
            
        case .smallBold:
            UIFont.boldSystemFont(ofSize: 12.0)
            
        case .mediumBold:
            UIFont.boldSystemFont(ofSize: 18.0)
            
        case .bigBold:
            UIFont.boldSystemFont(ofSize: 22.0)
        }
    }
}

enum ImageForUI: String, CaseIterable {
    case arrowRight = "arrowRightIcon"
    case approve = "approveIcon"
    case movieMatch = "MovieMatchIcon"
    case discard = "discardIcon"
    case mock = "logoIcon"
    case plus = "plusIcon"
    case profileDefault = "profileIcon"
    case profile = "profileIconDefault"
    case friends = "friendsIcon"
    case pair = "pairIcon"
    
    var image: UIImage {
        UIImage(named: rawValue) ?? UIImage()
    }
}

enum ColorForUI: String, CaseIterable {
    case fg = "FgColor"
    case fgLight = "FgColorLight"
    case bg = "BgColor"
    case tint = "TintColor"
    case other = "OtherColor"

    var color: UIColor {
        UIColor(named: rawValue) ?? UIColor(.black)
    }
}
