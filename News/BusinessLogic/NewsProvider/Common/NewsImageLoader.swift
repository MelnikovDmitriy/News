//
//  NewsImageLoader.swift
//  News
//
//  Created by Дмитрий Мельников on 05.01.2022.
//

import UIKit

struct NewsImageLoader {
    func loadImage(imageURL: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: imageURL) else {
            NSLog("Invalid image url: \(imageURL)")
            return completion(.failure(NewsProviderError.invalidURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                NSLog("\(url) error: \(error.localizedDescription)")
                return completion(.failure(NewsProviderError.connectionFail))
            }
            
            if let urlResponse = urlResponse as? HTTPURLResponse, urlResponse.statusCode != 200 {
                NSLog("\(url) response status code is: \(urlResponse.statusCode)")
                return completion(.failure(NewsProviderError.statusCodeIsNotOK))
            }
            
            if let data = data,
               let uiImage = UIImage(data: data) {
                completion(.success(uiImage))
            
            } else {
                NSLog("Image decoding fail. ImageURL: \(url)")
                completion(.failure(NewsProviderError.responseDecodingFail))
            }
        }
        .resume()
    }
}
