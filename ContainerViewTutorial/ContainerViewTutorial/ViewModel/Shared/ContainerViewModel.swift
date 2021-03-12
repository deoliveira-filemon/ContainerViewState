import Combine
import Foundation

protocol ContainerViewModel: ViewViewModel {
    associatedtype ViewState: Hashable

    var viewState: Published<ViewState>.Publisher { get }
    var isReload: Bool { get }

    func childAccessibility(for viewState: ViewState) -> Accessibility?
}

extension ContainerViewModel {
    var accessibility: Accessibility? { nil }
}
