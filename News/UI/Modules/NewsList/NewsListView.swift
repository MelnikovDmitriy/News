//
//  NewsListView.swift
//  News
//
//  Created by Дмитрий Мельников on 28.12.2021.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var model: NewsListViewModel
    
    @State private var scrollingDisabled = false
    @State private var scrollViewFrame = CGRect.zero
    
    private let coordinateSpaceName = "NewsScrollViewCoordinateSpaceName"

    private var newsScrollView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 24) {
                ForEach(model.newsListRowViewModels) { viewModel in
                    NewsListRowView(model: viewModel)
                        .onAppear { model.newsWillAppear(model: viewModel) }
                        .onTapGesture { model.openNewsView(newsURL: viewModel.newsURL) }
                }

                if model.newsProviderRequestState == .loading {
                    LoadingMoreNewsAnimation(model: model.loadingMoreNewsAnimationViewModel)

                } else if model.newsProviderRequestState == .inactive, !model.newsListRowViewModels.isEmpty {
                    loadMoreButton(action: model.loadMoreNews)
                }
            }
            .scrollViewContentOffsetObserver(
                coordinateSpaceName: coordinateSpaceName,
                offsetDidChange: scrollViewContentOffsetDidChange
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
        .padding(.top, model.newsProviderRequestState == .refreshing ? model.refresherHeight : 0)
        .disabled(scrollingDisabled)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Colors.mainBackground
                .edgesIgnoringSafeArea(.all)
            
            RefreshAnimationView(model: model.refreshAnimationViewModel)
            
            newsScrollView

            if case .error(let errorModel) = model.newsProviderRequestState {
                ErrorBottomView(model: errorModel)
                    .zIndex(1)
                    .transition(.move(edge: .bottom))
            }
            
            if let error = model.emptyNewsStoreError {
                MessageView(title: error.title, subtitle: error.subtitle)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(
                        loadMoreButton(action: error.action)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    )
            }
        }
        .animation(.spring(), value: model.newsProviderRequestState)
        .onAppear(perform: model.refreshNews)
        .sheet(
            isPresented: .constant(model.selectedNewsURL != nil),
            onDismiss: model.onNewsViewDismiss,
            content: {
                if let url = model.selectedNewsURL {
                    NewsWebView(model: .init(newsURL: url))

                } else {
                    EmptyView()
                }
            }
        )
    }

    @ViewBuilder private func loadMoreButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text("Загрузить")
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .background(Color.blue)
                .cornerRadius(8)
        }
        .padding(.bottom)
    }
    
    private func scrollViewContentOffsetDidChange(offset: CGFloat) {
        if offset > model.refresherHeight {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()

            model.refreshNews()

            fixScrollViewTopEdge()
            
        } else if offset >= 0 {
            model.updateRefresherImageSize(offset: offset)
        }
    }
    
    private func fixScrollViewTopEdge() {
        scrollingDisabled = true
        DispatchQueue.main.async {
            scrollingDisabled = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(model: NewsListViewModel())
    }
}
