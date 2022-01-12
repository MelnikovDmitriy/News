//
//  LoadingMoreNewsAnimation.swift
//  News
//
//  Created by Дмитрий Мельников on 05.01.2022.
//

import SwiftUI

struct LoadingMoreNewsAnimation: View {
    
    @ObservedObject var model: LoadingMoreNewsAnimationModel
    
    var body: some View {
        VStack {
            Spacer()
            
            if model.animationStarted {
                AnimatedImageView()
                    .frame(width: 60, height: 60)
                
                Text(model.text)
                    .font(Fonts.body)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct LoadingMoreNewsAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingMoreNewsAnimation(model: LoadingMoreNewsAnimationModel())
    }
}
