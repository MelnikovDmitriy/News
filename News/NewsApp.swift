//
//  NewsApp.swift
//  News
//
//  Created by Дмитрий Мельников on 12.01.2022.
//

import SwiftUI

@main
struct NewsApp: App {
    
    @StateObject var newsListViewModel = NewsListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NewsListView(model: newsListViewModel)
        }
    }
}
