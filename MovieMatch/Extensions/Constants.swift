import Foundation

final class Constants {
    static let blankString: String = "about:blank"
    static let blankInt = 0
    static let blankDouble = 0.0
    static let emptyString: String = "..."
    static let radii: CGFloat = 16

    static var randomInt: Int {
        Int.random(in: 1...999999)
    }

    static func formattedDate(isoDate: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        guard let isoDate = isoDate,
              let date = dateFormatter.date(from: isoDate) else {
            return MainTitleForUI.noDate.text
        }
        
        dateFormatter.dateFormat = "d MMMM yyyy"
        let resultString = dateFormatter.string(from: date)
        return resultString
    }
}
