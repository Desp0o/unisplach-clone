//
//  TabbarView.swift
//  unisplashClone
//
//  Created by Despo on 23.05.25.
//

import SwiftUI

struct TabbarView: View {
  @State private var activeIndex: Int = 0
  let tabbarItems: [String] = [
    IconsEnum.photo.rawValue,
    IconsEnum.magnifyingglass.rawValue,
    IconsEnum.person.rawValue
  ]
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        switch activeIndex {
        case 0:
          MainView()
        case 1:
          SearchView()
        case 2:
          ProfileView()
        default:
          ContentUnavailableView {
            Text("OoOpsss.")
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.customDark)
      .overlay {
        VStack {
          Spacer()
          
          HStack {
            ForEach(tabbarItems.indices, id: \.self) { index in
              let item = tabbarItems[index]
              
              Spacer()
              
              Image(systemName: item)
                .imageCustomSettings()
                .foregroundStyle(index == activeIndex ? Color.primary : .customGray)
                .onTapGesture {
                  activeIndex = index
                }
              
              Spacer()
            }
          }
          .frame(maxWidth: .infinity)
          .frame(height: 50)
          .background(.thinMaterial)
          .ignoresSafeArea()
        }
      }
    }
  }
}

#Preview {
  TabbarView()
    .preferredColorScheme(.dark)
}
