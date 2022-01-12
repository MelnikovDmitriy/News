//
//  NewsListRowViewModel.swift
//  News
//
//  Created by Дмитрий Мельников on 02.01.2022.
//

import SwiftUI

final class NewsListRowViewModel: Identifiable, ObservableObject {
    
    let id: UUID
    let imageURL: String
    let title: String
    let newsURL: String
    let author: String
    let authorURL: String
    let date: Date
        
    @Published private(set) var image: UIImage?
    @Published private(set) var isImageLoadingFailed = false
    @Published private(set) var isMenuPresented = false
    @Published private(set) var activityItems = [URL]()
    @Published private(set) var authorPageURL: URL?
    
    init(
        id: UUID,
        imageURL: String,
        title: String,
        newsURL: String,
        author: String,
        authorURL: String,
        date: Date
    ) {
        self.id = id
        self.imageURL = imageURL
        self.title = title
        self.newsURL = newsURL
        self.author = author
        self.authorURL = authorURL
        self.date = date
    }

    func showMenu() {
        isMenuPresented = true
    }

    func hideMenu() {
        isMenuPresented = false
    }
}
