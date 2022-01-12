//
//  NewsDTO.swift
//  News
//
//  Created by Дмитрий Мельников on 04.01.2022.
//

import Foundation

protocol NewsDTO: Decodable {
    var id: UUID { get }
    var imageURL: String { get }
    var title: String { get }
    var newsURL: String { get }
    var author: String { get }
    var authorURL: String { get }
    var date: Date { get }
}
