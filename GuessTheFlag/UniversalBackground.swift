//
//  UniversalBackground.swift
//  GuessTheFlag
//
//  Created by artembolotov on 01.01.2023.
//

import Foundation
import SwiftUI

struct UniversalBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .background(.regularMaterial)
        } else {
            content
                .background(Color.white.opacity(0.6))
        }
    }
}

extension View {
    func universalBackground() -> some View {
        modifier(UniversalBackground())
    }
}
