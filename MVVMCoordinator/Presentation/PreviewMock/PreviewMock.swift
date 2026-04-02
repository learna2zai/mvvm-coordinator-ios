//
//  PreviewMock.swift
//  MVVMCoordinator
//
//  Created on 29/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation
import SwiftUI

struct PreviewMock<Content: View>: View {
    let container = MockDIContainer()
    let content: Content
    
    init (@ViewBuilder content: (Container) -> Content) {
        self.content = content(container)
    }
    
    var body: some View {
        content
            .environment(AppCoordinator(diContainer: container))
    }
}


#Preview {
    PreviewMock { container in
        LoginView(viewModel: container.makeLoginViewModel(),
                  coordinator: AuthCoordinator(diContainer: container))
    }
}
