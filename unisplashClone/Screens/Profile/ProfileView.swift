//
//  ProfileView.swift
//  unisplashClone
//
//  Created by Despo on 23.05.25.
//

import SwiftUI

struct ProfileView: View {
  @AppStorage("selectedTheme") private var selectedTheme: String = AppTheme.system.rawValue
  @State private var vm = ProfileViewModel()
  @State private var historyView: Int = 0
  @State private var isSettingsVisible: Bool = false
  
  var body: some View {
    VStack(spacing: 0) {
      VStack(spacing: 5) {
        Image(IconsEnum.avatar.rawValue)
          .resizable()
          .frame(width: 70, height: 70)
          .clipShape(Circle())
        
        Text("Hasbula")
          .customTextStyle(fontSize: 24, fontWeight: .semibold)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.top, 50)
      .padding(.leading, 20)
      
      Picker("history", selection: $historyView) {
        Text("Liked").tag(0)
        Text("Downloaded").tag(1)
      }
      .pickerStyle(.segmented)
      .padding()
      
      Group {
        if historyView == 1 {
          VStack(alignment: .leading, spacing: 10) {
            Button {
              vm.clearDownloadHistory()
            } label: {
              Text("Clear download")
                .customTextStyle(fontColor: .customGray)
            }
            .offset(y: 20)
            
            DownloadHistoryView(vm: vm)
          }
        } else {
          LikedPhotosView(vm: vm)
        }
      }
      .padding(.bottom, 50)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .background(.customDark)
    .overlay(alignment: .topTrailing) {
      Button {
        isSettingsVisible.toggle()
      } label: {
        Image(systemName: IconsEnum.gear.rawValue)
          .imageCustomSettings()
          .foregroundStyle(Color.primary)
      }
      .offset(x: -20, y: 20)
    }
    .sheet(isPresented: $isSettingsVisible) {
      VStack(alignment: .leading, spacing: 5) {
        Text("Select Theme")
          .customTextStyle(fontSize: 18, fontWeight: .semibold)
        
        Picker("Appearance", selection: $selectedTheme) {
          ForEach(AppTheme.allCases) { theme in
            Text(theme.displayName).tag(theme.id)
          }
        }
        .pickerStyle(.segmented)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      .padding()
      .presentationDetents([.fraction(0.2)])
      .preferredColorScheme(AppTheme(rawValue: selectedTheme)?.colorScheme)
    }
  }
}

#Preview {
  ProfileView()
    .preferredColorScheme(.dark)
}
