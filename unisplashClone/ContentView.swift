//
//  ContentView.swift
//  unisplashClone
//
//  Created by Despo on 23.05.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
          
          Image(systemName: IconsEnum.photo.rawValue)
          Image(systemName: IconsEnum.magnifyingglass.rawValue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
