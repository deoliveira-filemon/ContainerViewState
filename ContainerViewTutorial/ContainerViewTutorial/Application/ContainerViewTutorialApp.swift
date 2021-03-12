import SwiftUI

@main
struct ContainerViewTutorialApp: App {
    var body: some Scene {
        WindowGroup {
            ViewFactory.makeContentView()
                .ignoresSafeArea()
        }
    }
}
