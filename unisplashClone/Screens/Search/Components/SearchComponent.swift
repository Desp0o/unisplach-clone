//
//  SearchComponent.swift
//  unisplashClone
//
//  Created by Despo on 25.05.25.
//

import SwiftUI

struct SearchComponent: View {
  @Bindable var vm: SearchViewModel
  @FocusState private var isSearchFocused: Bool
  
  var body: some View {
    HStack {
      HStack {
        Image(systemName: IconsEnum.magnifyingglass.rawValue)
          .foregroundColor(.gray)
          .frame(width: 20, height: 20)
        
        TextField("Search Photo", text: $vm.query)
          .focused($isSearchFocused)
          .onSubmit {
            if !vm.query.isEmpty {
              vm.searchedPhotos.removeAll()
              vm.saveHistory()
              vm.performSearch()
              isSearchFocused = false
            }
          }
      }
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(.customGray.opacity(0.2))
      .cornerRadius(8)
      
      if !vm.query.isEmpty {
        Button {
          vm.query = ""
          vm.isResultatEmpty = false
        } label: {
          Text("Cancel")
            .customTextStyle(fontColor: .customGray)
        }
      }
    }
    .padding(.horizontal, 20)
    .animation(.default, value: vm.query)
    
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
  }
}

#Preview {
  SearchComponent(vm: SearchViewModel(userDefaultManager: UserDefaultsManager()))
}
