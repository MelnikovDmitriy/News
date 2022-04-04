//
//  NativeAdView.swift
//  News
//
//  Created by Дмитрий Мельников on 01.04.2022.
//

import SwiftUI

struct NativeAdView: View {
    @StateObject private var model = NativeAdViewModel()
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var shadowColor: Color {
        if colorScheme == .light {
            return Color(.lightGray)
            
        } else {
            return .black
        }
    }
    
    var body: some View {
        if let ad = model.ad {
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 8) {
                        ad.icon.map {
                            Image(uiImage: $0)
                                .resizable()
                                .frame(width: 32, height: 32)
                                .cornerRadius(4)
                        }
                        
                        Text(ad.title)
                            .lineLimit(1)
                            .font(Fonts.subtitle)
                    }
                    
                    ad.media.map {
                        Image(uiImage: $0)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    VStack(alignment: .leading, spacing: 24) {
                        Text(ad.description)
                            .lineLimit(3)
                            .font(Fonts.subtitle)
                        
                        Text("Реклама \(ad.ageRestrictions)")
                            .lineLimit(1)
                            .font(Fonts.body)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(16)
                
                Button(action: {}) {
                    Text("\(ad.ctaText)")
                        .font(Fonts.button)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue.cornerRadius(20, corners: .topLeft))
                }
            }
            .background(Colors.mainBackground)
            .cornerRadius(20)
            .shadow(color: shadowColor, radius: 4, x: 0, y: 0)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(width: UIScreen.main.bounds.width > 400 ? 400 : nil)
            
        } else {
            EmptyView()
        }
    }
}

struct NativeBannerView_Previews: PreviewProvider {
    static var previews: some View {
        NativeAdView()
    }
}
