//
//  NewsWebView.swift
//  News
//
//  Created by Дмитрий Мельников on 09.01.2022.
//

import SwiftUI

struct NewsWebView: View {

    @StateObject var model: NewsWebViewModel

    var body: some View {
        ZStack {
            WKWebViewWrapper(url: model.newsURL, loadingState: $model.loadingState)
                .edgesIgnoringSafeArea(.bottom)

            if model.loadingState != .success {
                Colors.mainBackground
                    .edgesIgnoringSafeArea(.all)
            }

            if model.loadingState == .loading {
                AnimatedImageView()
                    .frame(width: 240, height: 240)

            } else if model.loadingState == .error {
                MessageView(
                    title: model.defaultErrorModel.title,
                    subtitle: model.defaultErrorModel.subtitle
                )
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsWebView(model: NewsWebViewModel(newsURL: URL(string: "https://games.mail.ru")!))
    }
}
