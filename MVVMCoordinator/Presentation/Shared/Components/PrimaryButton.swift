//
//  PrimaryButton.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import SwiftUI

struct PrimaryButton: View {
    
    var title: String
    
    @Binding var isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Group {
                if isLoading {
                    ProgressView()
                        .tint(Color.white)
                        .padding(2)
                    
                } else {
                    Text(title)
                        .font(.headline)
                }
            }
            .frame(maxWidth: .greatestFiniteMagnitude)
            .padding(.vertical, 12)
        }
        .foregroundStyle(.white)
        .background(Color.orange)
        .cornerRadius(10)
    }
}

#Preview {
    Group {
        PrimaryButton(title: "Submit", isLoading: .constant(false)){
            //
        }
        PrimaryButton(title: "Submit", isLoading: .constant(true)){
            //
        }
    }

    .padding()
}
