//
//  ViewModelFactory.swift
//  ContainerViewTutorial
//
//  Created by Filemon Oliveira on 03/02/2021.
//

import Foundation

enum ViewModelFactory {

    typealias ContentViewModel = ContainerViewTutorial.ContentViewModel

    static func makeContentViewModel() -> ContentViewModel {
        ContentViewModel()
    }
}
