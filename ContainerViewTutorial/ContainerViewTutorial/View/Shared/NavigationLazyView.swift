import SwiftUI

struct NavigationLazyView<T: View>: View {

    let build: () -> T

    init(_ build: @autoclosure @escaping () -> T) {
        self.build = build
    }

    var body: T {
        build()
    }
}
