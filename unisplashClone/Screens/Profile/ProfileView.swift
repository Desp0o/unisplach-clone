//
//  ProfileView.swift
//  unisplashClone
//
//  Created by Despo on 23.05.25.
//

import SwiftUI

struct ProfileView: View {
  @AppStorage("selectedTheme") private var selectedTheme: String = AppTheme.system.rawValue
  
  var body: some View {
    Picker("Appearance", selection: $selectedTheme) {
      ForEach(AppTheme.allCases) { theme in
        Text(theme.displayName).tag(theme.id)
      }
    }
    .pickerStyle(.segmented)
    .padding()
  }
}

#Preview {
  ProfileView()
}
