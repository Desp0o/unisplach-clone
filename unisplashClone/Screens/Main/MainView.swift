//
//  MainView.swift
//  unisplashClone
//
//  Created by Despo on 23.05.25.
//

import SwiftUI

struct MainView: View {
  @State var vm = MainViewModel()
  
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
        
        ScrollView {
          LazyVGrid(columns: [GridItem()], spacing: 0) {
            ForEach(vm.images, id: \.id) { photo in
              AsyncImage(url: URL(string: photo.urls.small)) { image in
               
                  image
                    .resizable()
                    .scaledToFit()
                    .clipped()
              } placeholder: {
                ProgressView()
              }
            }
          }
          //
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
