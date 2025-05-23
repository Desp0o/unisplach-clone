//
//  Image+Extension.swift
//  unisplashClone
//
//  Created by Despo on 23.05.25.
//

import SwiftUI

extension Image {
  func imageCustomSettings(
    renderingMode: Image.TemplateRenderingMode = .template,
    width: CGFloat = 26,
    height: CGFloat = 26
  ) -> some View {
    self.renderingMode(renderingMode)
      .resizable()
      .scaledToFit()
      .frame(width: width, height: height)
  }
}
