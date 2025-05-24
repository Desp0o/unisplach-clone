//
//  MainViewTryAgainButton.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct MainViewTryAgainButton: View {
  @Bindable var vm: MainViewModel
  
  var body: some View {
    VStack(spacing: 10) {
      Text("Something Went Wrong!")
        .customTextStyle(fontWeight: .semibold, fontColor: .customGray)
      
      Button {
        vm.isloading = true
        vm.fetchImages()
      } label: {
        Text("Try again")
          .customTextStyle(fontWeight: .semibold, fontColor: .customGray)
          .padding(.horizontal, 10)
          .padding(.vertical, 5)
          .background(.thinMaterial)
          .clipShape(RoundedRectangle(cornerRadius: 8))
      }
    }
    .frame(maxHeight: .infinity)
  }
}

#Preview {
  MainViewTryAgainButton(vm: MainViewModel())
}
