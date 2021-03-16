import Combine
import Foundation

enum ContentViewState: Hashable {
    case loading
    case results
    case error
}

protocol ContentViewModelRepresentable: ContainerViewModel {}

// MARK: - Accessibility

extension ContentViewModelRepresentable {
    var accessibility: Accessibility? { .contentView }
}

final class ContentViewModel: ContentViewModelRepresentable & ErrorViewModel {
    typealias ViewState = ContentViewState

    // ContainerViewModel
    @Published private var viewStatePublisher: ViewState = .loading // View initial state
    var viewState: Published<ContentViewState>.Publisher { $viewStatePublisher }
    var isReload: Bool = true

    // ViewModelView
    var title: String? = "ContentViewModel Tutorial"
    var viewLifecycle: PassthroughSubject<ViewLifecycleState, Never>

    // ErrorViewModel
    @Published private var errorPublisher: AppError = .contentNotAvailable
    var error: Published<AppError>.Publisher { $errorPublisher }

    private var cancellables = Set<AnyCancellable>()
//    🙏🏻 We can use generic scheduler to inject a custom scheduler for our network layer for example.
//    So we can control what scheduler is used in classes, functions, etc.
//    https://github.com/pointfreeco/combine-schedulers/blob/main/Sources/CombineSchedulers/AnyScheduler.swift
//    private let scheduler: AnySchedulerOf<DispatchQueue>
    
    init(/*scheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()*/) {
//        self.scheduler = scheduler
        self.viewLifecycle = PassthroughSubject<ViewLifecycleState, Never>()
    }

    func setUpBindings() {
        print("ContentVieModel setUpBindings.")

        viewLifecycle
            .eraseToAnyPublisher()
//            Apply the scheduler
//            .receive(on: scheduler)
            .onLoad { [weak self] in
                guard let self = self else { return }

                // Load your data and update the view state on result
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    // First load got an error 🚨
                    self.viewStatePublisher = .error
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    // but the retry worked 👏🏻
                    self.viewStatePublisher = .results
                }
            }
            .store(in: &cancellables)
    }

    func load() {
        print("ContentVieModel loaded.")
        isReload = false
    }

    func childAccessibility(for viewState: ContentViewState) -> Accessibility? {
        switch viewState {
        case .loading:
            print("Load .loading accessibility")
            return .contentViewLoading
        case .error:
            print("Load .error accessibility")
            return .contentViewError
        case .results:
            print("Load .results accessibility")
            return .contentViewResults
//        case .littlePotato:
//            print("Load .littlePotato accessibility")
//            return .contentLittlePotato
        }
    }
}
