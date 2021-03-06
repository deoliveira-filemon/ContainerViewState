import Combine

extension AnyPublisher where Output == ViewLifecycleState, Failure == Never {

    func onLoad(_ perform: @escaping () -> Void) -> AnyCancellable {
        return self.filter { $0 == .onLoad }
            .sink { _ in perform() }
    }

    func onAppear(_ perform: @escaping () -> Void) -> AnyCancellable {
        return self.filter { $0 == .onAppear }
            .sink { _ in perform() }
    }
}
