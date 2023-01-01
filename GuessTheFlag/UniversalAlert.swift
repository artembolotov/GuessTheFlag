//
//  UniversalAlert.swift
//  GuessTheFlag
//
//  Created by artembolotov on 30.12.2022.
//

import Foundation
import SwiftUI


struct UniversalAlert: ViewModifier {
    
    let isPresented: Binding<Bool>
    let title: String
    let message: String?
    let dismissTitle: String
    let action: ()->Void
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .alert(title, isPresented: isPresented) {
                    Button(dismissTitle, action: action)
                } message: {
                    message != nil ? Text(message!) : nil
                }
        } else {
            content
                .alert(isPresented: isPresented) {
                    let message = message != nil ? Text(message!) : nil
                    return Alert(title: Text(title), message: message, dismissButton: .default(Text(dismissTitle), action: action))
                }
        }
    }
}

extension View {
    func universalAlert(isPresented: Binding<Bool>, title: String, message: String?, dismissTitle: String, dismissAction: @escaping ()->Void) -> some View {
        modifier(UniversalAlert(isPresented: isPresented, title: title, message: message, dismissTitle: dismissTitle, action: dismissAction))
    }
}

