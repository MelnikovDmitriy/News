//
//  ScrollViewContentOffsetObserverViewModifier.swift
//  News
//
//  Created by Дмитрий Мельников on 09.03.2021.
//

import SwiftUI

fileprivate struct ScrollViewContentOffsetObserverViewModifier: ViewModifier {
    
    let coordinateSpaceName: String
    let offsetDidChange: (_ offset: CGFloat, _ contentHeight: CGFloat) -> Void
        
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometryProxy in
                    handler(
                        offset: geometryProxy.frame(in: .named(coordinateSpaceName)).origin.y,
                        contentHeight: geometryProxy.size.height
                    )
                }
            )
    }
    
    private func handler(offset: CGFloat, contentHeight: CGFloat) -> Color {
        DispatchQueue.main.async {
            offsetDidChange(offset, contentHeight)
        }
        
        return .clear
    }
}

// MARK: - View Extension
extension View {
    func scrollViewContentOffsetObserver(coordinateSpaceName: String, offsetDidChange: @escaping (_ offset: CGFloat, _ contentHeight: CGFloat) -> Void) -> some View {
        self.modifier(
            ScrollViewContentOffsetObserverViewModifier(
                coordinateSpaceName: coordinateSpaceName,
                offsetDidChange: offsetDidChange
            )
        )
    }
}
