//
//  SearchOrder.swift
//  unisplashClone
//
//  Created by Despo on 25.05.25.
//


enum SearchOrder: String, CaseIterable, Identifiable {
    case relevant = "relevant"
    case latest = "latest"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .relevant: 
          return "Relevant"
        case .latest: 
          return "Latest"
        }
    }
}

enum SearchOrientation: String, CaseIterable, Identifiable {
  case all = ""
  case portrait = "portrait"
  case landscape = "landscape"
  case square = "squarish"
  
  var id: String { rawValue }
  
  var displayName: String {
    switch self {
    case .all: 
      return "All"
    case .landscape:
      return "Landscape"
    case .portrait:
      return "Portrait"
    case .square:
      return "Square"
    }
  }
}
