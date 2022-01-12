//
//  RefreshAnimationView.swift
//  News
//
//  Created by Дмитрий Мельников on 29.12.2021.
//

import SwiftUI

struct RefreshAnimationView: View {
    
    @ObservedObject var model: RefreshAnimationViewModel
    
    var body: some View {
        VStack {
            if model.animationStarted, let text = model.text {
                AnimatedImageView()
                    .frame(width: 60, height: 60)
                
                Text(text)
                    .font(Fonts.body)
                    .foregroundColor(.secondary)
                
            } else if !model.animationStarted, let staticImage = model.staticImage {
                Image(decorative: staticImage, scale: 1)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .scaleEffect(model.staticImageScale)
            }
        }
    }
}

struct RefreshAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RefreshAnimationView(model: RefreshAnimationViewModel())
            Spacer()
        }
    }
}
