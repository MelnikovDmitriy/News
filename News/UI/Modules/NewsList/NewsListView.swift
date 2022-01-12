//
//  NewsListView.swift
//  News
//
//  Created by Дмитрий Мельников on 28.12.2021.
//

import SwiftUI

struct NewsListView: View {
    
    @ObservedObject var model: NewsListViewModel
    
    private var emptyNewsListMessageView: some View {
        MessageView(
            title: "Новостей нет",
            subtitle: "Очень странные дела. Похоже кто-то снес базу на сервере"
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            loadMoreButton(action: model.refreshNews)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        )
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Colors.mainBackground
                .edgesIgnoringSafeArea(.all)
                        
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 24) {
                    ForEach(model.newsListRowViewModels) { viewModel in
                        NewsListRowView(model: viewModel)
                            .onAppear { model.newsWillAppear(model: viewModel) }
                    }

                    if model.newsProviderRequestState == .inactive, !model.newsListRowViewModels.isEmpty {
                        loadMoreButton(action: model.loadMoreNews)
                    }
                }
            }
            
            if case .error(let errorModel) = model.newsProviderRequestState {
                ErrorBottomView(model: errorModel)
                    .zIndex(1)

            } else if case .inactive = model.newsProviderRequestState,
                 model.newsListRowViewModels.isEmpty {
                emptyNewsListMessageView
            }
        }
        .onAppear(perform: model.refreshNews)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(model: NewsListViewModel())
    }
}
