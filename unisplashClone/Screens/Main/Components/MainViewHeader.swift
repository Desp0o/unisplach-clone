//
//  MainViewHeader.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct MainViewHeader: View {
  @Bindable var vm: MainViewModel
  
  var body: some View {
    HStack {
      Image(IconsEnum.logo.rawValue)
        .imageCustomSettings(width: 18, height: 18)
      
      Spacer()
      
      Text("Unisplash")
        .customTextStyle(fontSize: 20, fontWeight: .bold)
      
      Spacer()
      
      Button {
        vm.changeGridLayout()
      } label: {
        Image(systemName: vm.gridMode ? IconsEnum.rectangle.rawValue : IconsEnum.squareGrid.rawValue)
          .imageCustomSettings(width: 18, height: 18)
          .foregroundStyle(Color.primary)
      }
    }
    .padding(20)
    .overlay(
      Rectangle()
        .frame(height: 1)
        .foregroundColor(.customGray.opacity(0.3)),
      alignment: .bottom
    )
  }
}

#Preview {
  MainViewHeader(vm: MainViewModel())
}
