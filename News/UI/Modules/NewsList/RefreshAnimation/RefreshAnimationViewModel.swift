//
//  RefreshAnimationViewModel.swift
//  News
//
//  Created by Дмитрий Мельников on 29.12.2021.
//

import SwiftUI

final class RefreshAnimationViewModel: ObservableObject {
    @Published private(set) var animationStarted = false
    @Published private(set) var staticImageScale = Config.minImageScale
    @Published private(set) var staticImage: CGImage?
    @Published private(set) var text: String?
    
    var refresherHeight: CGFloat {
        Config.refreshViewTotalHeight
    }
    
    init() {
        prepareStaticImage()
    }
    
    private func prepareStaticImage() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: AnimationURL.loading),
               let source =  CGImageSourceCreateWithData(data as CFData, nil),
               CGImageSourceGetCount(source) > 0 {
                
                DispatchQueue.main.async {
                    self.staticImage = CGImageSourceCreateImageAtIndex(source, 0, nil)
                }
            }
        }
    }
    
    func startAnimation() {
        staticImageScale = Config.maxImageScale
        animationStarted = true
        text = Config.refreshText
    }
    
    func updateImageSize(offset: CGFloat) {
        if offset == 0 {
            staticImageScale = Config.minImageScale

        } else {
            staticImageScale = offset / Config.refreshViewTotalHeight
        }
    }
    
    func stopAnimation() {
        staticImageScale = Config.minImageScale
        animationStarted = false
        text = nil
    }
}

// MARK: - Config
private extension RefreshAnimationViewModel {
    enum Config {
        static let refreshText = "ищем свеженькие новости"
        static let refreshViewTotalHeight: CGFloat = 100
        static let minImageScale: CGFloat = 0.01
        static let maxImageScale: CGFloat = 1
    }
}
