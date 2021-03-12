import Foundation

enum ViewModelFactory {

    typealias ContentViewModel = ContainerViewTutorial.ContentViewModel

    static func makeContentViewModel() -> ContentViewModel {
        ContentViewModel()
    }
}
