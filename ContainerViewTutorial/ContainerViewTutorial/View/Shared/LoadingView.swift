//
//  LoadingView.swift
//  ContainerViewTutorial
//
//  Created by Filemon Oliveira on 03/02/2021.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.yellow
            VStack {
                ProgressView("🕰Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.black)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
