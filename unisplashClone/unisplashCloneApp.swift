//
//  unisplashCloneApp.swift
//  unisplashClone
//
//  Created by Despo on 23.05.25.
//

import SwiftUI

@main
struct unisplashCloneApp: App {
  @AppStorage("selectedTheme") private var selectedTheme: String = AppTheme.system.rawValue

    var body: some Scene {
        WindowGroup {
          NavigationStack {
            TabbarView()
              .preferredColorScheme(AppTheme(rawValue: selectedTheme)?.colorScheme)
          }
        }
    }
}
