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
    private let errorViewModelFactory = ErrorModelFactory()
    
    let refreshAnimationViewModel = RefreshAnimationViewModel()
    let loadingMoreNewsAnimationViewModel = LoadingMoreNewsAnimationModel()
    
    @Published private(set) var newsProviderRequestState = NewsProviderRequestState.inactive
    @Published private(set) var newsListRowViewModels = [NewsListRowViewModel]()
    @Published private(set) var selectedNewsURL: URL?
    
    private func addNewsModels(news: [NewsDTO]) {
        let models = self.newslistRowViewModelFactory.map(news)
        models.forEach { $0.loadImage() }
        newsListRowViewModels += models
    }
}

// MARK: - News Provider
extension NewsListViewModel {
    enum NewsProviderRequestState: Equatable {
        case loading
        case refreshing
        case error(ErrorModel)
        case inactive
        
        static func == (lhs: NewsListViewModel.NewsProviderRequestState, rhs: NewsListViewModel.NewsProviderRequestState) -> Bool {
            switch (lhs, rhs) {
            case (loading, loading):
                return true
            case (refreshing, refreshing):
                return true
            case (error, error):
                return true
            case (inactive, inactive):
                return true
            default:
                return false
            }
        }
    }
    
    func refreshNews() {
        guard newsProviderRequestState == .inactive else { return }

        refreshAnimationViewModel.startAnimation()
        newsProviderRequestState = .refreshing
        
        newsProvider.refreshNews { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.refreshAnimationViewModel.stopAnimation()
                
                switch result {

                case .failure(let error):
                    self.showError(error, action: self.refreshNews)

                case .success(let news):
                    if let lastNewsDate = self.newsListRowViewModels.first?.date {
                        let models = self.newslistRowViewModelFactory.map(news.filter { $0.date > lastNewsDate })
                        models.forEach { $0.loadImage() }
                        self.newsListRowViewModels.insert(contentsOf: models, at: 0)

                    } else if self.newsListRowViewModels.isEmpty {
                        self.addNewsModels(news: news)
                    }
                    
                    self.setInactiveNewsAPIRequestState()
                }
            }
        }
    }
    
    func loadMoreNews() {
        guard newsProviderRequestState == .inactive,
              !newsListRowViewModels.isEmpty else { return }
        
        loadingMoreNewsAnimationViewModel.startAnimation()
        newsProviderRequestState = .loading
                
        newsProvider.loadMoreNews { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.sync {
                self.loadingMoreNewsAnimationViewModel.stopAnimation()
                
                switch result {
                    
                case .failure(let error):
                    self.showError(error, action: self.loadMoreNews)
                    
                case .success(let news):
                    self.addNewsModels(news: news)
                    self.setInactiveNewsAPIRequestState()
                }
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
    
    private func showError(_ error: NewsProviderError, action: @escaping () -> Void) {
        if let model = errorViewModelFactory.map(error, action: action, cancel: setInactiveNewsAPIRequestState) {
            withAnimation {
                newsProviderRequestState = .error(model)
            }
        }
    }
    
    private func setInactiveNewsAPIRequestState() {
        withAnimation {
            newsProviderRequestState = .inactive
        }
    }
}

// MARK: - News View
extension NewsListViewModel {
    func openNewsView(newsURL: String) {
        selectedNewsURL = URL(string: newsURL)
    }

    func onNewsViewDismiss() {
        selectedNewsURL = nil
    }
}

// MARK: - Refresher
extension NewsListViewModel {
    var refresherHeight: CGFloat {
        refreshAnimationViewModel.refresherHeight
    }
    
    func updateRefresherImageSize(offset: CGFloat) {
        refreshAnimationViewModel.updateImageSize(offset: offset)
    }
}

// MARK: - Config
private extension NewsListViewModel {
    enum Config {
        static let restNewsCountForRequestMore = 5
    }
}
