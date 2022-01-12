//
//  NewsListRowViewModelFactory.swift
//  News
//
//  Created by Дмитрий Мельников on 04.01.2022.
//

import Foundation

struct NewsListRowViewModelFactory {
    func map(_ models: [NewsDTO]) -> [NewsListRowViewModel] {
        models.map {
            NewsListRowViewModel(
                id: $0.id,
                imageURL: $0.imageURL,
                title: $0.title,
                newsURL: $0.newsURL,
                author: $0.author,
                authorURL: $0.authorURL,
                date: $0.date
            )
        }
    }
}
