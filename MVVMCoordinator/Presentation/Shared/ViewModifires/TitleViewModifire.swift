//
//  TitleViewModifire.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import SwiftUI

struct TitleViewModifire: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(.secondary)
            .padding(.bottom)
    }
}

extension Text {
    func makeTitle() -> some View {
        self.modifier(TitleViewModifire())
    }
}
