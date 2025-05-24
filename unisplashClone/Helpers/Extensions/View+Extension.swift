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
