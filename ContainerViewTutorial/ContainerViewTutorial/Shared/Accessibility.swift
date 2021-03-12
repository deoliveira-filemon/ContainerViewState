import SwiftUI

enum Accessibility: String {

    // MARK: - ContentView

    case contentView = "content_view"
    case contentViewLoading = "content_view_loading"
    case contentViewError = "content_view_error"
    case contentViewResults = "content_view_results"
    case contentLittlePotato = "content_little_potato"
}

// MARK: - Identifier

extension Accessibility {

    var identifier: String {
        return self.rawValue
    }
}

// MARK: - Helpers

extension Accessibility {

    static func identified<T: View>(by identifier: Accessibility) -> (T) -> Void {

        return {
            _ = $0.accessibility(identifier: identifier.identifier)
        }
    }

    static func labelled<T: View>(by label: Accessibility) -> (T) -> Void {

        return {
            _ = $0.accessibility(label: Text(label.identifier))
        }
    }
}
