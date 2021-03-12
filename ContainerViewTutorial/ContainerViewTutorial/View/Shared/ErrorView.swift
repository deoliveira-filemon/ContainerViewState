//
//  ErrorView.swift
//  ContainerViewTutorial
//
//  Created by Filemon Oliveira on 03/02/2021.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        ZStack {
            Color.red
            VStack {
                VStack(spacing: 12) {
                    Image(systemName: "xmark.octagon.fill")
                        .font(.system(size: 50))
                    Text("This is the error view. 💣")

                    Button(action: {
                        // Call the retry mechanism
                    }, label: {
                        Text("Retry")
                            .foregroundColor(.red)
                    })
                    .padding()
                    .background(Color.white)
                }.foregroundColor(.white)
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
