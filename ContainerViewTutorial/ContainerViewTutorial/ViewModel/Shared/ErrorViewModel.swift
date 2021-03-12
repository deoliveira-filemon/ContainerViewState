import Foundation

enum AppError: Error {
    case contentNotAvailable
}

protocol ErrorViewModel {
    var error: Published<AppError>.Publisher { get }
}
