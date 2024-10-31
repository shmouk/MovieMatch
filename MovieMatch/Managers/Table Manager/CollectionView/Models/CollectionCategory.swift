import UIKit

enum CollectionCategory {
    case likedMovie
    
    var title: String {
        switch self {
        case .likedMovie:
            return ProfileTitleForUI.pair.text
        }
    }
    
    var icon: UIImage {
        switch self {
        case .likedMovie:
            return ImageForUI.pair.image
            
        }
    }
}
