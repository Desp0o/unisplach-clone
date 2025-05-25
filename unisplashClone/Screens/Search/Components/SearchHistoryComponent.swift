//
//  SearchHistoryComponent.swift
//  unisplashClone
//
//  Created by Despo on 25.05.25.
//

import SwiftUI

struct SearchHistoryComponent: View {
  @Bindable var vm: SearchViewModel
  
  var body: some View {
    VStack {
      if vm.searchHistory.isEmpty {
        Text("No History")
          .customTextStyle(fontColor: .customGray)
          .offset(y: 20)
      } else {
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
    }
    .padding()
  }
}
