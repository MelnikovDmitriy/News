//
//  WKWebViewWrapper.swift
//  News
//
//  Created by Дмитрий Мельников on 09.01.2022.
//

import SwiftUI
import WebKit

struct WKWebViewWrapper: UIViewRepresentable {
    let url: URL

    @Binding var loadingState: LoadingState

    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.navigationDelegate = context.coordinator
        view.load(URLRequest(url: url))

        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(loadingStateChanged: loadingStateChanged)
    }

    func loadingStateChanged(state: LoadingState) {
        loadingState = state
    }
}

// MARK: - NewsWebView
extension WKWebViewWrapper {
    enum LoadingState {
        case loading
        case success
        case error
    }
}

// MARK: - Coordinator
extension WKWebViewWrapper {
    final class Coordinator: NSObject, WKNavigationDelegate {
        let loadingStateChanged: (LoadingState) -> Void

        init(loadingStateChanged: @escaping (LoadingState) -> Void) {
            self.loadingStateChanged = loadingStateChanged
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            loadingStateChanged(.loading)
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            loadingStateChanged(.success)
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            loadingStateChanged(.error)
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            loadingStateChanged(.error)
        }
    }
}
