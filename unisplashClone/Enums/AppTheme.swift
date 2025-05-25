//
//  AppTheme.swift
//  unisplashClone
//
//  Created by Despo on 25.05.25.
//

import SwiftUICore

enum AppTheme: String, CaseIterable, Identifiable {
  case system, light, dark
  
  var id: String { self.rawValue }
  
  var colorScheme: ColorScheme? {
    switch self {
    case .system: return nil
    case .light: return .light
    case .dark: return .dark
    }
  }
  
  var displayName: String {
    switch self {
    case .system:
      return "System"
    case .light:
      return "Light"
    case .dark:
      return "Dark"
    }
  }
}
