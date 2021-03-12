import SwiftUI

protocol ContainerViewProtocol: ViewModelView {
    associatedtype ViewState: Hashable
    typealias MakeChildrenClosure = () -> [ViewState: AnyView]

    var makeChildren: MakeChildrenClosure { get }
}
