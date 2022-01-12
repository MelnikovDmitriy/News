//
//  GlobalFrameModifier.swift
//  News
//
//  Created by Дмитрий Мельников on 01.01.2022.
//

import SwiftUI

fileprivate struct GlobalFrameModifier: ViewModifier {
    
    let globalFrame: (CGRect) -> Void
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometryProxy in
                    handler(frame: geometryProxy.frame(in: .global))
                }
            )
    }
    
    private func handler(frame: CGRect) -> Color {
        DispatchQueue.main.async {
            globalFrame(frame)
        }
        
        return .clear
    }
}

// MARK: - View Extension
extension View {
    func globalFrame(_ frame: @escaping (CGRect) -> Void) -> some View {
        self.modifier(GlobalFrameModifier(globalFrame: frame))
    }
}
