//
//  NewsProviderError.swift
//  News
//
//  Created by Дмитрий Мельников on 05.01.2022.
//

import Foundation

enum NewsProviderError: Error {
    case invalidURL
    case connectionFail
    case statusCodeIsNotOK
    case responseDecodingFail
}
