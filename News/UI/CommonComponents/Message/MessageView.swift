//
//  MessageView.swift
//  News
//
//  Created by Дмитрий Мельников on 10.01.2022.
//

import SwiftUI

struct MessageView: View {

    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(Fonts.title)

            Text(subtitle)
                .font(Fonts.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(title: "Title", subtitle: "Subtitle")
    }
}
