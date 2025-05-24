//
//  CustomAlertBox.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct CustomAlertBox: View {
  let alertMessage: String
  @Binding var isAlertVisible: Bool
  @State private var scaleEffect: CGFloat = 0.5
  @State private var opacity: Double = 0.0
  
  var body: some View {
    ZStack {
      if isAlertVisible {
        Color.black.opacity(0.5)
          .edgesIgnoringSafeArea(.all)
          .transition(.opacity)
        
        VStack {
          VStack(spacing: 8) {
            Text(alertMessage)
              .customTextStyle(fontSize: 14)
              .multilineTextAlignment(.center)
            
            Divider()
              .background(.customGray)
            
            Button {
              isAlertVisible = false
              scaleEffect = 0.0
              opacity = 0.0
            } label: {
              Text("OK")
                .customTextStyle()
                .frame(maxWidth: .infinity)
                .offset(y: 5)
            }
          }
          .padding(.horizontal, 10)
          .padding(.vertical, 20)
          .frame(maxWidth: 240)
          .background(.customDark)
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .shadow(radius: 10)
          .scaleEffect(scaleEffect)
          .opacity(opacity)
          .onAppear {
            withAnimation(.bouncy(duration: 0.3)) {
              scaleEffect = 1.0
              opacity = 1.0
            }
          }
        }
      }
    }
    .transition(.opacity)
  }
}

struct CustomAlertModifier: ViewModifier {
  let alert: CustomAlertBox
  
  public func body(content: Content) -> some View {
    content
      .overlay {
        alert
      }
  }
}
