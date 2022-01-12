//
//  AnimatedImageView.swift
//  News
//
//  Created by Дмитрий Мельников on 10.01.2022.
//

import SwiftUI

struct AnimatedImageView: View {

    @State private var cgImage: CGImage?
    @State private var isAnimationStopped = true

    var body: some View {
        ZStack {
            if let cgImage = cgImage {
                Image(decorative: cgImage, scale: 1)
                    .resizable()
            }
        }
        .onAppear(perform: startAnimation)
        .onDisappear(perform: stopAnimation)
    }

    func startAnimation() {
        guard let url = AnimationURL.loading as CFURL? else { return }

        isAnimationStopped = false

        CGAnimateImageAtURLWithBlock(url, nil) { _, image, stop in
            cgImage = isAnimationStopped ? nil : image
            stop.pointee = isAnimationStopped
        }
    }

    func stopAnimation() {
        isAnimationStopped = true
    }
}

struct AnimatedImageView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedImageView()
    }
}
