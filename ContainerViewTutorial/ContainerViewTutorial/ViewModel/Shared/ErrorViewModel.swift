//
//  ErrorViewViewModel.swift
//  ContainerViewTutorial
//
//  Created by Filemon Oliveira on 03/02/2021.
//

import Foundation

enum AppError: Error {
    case contentNotAvailable
}

protocol ErrorViewModel {
    var error: Published<AppError>.Publisher { get }
}
