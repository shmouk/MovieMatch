import UIKit

struct CleanerCategoryCellModel {
    let icon: UIImage?
    let title: String
    let type: ProfileCategory
    let state: ProfileCategoryState

    init(type: ProfileCategory,
         state: ProfileCategoryState) {
        self.type = type
        self.state = state
        self.title = type.title

        let descriptionTitle: String
        
        switch state {
        case .good:
            descriptionTitle = type.goodSubtitleCategory
            
        default:
            descriptionTitle = type.undefinedSubtitleCategory
        }

        self.description = descriptionTitle
        self.icon = type.icon
    }
}
