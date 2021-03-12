//
//  ContainerViewTutorialApp.swift
//  ContainerViewTutorial
//
//  Created by Filemon Oliveira on 03/02/2021.
//

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
