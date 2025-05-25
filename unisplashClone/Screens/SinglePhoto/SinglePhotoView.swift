//
//  SinglePhotoView.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct SinglePhotoView: View {
  @Environment(\.dismiss) private var dismiss
  @State private var vm = SingleViewModel()
  @State private var isSheetVisible: Bool = false
  @State private var isPhotoLiked: Bool = false
  @Binding var selectedPhoto: PhotoResponseModel?
  let photo: PhotoResponseModel
  
  var body: some View {
    VStack(spacing: 10) {
      CachedAsyncImage(url: URL(string: photo.urls.small))
        .scaledToFit()
        .frame(maxWidth: .infinity)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.customBlack)
    .overlay {
      VStack {
        HStack {
          Button {
            dismiss()
          } label: {
            Image(systemName: IconsEnum.baclButton.rawValue)
              .imageCustomSettings(width: 18, height: 18)
              .foregroundStyle(.white)
          }
          
          Spacer()
          
          CachedAsyncImage(url: URL(string: photo.user.profileImage.small))
            .frame(width: 30, height: 30)
            .clipShape(Circle())
            .overlay(
              Circle().stroke(Color.customGray, lineWidth: 1)
            )
          
          Text(photo.user.name)
            .customTextStyle(fontWeight: .semibold, fontColor: .white)
          
          Spacer()
          
          if let url = URL(string: photo.urls.regular) {
            ShareLink("",
                      item: url,
                      subject: Text("Photo by \(photo.user.name)"),
                      message: Text(vm.photoDetails?.altDescription ?? "")
            )
            .tint(Color.white)
          }
        }
        
        Spacer()
        
        HStack(alignment: .bottom) {
          Image(systemName: IconsEnum.info.rawValue)
            .imageCustomSettings()
            .foregroundStyle(.white)
            .frame(width: 24, height: 24)
            .onTapGesture {
              isSheetVisible = true
            }
          
          Spacer()
          
          VStack(spacing: 10) {
            Button {
              vm.likePhoto(photo: photo, isLiked: isPhotoLiked)
              isPhotoLiked.toggle()
            } label: {
              ZStack {
                Image(systemName: isPhotoLiked ? IconsEnum.heartFilled.rawValue : IconsEnum.heart.rawValue)
                  .renderingMode(.template)
                  .imageCustomSettings(width: 18, height: 18)
                  .foregroundStyle(isPhotoLiked ? .red : .black)
              }
              .frame(width: 50, height: 50)
              .background(.white)
              .clipShape(Circle())
            }
            
            Button {
              vm.savePhoto(url: photo.urls.regular)
            } label: {
              ZStack {
                Image(systemName: IconsEnum.arrowDown.rawValue)
                  .foregroundStyle(.black)
              }
              .frame(width: 50, height: 50)
              .background(.white)
              .clipShape(Circle())
            }
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.top, 10)
      .padding(.bottom, 40)
    }
    .customAlert(isError: $vm.isError, message: vm.message)
    .loading(isLoading: vm.isLoading)
    .toast(isVisible: $vm.isSuccess, message: vm.message)
    .swipeToDismiss(dismiss: dismiss)
    .sheet(isPresented: $isSheetVisible) {
      if let detail = vm.photoDetails {
        PhotoDetails(details: detail)
      }
    }
    .onAppear {
      if vm.likedPhotos.contains(photo) {
        isPhotoLiked = true
      }
    }
    .task {
      vm.getPhotoDetail(id: photo.id)
    }
  }
}
