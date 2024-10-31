import Foundation

class Bindable<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?

    var value: T? {
        didSet {
            if let newValue = value {
                listener?(newValue)
            }
        }
    }

    init(_ value: T) {
        self.value = value
    }
    
    init() {
        self.value = nil
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
    }
}


