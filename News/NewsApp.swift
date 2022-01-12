//
//  NewsApp.swift
//  News
//
//  Created by Дмитрий Мельников on 12.01.2022.
//

import SwiftUI

@main
struct NewsApp: App {
    var body: some Scene {
        WindowGroup {
            NewsListRowView(
                model: .init(
                    id: UUID(),
                    imageURL: "",
                    title: "В США запретили Fortnite, PUGB и DOTA 2",
                    newsURL: "https://",
                    author: "Александр Сытый",
                    authorURL: "https://",
                    date: Date()
                )
            )
        }
    }
}
