//
//  LoadingMoreNewsAnimationModel.swift
//  News
//
//  Created by Дмитрий Мельников on 05.01.2022.
//

import SwiftUI

final class LoadingMoreNewsAnimationModel: ObservableObject {
       
    @Published private(set) var animationStarted = false

    private(set) var text = "подгружаем больше новостей"
    
    func startAnimation() {
        animationStarted = true
    }
    
    func stopAnimation() {
        animationStarted = false
    }
}
