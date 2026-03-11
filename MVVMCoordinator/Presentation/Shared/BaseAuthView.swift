//
//  BaseAuthView.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import SwiftUI

struct BaseAuthView<Content>: View where Content: View {
    
    var content: Content
    
    init(@ViewBuilder content:  () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gray.opacity(0.2), .gray.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            content
                .padding()
        }
    }
}

#Preview {
    BaseAuthView {
        Text("Hello, World!")
    }
}
