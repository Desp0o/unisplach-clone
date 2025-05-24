//
//  Text+Extension.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

extension Text {
  func customTextStyle(fontSize: CGFloat = 16, fontWeight: Font.Weight = .regular, fontColor: Color = Color.primary) -> some View {
    self.font(.system(size: fontSize, weight: fontWeight, design: .rounded))
      .foregroundStyle(fontColor)
  }
}
