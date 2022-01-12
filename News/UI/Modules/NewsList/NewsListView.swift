//
//  NewsListView.swift
//  News
//
//  Created by Дмитрий Мельников on 28.12.2021.
//

import SwiftUI

struct NewsListView: View {
    
    @ObservedObject var model: NewsListViewModel
    
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
