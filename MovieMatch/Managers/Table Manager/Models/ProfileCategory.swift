import UIKit

enum PRofileCategory {
    case calendar
    case contacts
    case gallery
    case guide

    var title: String {
        switch self {
        case .calendar:
            return R.string.localizable.cleanerCategoryCalendarTitle()
            
        case .contacts:
            return R.string.localizable.cleanerCategoryContactsTitle()
            
        case .gallery:
            return R.string.localizable.cleanerCategoryGalleryTitle()
            
        case .guide:
            return R.string.localizable.cleanerCategoryGuideTitle()
        }
    }

    var icon: UIImage? {
        switch self {
        case .calendar:
            return R.image.iconCleanerCategoryLogoCalendar()
            
        case .contacts:
            return R.image.iconCleanerCategoryLogoContacts()
            
        case .gallery:
            return R.image.iconCleanerCategoryLogoGallery()
            
        case .guide:
            return R.image.iconCleanerCategoryLogoGuide()
        }
    }
    
    var backgroundImage: UIImage? {
        switch self {
        case .calendar:
            return R.image.iconCleanerCategoryBgCalendar()
            
        case .contacts:
            return R.image.iconCleanerCategoryBgContacts()
            
        case .gallery:
            return R.image.iconCleanerCategoryBgGallery()
            
        case .guide:
            return R.image.iconCleanerCategoryBgGuide()
        }
    }

    var undefinedSubtitleCategory: String {
        R.string.localizable.cleanerCategoryAccessNeeded()
    }

    var goodSubtitleCategory: String {
        switch self {
        case .calendar:
            return R.string.localizable.cleanerCategoryCalendarSubtitle()
            
        case .contacts:
            return R.string.localizable.cleanerCategoryContactsSubtitle()
            
        case .gallery:
            return R.string.localizable.cleanerCategoryGallerySubtitle()
            
        case .guide:
            return R.string.localizable.cleanerCategoryGuideSubtitle()
        }
    }
}

enum CleanerCategoryState: Int {
    case good
    case undefined

    var subtitleColor: UIColor? {
        R.color.commonSubtitle()
    }
}
