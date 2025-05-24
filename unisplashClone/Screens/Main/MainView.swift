//
//  MainView.swift
//  unisplashClone
//
//  Created by Despo on 23.05.25.
//

import SwiftUI

struct MainView: View {
  @State var vm = MainViewModel()
  @State private var scrollToTop: UUID = UUID()
  
  var body: some View {
    VStack(spacing: 0) {
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
          Image(systemName: IconsEnum.squareGrid.rawValue)
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
      
      ScrollViewReader { proxy in
        ScrollView {
          LazyVGrid(columns: vm.gridMode
                    ? [GridItem(), GridItem()]
                    : [GridItem()], spacing: vm.gridMode ? 4 : 0) {
            ForEach(vm.images.indices, id: \.self) { index in
              let photo = vm.images[index]
              LayoutPhotoView(url: photo.urls.small, isGridMode: vm.gridMode)
                .onAppear {
                  if index == vm.images.count - 4 {
                    vm.page += 1
                    vm.fetchImages()
                  }
                }
            }
          }
        }
        .id(scrollToTop)
        .scrollIndicators(.hidden)
        .opacity(vm.isDissapeared ? 0 : 1)
        .onChange(of: vm.gridMode) {
          scrollToTop = UUID()
          proxy.scrollTo(scrollToTop, anchor: .top)
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .background(.customDark)
    .task {
      vm.fetchImages()
    }
  }
}

#Preview {
  MainView()
}
