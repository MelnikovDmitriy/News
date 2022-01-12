//
//  GamesMailRuNewsDTO.swift
//  News
//
//  Created by Дмитрий Мельников on 02.01.2022.
//

import Foundation

struct GamesMailRuNewsDTO: Decodable, NewsDTO {
    let id: UUID
    let imageURL: String
    let title: String
    let newsURL: String
    let author: String
    let authorURL: String
    let date: Date
}

extension GamesMailRuNewsDTO {
    enum CodingKeys: CodingKey {
        case picture
        case name
        case url
        case author
        case date_published
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let imagePath = try container.decode(String.self, forKey: .picture)
        let resizerPath = "https://games.mail.ru/pre_0x291_resize"
        imageURL = resizerPath + imagePath

        let newsPath =  try container.decode(String.self, forKey: .url)
        let baseURL = "https://games.mail.ru"
        newsURL = baseURL + newsPath
        
        let authorDTO = try container.decode(AuthorDTO.self, forKey: .author)
        author = authorDTO.nick
        authorURL = authorDTO.url

        id = UUID()
        title = try container.decode(String.self, forKey: .name)
        date = try container.decode(Date.self, forKey: .date_published)
    }
}

private extension GamesMailRuNewsDTO {
    struct AuthorDTO: Decodable {
        let nick: String
        let url: String
    }
}
