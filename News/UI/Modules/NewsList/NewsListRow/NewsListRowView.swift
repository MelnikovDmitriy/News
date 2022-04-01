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

    @ViewBuilder private var activityView: some View {
        let isPreseted = !model.activityItems.isEmpty

        if isPreseted {
            ActivityView(
                isPresented: .constant(isPreseted),
                activityItems: model.activityItems,
                applicationActivities: nil,
                completion: { _,_,_,_  in model.onActivityComplete() }
            )
        } else {
            EmptyView()
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
                    
                    Button(action: model.openAuthorPage) {
                        Text(model.author)
                            .lineLimit(1)
                            .font(Fonts.body)
                            .foregroundColor(.secondary)
                    }
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
            DragGesture(minimumDistance: 50)
                .onEnded {
                    updateMenuState(translationWidth: $0.translation.width)
                }
        )
        .background(activityView)
        .sheet(
            isPresented: .constant(model.authorPageURL != nil),
            onDismiss: model.onAuthorPageDismiss,
            content: {
                if let url = model.authorPageURL {
                    NewsWebView(model: .init(newsURL: url))

                } else {
                    EmptyView()
                }
            }
        )
    }
    
    private func updateMenuState(translationWidth: CGFloat) {
        withAnimation(.spring()) {
            translationWidth < 0 ? model.showMenu() : model.hideMenu()
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
