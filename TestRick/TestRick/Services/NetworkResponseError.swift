//
//  NetworkResponseError.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import Foundation

enum NetworkResponseError {
    case clientError
    case badRequest
    case outdated
    case serverError
    case internetError
    case noData
    case unableToDecode
    case unknownError
}

extension NetworkResponseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .clientError:
            return NSLocalizedString("💔 Ошибка на клиенте", comment: "")
        case .badRequest:
            return NSLocalizedString("💔 Неправильный запрос!", comment: "")
        case .outdated:
            return NSLocalizedString("💔 Запрошенный вами URL-адрес устарел", comment: "")
        case .serverError:
            return NSLocalizedString("💔 Ошибка выполнения запроса!", comment: "")
        case .internetError:
            return NSLocalizedString("💔 Ошибка подключения к сети интернет!", comment: "")
        case .noData:
            return NSLocalizedString("💔 Не удалось получить данные", comment: "")
        case .unableToDecode:
            return NSLocalizedString("💔💔 Не получилось декодировать данные", comment: "")
        case .unknownError:
            return NSLocalizedString("💔💔 Неизвестная ошибка", comment: "")
        }
    }
}
