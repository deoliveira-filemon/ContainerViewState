import Foundation

enum ViewFactory {

    typealias ContentView = ContainerViewTutorial.ContentView<ContentViewModel>

    static func makeContentView() -> ContentView {

        let viewModel = ViewModelFactory.makeContentViewModel()

        return ContentView(viewModel: viewModel) {
            [
                .loading: LoadingView().erased,
                .results: NavigationLazyView(ContentResultsView()).erased,
                .error: NavigationLazyView(ErrorView()).erased
            ]
        }
    }
}
