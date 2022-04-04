//
//  NativeAdViewModel.swift
//  News
//
//  Created by Дмитрий Мельников on 01.04.2022.
//

import MyTargetSDK
import SwiftUI

final class NativeAdViewModel: NSObject, ObservableObject, MTRGNativeAdDelegate {
    private let nativeAd = MTRGNativeAd(slotId: 30294)
    
    @Published private(set) var ad: NativeAd?
    
    override init() {
        super.init()
        nativeAd.delegate = self
        nativeAd.load()
    }
}

// MARK: - MTRGNativeBannerAdDelegate
extension NativeAdViewModel {
    func onLoad(with promoBanner: MTRGNativePromoBanner, nativeAd: MTRGNativeAd) {
        ad = .init(
            title: promoBanner.title ?? "",
            description: promoBanner.descriptionText ?? "",
            ageRestrictions: promoBanner.ageRestrictions ?? "",
            ctaText: promoBanner.ctaText ?? "",
            icon: promoBanner.icon?.image,
            media: promoBanner.image?.image
        )
        
        let rootView = EmptyView()
        let hostingController = UIHostingController(rootView: rootView)
        nativeAd.register(hostingController.view, with: hostingController)
    }
    
    func onNoAd(withReason reason: String, nativeAd: MTRGNativeAd) {
        NSLog("\(nativeAd) loading failed: \(reason)")
    }
}
