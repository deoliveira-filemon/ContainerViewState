import SwiftUI

struct ContentView<ViewModel: ContentViewModelRepresentable>: ContainerViewProtocol {
    typealias ViewState = ViewModel.ViewState

    @StateObject var viewModel: ViewModel
    let makeChildren: MakeChildrenClosure

    init(viewModel: ViewModel) {
        fatalError("🚨 Wrong init, use `init(viewModel:makeChildren:)` instead!")
    }

    init(viewModel: ViewModel, makeChildrenClosure: @escaping MakeChildrenClosure) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.makeChildren = makeChildrenClosure
    }

    // MARK: - Body

    var body: some View {
        ContainerView<ViewModel>(viewModel: viewModel, makeChildren: makeChildren)
    }

    func setUpBindings() {}
}
