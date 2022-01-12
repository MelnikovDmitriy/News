//
//  GamesMailRuNewsProvider.swift
//  News
//
//  Created by Дмитрий Мельников on 02.01.2022.
//

import Foundation

final class GamesMailRuNewsProvider {
    
    private let initialURL = "https://api.games.mail.ru/pc/v2/index?limit=\(Config.newsLimit)&page=1"
    private var nextPageURL: String?

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        return formatter
    }()
    
    private func fetchData(url: String, completion: @escaping(Result<[NewsDTO], NewsProviderError>) -> Void) {
        guard let url = URL(string: url) else {
            NSLog("Invalid request URL. Check api.games.mail.ru please")
            return completion(.failure(.invalidURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                NSLog("api.games.mail.ru request error: \(error.localizedDescription)")
                return completion(.failure(.connectionFail))
            }
            
            if let urlResponse = urlResponse as? HTTPURLResponse, urlResponse.statusCode != 200 {
                NSLog("api.games.mail.ru response status code is: \(urlResponse.statusCode)")
                return completion(.failure(.statusCodeIsNotOK))
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(self.dateFormatter)
                    let response = try decoder.decode(Response.self, from: data)
                    self.nextPageURL = response.next
                    completion(.success(response.results))
                    
                } catch {
                    NSLog("NewsAPI.Response Decoding fail: \(error)")
                    completion(.failure(.responseDecodingFail))
                }
            }
        }
        .resume()
    }
}

// MARK: - News Provider
extension GamesMailRuNewsProvider: NewsProvider {
    var availableMoreNews: Bool {
        nextPageURL != nil
    }
    
    func refreshNews(_ completion: @escaping(Result<[NewsDTO], NewsProviderError>) -> Void) {
        fetchData(url: initialURL, completion: completion)
    }
    
    func loadMoreNews(_ completion: @escaping(Result<[NewsDTO], NewsProviderError>) -> Void) {
        if let nextPageURL = nextPageURL {
            fetchData(url: nextPageURL, completion: completion)
        }
    }
}

// MARK: - Config
private extension GamesMailRuNewsProvider {
    enum Config {
        static let newsLimit = 15
    }
}
