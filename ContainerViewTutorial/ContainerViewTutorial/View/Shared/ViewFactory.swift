import Foundation
import SwiftUI

enum ViewFactory {

    typealias ContentView = ContainerViewTutorial.ContentView<ContentViewModel>

    static func makeContentView() -> ContentView {

        let viewModel = ViewModelFactory.makeContentViewModel()

        return ContentView(viewModel: viewModel) {
            [
                .loading: LoadingView().erased,
                .results: NavigationLazyView(ContentResultsView()).erased,
                .error: NavigationLazyView(ErrorView()).erased,
            ]
        }
    }
}

//private struct LittlePotatoView: View {
//
//    var body: some View {
//        ZStack {
//            Color.pink
//            Text("YAY 😁 ... This is the little potato view.🥔")
//        }
//    }
//}
