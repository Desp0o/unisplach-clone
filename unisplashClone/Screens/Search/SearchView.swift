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
    VStack {
      
      VStack(spacing: 0) {
        Picker("Order by", selection: $vm.order) {
          ForEach(SearchOrder.allCases) { order in
            Text(order.displayName).tag(order)
          }
        }
        .pickerStyle(.segmented)
        Picker("Order by", selection: $vm.orientation) {
          ForEach(SearchOrientation.allCases) { orientation in
            Text(orientation.displayName).tag(orientation)
          }
        }
        .pickerStyle(.segmented)
      }
      .padding(.horizontal, 20)
      
      if !vm.searchedPhotos.isEmpty {
        HStack {
          Text("Total result: \(vm.searchResultQuantity)")
            .customTextStyle(fontColor: .customGray)
          
          Spacer()
          
          Button {
            vm.clearSearchResult()
          } label: {
            Text("Clear results")
              .customTextStyle(fontColor: .customGray)
          }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
      }
      
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
                    .customTextStyle(fontColor: .customGray)
                    .padding(.vertical, 5)
                  
                  Spacer()
                }
              }
              
              LazyVGrid(columns: [GridItem()], spacing: 20) {
                ForEach(vm.searchHistory, id: \.id) { history in
                  HStack(spacing: 20) {
                    Text(history.keyword)
                      .customTextStyle(fontSize: 20, fontColor: .customGray)
                      .onTapGesture {
                        vm.performSearchByHistory(keyword: history.keyword)
                      }
                    
                    Text("x")
                      .customTextStyle(fontColor: .customGray)
                      .frame(width: 18, height: 18)
                      .onTapGesture {
                        vm.removeSingleItemFromHistory(id: history.id)
                      }
                    
                    Spacer()
                  }
                }
              }
            }
            .padding()
          }
        } else {
          VStack {
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
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.customDark)
    .searchable(text: $vm.query, prompt: Text("Search Photo"))
    .onSubmit(of: .search) {
      vm.saveHistory()
      vm.performSearch()
    }
    .loading(isLoading: vm.isLoading)
  }
}

#Preview {
  SearchView()
    .preferredColorScheme(.dark)
}


