//
//  UniversalForegroundStyle.swift
//  GuessTheFlag
//
//  Created by artembolotov on 01.01.2023.
//

import Foundation
import SwiftUI

struct UniversalForegroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .foregroundStyle(.secondary)
        } else {
            content
                .foregroundColor(.secondary)
        }
    }
}

extension View {
    func universalForegroundStyle() -> some View {
        modifier(UniversalForegroundStyle())
    }
}
