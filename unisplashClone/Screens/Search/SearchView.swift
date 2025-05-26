//
//  SearchView.swift
//  unisplashClone
//
//  Created by Despo on 23.05.25.
//

import SwiftUI

struct SearchView: View {
  @State var vm = SearchViewModel()
  @State private var selectedPhoto: PhotoResponseModel? = nil
  @FocusState private var isSearchFocused: Bool
  
  var body: some View {
    VStack {
      SearchComponent(vm: vm)
      
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
      
      if !vm.isLoading {
        ScrollView {
          if vm.searchedPhotos.isEmpty && !vm.isResultatEmpty {
            SearchHistoryComponent(vm: vm)
          } else {
            VStack {
              if vm.isResultatEmpty {
                Text("No photos found!")
                  .customTextStyle(fontColor: .customGray)
                  .offset(y: 40)
              } else {
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 4) {
                  ForEach(vm.searchedPhotos, id: \.id) { photo in
                    let isSelected = vm.selectedPhotos.contains(photo.urls.small)
                    
                    CachedAsyncImage(url: URL(string: photo.urls.small))
                      .scaledToFill()
                      .frame(width: UIScreen.main.bounds.width / 2, height: 150)
                      .contentShape(Rectangle())
                      .clipped()
                      .onTapGesture {
                        withAnimation(.snappy(duration: 0.1)) {
                          if vm.isLongPressed {
                            if isSelected {
                              vm.selectedPhotos.remove(photo.urls.small)
                            } else {
                              vm.selectedPhotos.insert(photo.urls.small)
                            }
                          } else {
                            selectedPhoto = photo
                          }
                        }
                      }
                      .onLongPressGesture {
                        withAnimation {
                          vm.isLongPressed = true
                        }
                      }
                      .overlay(alignment: .topTrailing) {
                        SelectedMark(
                          isLongPressed: vm.isLongPressed,
                          isSelected: isSelected
                        )
                      }
                      .task {
                        vm.infinityScroll(id: photo.id)
                      }
                  }
                }
              }
            }
          }
        }
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .background(Color.customDark)
    .overlay {
      if vm.isLongPressed {
        VStack {
          Spacer()
          
          MultipleDownloaderBar {
            vm.deselectImages()
          } download: {
            vm.downloadPhotos()
          }
        }
        .padding(.bottom, 50)
        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
      }
    }
    .customAlert(isError: $vm.isDownloadError, message: vm.message)
    .toast(isVisible: $vm.isSuccess, message: vm.message)
    .loading(isLoading: vm.isLoading)
    .loading(isLoading: vm.isDownlaodingPhotos)
    .navigationDestination(item: $selectedPhoto) { photo in
      SinglePhotoView(selectedPhoto: $selectedPhoto, photo: photo)
        .toolbar(.hidden)
    }
  }
}

#Preview {
  SearchView()
    .preferredColorScheme(.dark)
}



