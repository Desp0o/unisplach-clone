//
//  SinglePhotoView.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct SinglePhotoView: View {
  @State private var vm = SingleViewModel()
  @Binding var selectedPhoto: PhotoResponseModel?
  let photo: PhotoResponseModel
  
  var body: some View {
    ZStack(alignment: .topTrailing) {
      Color.black
        .ignoresSafeArea()
        .onTapGesture {
          withAnimation {
            selectedPhoto = nil
          }
        }
      
      VStack(spacing: 10) {
        CachedAsyncImage(url: URL(string: photo.urls.small))
          .scaledToFit()
          .frame(maxWidth: .infinity)
          .onTapGesture {
            withAnimation {
              selectedPhoto = nil
            }
          }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(.bottom, 50)
      .overlay {
        VStack {
          HStack {
            CachedAsyncImage(url: URL(string: photo.user.profileImage.small))
              .frame(width: 30, height: 30)
              .clipShape(Circle())
              .overlay(
                Circle().stroke(Color.customGray, lineWidth: 1)
              )
            
            Text(photo.user.name)
              .customTextStyle(fontWeight: .semibold, fontColor: .white)
            
            Spacer()
          }
          
          Spacer()
          
          HStack(alignment: .bottom) {
            Text(photo.altDescription ?? "")
              .customTextStyle(fontSize: 14, fontColor: .white)
            
            Spacer()
            
            VStack(spacing: 10) {
              Button {
                
              } label: {
                ZStack {
                  Image(systemName: IconsEnum.heart.rawValue)
                    .foregroundStyle(.black)
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
        .padding(.bottom, 70)
      }
    }
    .zIndex(1)
    .customAlert(isError: $vm.isError, message: vm.message)
    .loading(isLoading: vm.isLoading)
    .toast(isVisible: $vm.isSuccess, message: vm.message)
  }
}
