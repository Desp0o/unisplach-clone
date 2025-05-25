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
  @State private var selectedPhoto: PhotoResponseModel? = nil
  
  var body: some View {
    VStack(spacing: 0) {
      MainViewHeader(vm: vm)
      
      if vm.isError {
        MainViewTryAgainButton(vm: vm)
      } else {
        ScrollViewReader { proxy in
          ScrollView {
            LazyVGrid(columns: vm.gridMode ? [GridItem(), GridItem()] : [GridItem()], spacing: vm.gridMode ? 4 : 2) {
              ForEach(vm.images.indices, id: \.self) { index in
                let photo = vm.images[index]
                let isSelected = vm.selectedPhotos.contains(photo.urls.small)
                
                LayoutPhotoView(url: photo.urls.small, isGridMode: vm.gridMode)
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
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .background(.customDark)
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
    .loading(isLoading: vm.isDownlaodingPhotos)
    .loading(isLoading: vm.isLoading)
    .task {
      vm.fetchImages()
    }
    .navigationDestination(item: $selectedPhoto) { photo in
      SinglePhotoView(selectedPhoto: $selectedPhoto, photo: photo)
        .toolbar(.hidden)
    }
  }
}

#Preview {
  MainView()
}

