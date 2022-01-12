//
//  NewsListRowMenuView.swift
//  News
//
//  Created by Дмитрий Мельников on 10.01.2022.
//

import SwiftUI

struct NewsListRowMenuView: View {

    let model: NewsListRowViewModel

    var body: some View {
        VStack(spacing: 24) {
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
            }

            Button(action: {}) {
                Image(systemName: "heart")
            }
        }
        .font(.headline)
        .padding(.trailing, 8)
    }
}

struct NewsListRowMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListRowMenuView(
            model: .init(
                id: UUID(),
                imageURL: "",
                title: "В США запретили Fortnite, PUGB и DOTA 2",
                newsURL: "",
                author: "Александр Сытый",
                authorURL: "https://",
                date: Date()
            )
        )
    }
}
