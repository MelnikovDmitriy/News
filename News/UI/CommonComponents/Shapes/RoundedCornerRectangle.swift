//
//  RoundedCornerRectangle.swift
//  News
//
//  Created by Дмитрий Мельников on 01.04.2022.
//

import SwiftUI

fileprivate struct RoundedCornerRectangle: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let cornerRadii = CGSize(width: radius, height: radius)
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: cornerRadii
        )
        
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornerRectangle(radius: radius, corners: corners) )
    }
}
