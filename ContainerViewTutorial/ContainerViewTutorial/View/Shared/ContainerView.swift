import Combine
import SwiftUI

struct ContainerView<ViewModel: ContainerViewModel>: ViewModelView {
    typealias ViewState = ViewModel.ViewState
    typealias MakeChildrenClosure = () -> [ViewState: AnyView]

    @ObservedObject var viewModel: ViewModel
    @ObservedObject private var loader: Loader

    @State private var content: AnyView?

    init(viewModel: ViewModel) {
        fatalError("🚨 Wrong init, use `init(viewModel:makeChildren:)` instead!")
    }

    init(viewModel: ViewModel, makeChildren: MakeChildrenClosure) {

        self.viewModel = viewModel
        self.loader = Loader(viewModel: viewModel, makeChildren: makeChildren)

        if viewModel.isReload {
            viewModel.load()

            // NOTE: 🚨 Do not change the order.
            //
            // IMPORTANT: We need to call `setUpBindings` first to trigger `setUpBindings` on VM before sending
            // `.onLoad` to the view lifecycle, otherwise the VM will not be notified.
            // Therefore, the method `setUpBindings()` inside the VM will be called before the `.onLoad()`
            // lifecycle event trigger.
            setUpBindings()

            viewModel.accessibility ?|> {
                self
                    |> Accessibility.identified(by: $0)
            }

            viewModel.viewLifecycle.send(.onLoad)
        }
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Color(white: 0.9)
            // Call the content to create the child's layout
            content
                .onAppear { viewModel.viewLifecycle.send(.onAppear) }
                .onDisappear { viewModel.viewLifecycle.send(.onDisappear) }
                .onReceive(loader.view) { self.content = $0 }
        }
    }

    // MARK: - Setup Bindings

    func setUpBindings() {
        viewModel.setUpBindings()
    }
}

// MARK: - Loader

private protocol LoaderRepresentable: ObservableObject {
    var view: Published<AnyView?>.Publisher { get }
}

extension ContainerView {

    fileprivate final class Loader: LoaderRepresentable {

        @ObservedObject private var viewModel: ViewModel

        @Published private var currentContent: AnyView?
        var view: Published<AnyView?>.Publisher { $currentContent }

        private var childrenContainer: [ViewState: AnyView]
        private var cancellable: AnyCancellable?

        init(
            viewModel: ViewModel,
            makeChildren: MakeChildrenClosure
        ) {

            self.viewModel = viewModel
            self.childrenContainer = makeChildren()

            cancellable = viewModel.viewState
                .removeDuplicates()
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { [weak self] key in
                        guard let self = self else { return }

                        self.childrenContainer.first(where: { key == $0.key }) ?|> { key, view in
                            self.currentContent = view

                            viewModel.childAccessibility(for: key) ?|> {
                                // FIXME: Ideally, we only need to set the acessibility once.
                                // This is not hapenning today because this method will be called every time that the
                                // viewState gets updated.
                                // It is not a big issue but it is an issue, right? 😔
                                // Maybe, we could move this to outside of the viewState listener and call it at
                                // Container init.
                                self.currentContent.accessibility(identifier: $0.identifier)
                            }
                        }
                    }
                )
        }

        func loadContent() -> some View { currentContent }
    }
}
