import Foundation
import FirebaseAuth
import UIKit

typealias BoolCompletion = (Bool) -> Void
typealias TapHandler = () -> Void
typealias RegisterResult = (AuthDataResult?, Error?) -> Void
typealias StringCompletion = (String?) -> Void
typealias MovieResult = (Result<Movie, Error>) -> Void
typealias MovieCompletion = (Movie?) -> Void
typealias ImageCompletion = (UIImage) -> Void
typealias MovieActorsCompletion = ([Movie.Actor]?) -> Void

enum RequestError: Error {
    case invalidEmail
    case invalidPassword
    case invalidRegister
    case invalidSignIn
    case noData
    case invalidRequest
    case invalidJson
    case emptyFields
    
    var info: String {
        switch self {
            
        case .invalidEmail:
            return "invalidEmail".localized

        case .invalidPassword:
            return "invalidPassword".localized
            
        case .invalidRegister:
            return "invalidRegister".localized
            
        case .invalidSignIn:
            return "invalidSignIn".localized
            
        case .emptyFields:
            return "emptyFields".localized
            
        case .noData:
            return "noData".localized
            
        case .invalidRequest:
            return "invalidRequest".localized
            
        case .invalidJson:
            return "invalidJson".localized
        }
    }
}

enum RequestComplete {
    case successSignIn
    case successRegister
    
    var info: String {
        switch self {
            
        case .successSignIn:
            return "successSignIn".localized
            
        case .successRegister:
            return "successRegister".localized
        }
    }
}

enum TitleForUI {
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
    
    var text: String {
        switch self {
            
        case .match:
            "Match".localized
            
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
            
        case .bigBold:
            UIFont.boldSystemFont(ofSize: 18.0)
        }
    }
}
