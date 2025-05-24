//
//  SelectedMark.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct SelectedMark: View {
  let isLongPressed: Bool
  let isSelected: Bool
  
  var body: some View {
    if isLongPressed {
      Image(systemName: isSelected ? IconsEnum.checkmarkCircle.rawValue : IconsEnum.circle.rawValue)
        .foregroundStyle(isSelected ? .green : .customGray)
        .frame(width: 32, height: 32)
        .padding(6)
    }
  }
}
