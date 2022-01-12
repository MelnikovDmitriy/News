//
//  NewsProvider.swift
//  News
//
//  Created by Дмитрий Мельников on 04.01.2022.
//

import Foundation

protocol NewsProvider {
    var availableMoreNews: Bool { get }
    
    func refreshNews(_ completion: @escaping(Result<[NewsDTO], NewsProviderError>) -> Void)
    func loadMoreNews(_ completion: @escaping(Result<[NewsDTO], NewsProviderError>) -> Void)
}
