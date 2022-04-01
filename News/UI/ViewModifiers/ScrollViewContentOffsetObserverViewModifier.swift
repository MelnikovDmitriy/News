//
//  ScrollViewContentOffsetObserverViewModifier.swift
//  News
//
//  Created by Дмитрий Мельников on 09.03.2021.
//

import SwiftUI

struct ScrollViewContentOffsetObserverViewModifier: ViewModifier {
    let coordinateSpaceName: String
    let offsetDidChange: (_ offset: CGFloat) -> Void

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometryProxy in
                    let offset = geometryProxy.frame(in: .named(coordinateSpaceName)).origin.y
                    handler(offset: offset)
                }
            )
    }
    
    private func handler(offset: CGFloat) -> AnyView? {
        DispatchQueue.main.async {
            offsetDidChange(offset)
        }
        
        return nil
    }
}

// MARK: - View Extension
extension View {
    func scrollViewContentOffsetObserver(coordinateSpaceName: String, offsetDidChange: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self.modifier(
            ScrollViewContentOffsetObserverViewModifier(
                coordinateSpaceName: coordinateSpaceName,
                offsetDidChange: offsetDidChange
            )
        )
    }
}
