//
//  SearchView.swift
//  unisplashClone
//
//  Created by Despo on 23.05.25.
//

import SwiftUI

struct SearchView: View {
  @State var vm = SearchViewModel()
  
  var body: some View {
    NavigationStack {
      VStack {        
        ScrollView {
          if vm.searchedPhotos.isEmpty {
            if vm.searchHistory.isEmpty {
              Text("No History")
                .customTextStyle(fontColor: .customGray)
                .offset(y: 20)
            } else {
              VStack {
                
                Button {
                  vm.clearSearchHistory()
                } label: {
                  HStack {
                    Text("Clear History")
                      .padding(.horizontal, 10)
                      .padding(.vertical, 5)
                      .background(.customGray)
                      .clipShape(RoundedRectangle(cornerRadius: 8))
                      .foregroundColor(.white)
                    
                    Spacer()
                  }
                }
                
                LazyVGrid(columns: [GridItem()], spacing: 20) {
                  ForEach(vm.searchHistory, id: \.id) { history in
                    HStack {
                      Text(history.keyword)
                        .customTextStyle(fontSize: 20, fontColor: .customGray)
                      
                      Spacer()
                    }
                  }
                }
              }
              .padding()
            }
          } else {
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 4) {
              ForEach(vm.searchedPhotos, id: \.id) { photo in
                
                CachedAsyncImage(url: URL(string: photo.urls.small))
                  .scaledToFill()
                  .frame(width: UIScreen.main.bounds.width / 2, height: 150)
                  .contentShape(Rectangle())
                  .clipped()
              }
            }
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.customDark)
      .searchable(text: $vm.query, prompt: Text("Search Photo"))
      .onSubmit(of: .search) {
        vm.performSearch()
      }
    }
  }
}

#Preview {
  SearchView()
    .preferredColorScheme(.dark)
}


