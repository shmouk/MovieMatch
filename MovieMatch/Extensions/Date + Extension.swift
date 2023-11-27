import Foundation

extension Date {
    init?(from string: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: string) else { return nil }
        self = date
    }
}

