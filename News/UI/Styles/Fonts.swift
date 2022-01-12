//
//  Fonts.swift
//  News
//
//  Created by Дмитрий Мельников on 10.01.2022.
//

import SwiftUI

enum Fonts {
    static let title = Font.system(size: 20, weight: .semibold)
    static let subtitle = Font.system(size: 16, weight: .semibold)
    static let body = Font.system(size: 14)
}

struct Fonts_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("title font prewiew.")
                .font(Fonts.title)

            Text("subtitle font prewiew.")
                .font(Fonts.subtitle)

            Text("body font prewiew.")
                .font(Fonts.body)
        }
        .padding()
    }
}
