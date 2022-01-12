//
//  GamesMailRuNewsProvider+Response.swift
//  News
//
//  Created by Дмитрий Мельников on 02.01.2022.
//

import Foundation

extension GamesMailRuNewsProvider {
    struct Response: Decodable {
        let next: String?
        let results: [GamesMailRuNewsDTO]
    }
}
