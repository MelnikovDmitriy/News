//
//  ErrorModelFactory.swift
//  News
//
//  Created by Дмитрий Мельников on 06.01.2022.
//

import Foundation

struct ErrorModelFactory {

    var newsWebViewLoadingError: ErrorModel {
        .init(
            title: "Ошибочка",
            subtitle: "Статейку загрузить не вышло",
            action: {},
            actionTitle: "",
            cancel: nil
        )
    }

    func map(_ error: NewsProviderError, action: @escaping () -> Void, cancel: (() -> Void)? = nil) -> ErrorModel? {
        switch error {
        
        case .invalidURL:
            return nil
       
        case .connectionFail:
            return .init(
                title: "Кажись нету интернету",
                subtitle: "А может и что-то другое приключилось. Мы сами не знаем",
                action: action,
                actionTitle: "Повторить",
                cancel: cancel
            )
        
        case .statusCodeIsNotOK:
            return .init(
                title: "Что-то сервер не отвечает",
                subtitle: "Наверное накатывают улучшения для нас любимых",
                action: action,
                actionTitle: "Повторить",
                cancel: cancel
            )
        
        case .responseDecodingFail:
            return nil
            
        case .emptyResponse:
            return  .init(
                title: "Новостей нет",
                subtitle: "Очень странные дела. Похоже кто-то снес базу на сервере",
                action: action,
                actionTitle: "Попробовать еще раз",
                cancel: cancel
            )
        }
    }
}
