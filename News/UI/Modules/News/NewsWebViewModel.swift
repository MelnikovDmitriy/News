//
//  NewsWebViewModel.swift
//  News
//
//  Created by Дмитрий Мельников on 09.01.2022.
//

import SwiftUI

final class NewsWebViewModel: ObservableObject {

    let newsURL: URL
    let defaultErrorModel = ErrorModelFactory().newsWebViewLoadingError

    @Published var loadingState = WKWebViewWrapper.LoadingState.loading

    init(newsURL: URL) {
        self.newsURL = newsURL
    }
}
