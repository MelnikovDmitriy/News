//
//  NewsListRowView.swift
//  News
//
//  Created by Дмитрий Мельников on 28.12.2021.
//

import SwiftUI

struct NewsListRowView: View {
    
    @ObservedObject var model: NewsListRowViewModel
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var shadowColor: Color {
        if colorScheme == .light {
            return Color(.lightGray)

        } else {
            return .black
        }
    }
    
    @ViewBuilder private var image: some View {
        if let preview = model.image {
            Image(uiImage: preview)
                .resizable()
                .aspectRatio(contentMode: .fit)

        } else {
            Image("NewsListRowImagePlaceholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(Colors.mainBackground.opacity(0.85))
        }
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            NewsListRowMenuView(model: model)
            
            VStack(alignment: .leading, spacing: 0) {
                image
                
                VStack(alignment: .leading, spacing: 24) {
                    Text(model.title)
                        .lineLimit(3)
                        .font(Fonts.subtitle)
                    Text(model.author)
                        .lineLimit(1)
                        .font(Fonts.body)
                        .foregroundColor(.secondary)
                }
                .padding(16)
                
            }
            .background(Colors.mainBackground)
            .cornerRadius(20)
            .shadow(color: shadowColor, radius: 4, x: 0, y: 0)
            .padding(.trailing, model.isMenuPresented ? 60 : 0)

        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .frame(width: UIScreen.main.bounds.width > 400 ? 400 : nil)
        .onDisappear(perform: model.removeImage)
        .gesture(
            DragGesture(minimumDistance: 100)
                .onEnded {
                    updateMenuState(translationWidth: $0.translation.width)
                }
        )
        .background(
            ActivityView(
                isPresented: .constant(!model.activityItems.isEmpty),
                items: model.activityItems,
                onComplete: { _,_,_,_  in model.onActivityComplete() }
            )
        )
    }
    
    private func updateMenuState(translationWidth: CGFloat) {
        withAnimation(.spring()) {
            if translationWidth < 100 {
                model.showMenu()
                
            } else {
                model.hideMenu()
            }
        }
    }
}

struct NewsListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Colors.mainBackground
            
            NewsListRowView(
                model: .init(
                    id: UUID(),
                    imageURL: "",
                    title: "В США запретили Fortnite, PUGB и DOTA 2",
                    newsURL: "https://",
                    author: "Александр Сытый",
                    authorURL: "https://",
                    date: Date()
                )
            )
        }
    }
}
