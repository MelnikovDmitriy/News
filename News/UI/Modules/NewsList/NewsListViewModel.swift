//
//  NewsListViewModel.swift
//  News
//
//  Created by Дмитрий Мельников on 29.12.2021.
//

import SwiftUI

final class NewsListViewModel: ObservableObject {
    
    private let newsProvider = GamesMailRuNewsProvider()
    private let newslistRowViewModelFactory = NewsListRowViewModelFactory()
    
    @Published private(set) var newsProviderRequestState = NewsProviderRequestState.inactive
    @Published private(set) var newsListRowViewModels = [NewsListRowViewModel]()
    
    private func addNewsModels(news: [NewsDTO]) {
        let models = self.newslistRowViewModelFactory.map(news)
        models.forEach { $0.loadImage() }
        newsListRowViewModels += models
    }
}

// MARK: - News Provider
extension NewsListViewModel {
    enum NewsProviderRequestState {
        case loading
        case refreshing
        case error
        case inactive
    }
    
    func refreshNews() {
        guard newsProviderRequestState == .inactive else { return }

        newsProviderRequestState = .refreshing
        
        newsProvider.refreshNews { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {                
                switch result {

                case .failure:
                    ()

                case .success(let news):
                    if let lastNewsDate = self.newsListRowViewModels.first?.date {
                        let models = self.newslistRowViewModelFactory.map(news.filter { $0.date > lastNewsDate })
                        models.forEach { $0.loadImage() }
                        self.newsListRowViewModels.insert(contentsOf: models, at: 0)

                    } else if self.newsListRowViewModels.isEmpty {
                        self.addNewsModels(news: news)
                    }
                }
                
                self.setInactiveNewsAPIRequestState()
            }
        }
    }
    
    func loadMoreNews() {
        guard newsProviderRequestState == .inactive,
              !newsListRowViewModels.isEmpty else { return }
        
        newsProviderRequestState = .loading
                
        newsProvider.loadMoreNews { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.sync {
                switch result {
                    
                case .failure:
                    return
                    
                case .success(let news):
                    self.addNewsModels(news: news)
                }
                
                self.setInactiveNewsAPIRequestState()
            }
        }
    }

    func newsWillAppear(model: NewsListRowViewModel) {
        model.loadImage()

        let requestMoreNewsModelIndex = newsListRowViewModels.count - Config.restNewsCountForRequestMore

        if requestMoreNewsModelIndex > 0,
           model.id == newsListRowViewModels[requestMoreNewsModelIndex].id {
            loadMoreNews()
        }
    }
    
    private func setInactiveNewsAPIRequestState() {
        withAnimation {
            newsProviderRequestState = .inactive
        }
    }
}

// MARK: - Config
private extension NewsListViewModel {
    enum Config {
        static let restNewsCountForRequestMore = 5
    }
}
