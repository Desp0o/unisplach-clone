//
//  Toast.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct Toast: View {
  @Binding var isVisible: Bool
  let message: String
  
  
  var body: some View {
    VStack {
      if isVisible {
        VStack {
          HStack {
            Text(message)
              .customTextStyle(fontSize: 18, fontWeight: .semibold, fontColor: .white)
          }
          .padding(.vertical, 10)
          .padding(.horizontal, 20)
          .background(.green)
          .clipShape(RoundedRectangle(cornerRadius: 8))
          
          Spacer()
        }
        .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
        .onAppear {
          Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation {
              isVisible = false
            }
          }
        }
      }
    }
    .animation(.smooth, value: isVisible)
  }
}

#Preview {
  @Previewable @State var isVisible = false
  Toast(isVisible: $isVisible, message: "test toast message")
}


struct ToastModifier: ViewModifier {
  let toast: Toast
  
  public func body(content: Content) -> some View {
    content
      .overlay {
        toast
      }
  }
}

