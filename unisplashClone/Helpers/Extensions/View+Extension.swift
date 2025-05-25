//
//  View+Extension.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUICore
import SwiftUI

extension View {
  func customAlert(isError: Binding<Bool>, message: String) -> some View {
    modifier(CustomAlertModifier(alert: CustomAlertBox(alertMessage: message, isAlertVisible: isError)))
  }
}

extension View {
  func toast(isVisible: Binding<Bool>, message: String) -> some View {
    modifier(ToastModifier(toast: Toast(isVisible: isVisible, message: message)))
  }
}

extension View {
  func loading(isLoading: Bool) -> some View {
    modifier(LoadingModifier(loading: LoadingIndicator(isLoading: isLoading)))
  }
}

extension View {
  func swipeToDismiss(dismiss: DismissAction) -> some View {
    self.gesture(
      DragGesture()
        .onEnded { value in
          if value.translation.width > 50 {
            dismiss()
          }
        }
    )
  }
}
