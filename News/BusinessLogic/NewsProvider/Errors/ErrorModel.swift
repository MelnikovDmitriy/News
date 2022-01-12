//
//  ErrorModel.swift
//  News
//
//  Created by Дмитрий Мельников on 06.01.2022.
//

import Foundation

struct ErrorModel {
    let title: String
    let subtitle: String
    let action: () -> Void
    let actionTitle: String
    let cancel: (() -> Void)?
}
