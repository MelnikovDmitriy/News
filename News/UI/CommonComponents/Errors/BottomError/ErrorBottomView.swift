//
//  ErrorBottomView.swift
//  News
//
//  Created by Дмитрий Мельников on 06.01.2022.
//

import SwiftUI

struct ErrorBottomView: View {
    
    let model: ErrorModel
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack(alignment: .bottom) {
                Color.black.opacity(0.2)
                    .zIndex(1)
                
                VStack(spacing: 16) {
                    MessageView(title: model.title, subtitle: model.subtitle)
                    
                    VStack {
                        Button(action: model.action) {
                            Text(model.actionTitle)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 4)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }

                        if let cancel = model.cancel{
                            Button(action: cancel) {
                                Text("Отмена")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .strokeBorder(Color.blue)
                                    )
                            }
                        }
                    }
                    .padding(.top, 16)
                }
                .multilineTextAlignment(.center)
                .padding(16)
                .frame(maxWidth: .infinity)
                .padding(.bottom, geometryProxy.safeAreaInsets.bottom)
                .background(Colors.mainBackground)
                .cornerRadius(14)
                .shadow(radius: 4)
                .zIndex(2)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ErrorBottomView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorBottomView(model: .init(title: "title", subtitle: "subtitle", action: {}, actionTitle: "Повторить", cancel: {}))
    }
}
