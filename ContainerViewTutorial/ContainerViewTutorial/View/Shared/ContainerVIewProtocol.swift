//
//  ContainerVIewProtocol.swift
//  ContainerViewTutorial
//
//  Created by Filemon Oliveira on 03/02/2021.
//

import SwiftUI

protocol ContainerViewProtocol: ViewModelView {
    associatedtype ViewState: Hashable
    typealias MakeChildrenClosure = () -> [ViewState: AnyView]

    var makeChildren: MakeChildrenClosure { get }
}
