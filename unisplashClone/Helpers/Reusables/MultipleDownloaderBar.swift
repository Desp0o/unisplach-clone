//
//  MultipleDownloaderBar.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct MultipleDownloaderBar: View {
  let deselect: () -> Void
  let download: () -> Void
  
    var body: some View {
      HStack {
        Button {
          deselect()
        } label: {
          Text("Cancel")
            .customTextStyle(fontColor: .red)
        }
        
        Spacer()
        
        Button {
          download()
        } label: {
          Text("Download")
            .customTextStyle(fontColor: .white)
            .padding(5)
            .background(.blue.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
      }
      .padding()
      .background(.customDark)
    }
}
