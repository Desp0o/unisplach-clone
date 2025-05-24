//
//  View+Extension.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUICore

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
