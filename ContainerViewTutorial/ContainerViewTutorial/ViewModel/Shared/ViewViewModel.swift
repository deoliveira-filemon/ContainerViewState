import Combine
import SwiftUI

enum ViewLifecycleState {
    case onLoad
    case onAppear
    case onDisappear
}

protocol ViewViewModel: ObservableObject {

    var title: String? { get }
    var navigationTitle: String? { get }

    var viewLifecycle: PassthroughSubject<ViewLifecycleState, Never> { get }

    var accessibility: Accessibility? { get }

    func setUpBindings()
    func load()
}

extension ViewViewModel {
    var navigationTitle: String? { return title }
}

extension ViewViewModel {
    var accessibility: Accessibility? { return nil }
}
