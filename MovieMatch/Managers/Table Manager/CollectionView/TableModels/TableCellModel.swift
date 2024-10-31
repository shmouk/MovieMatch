import UIKit

enum TableCellCategory {
    case currentPair
    case friends
    case user(UserModel)
    
    var title: String {
        switch self {
        case .currentPair:
            return ProfileTitleForUI.pair.text
            
        case .friends:
            return ProfileTitleForUI.friends.text
            
        case .user(let user):
            return user.name
        }
    }
    var icon: UIImage {
        switch self {
        case .currentPair:
            return ImageForUI.pair.image
            
        case .friends:
            return ImageForUI.friends.image
            
        case .user(let user):
            return user.icon ?? ImageForUI.profileDefault.image
        }
    }
}

struct TableCellModel {
    let icon: UIImage?
    let title: String
    let type: TableCellCategory

    init(type: TableCellCategory) {
        self.type = type
        self.title = type.title
        self.icon = type.icon
    }
}
