//
//  Error.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 08/04/24.
//

import Foundation

enum NetworkError: Error {
    case UnknownError(String? = nil)
    case NotFoundError(String? = nil)
    case ServerError(String? = nil)
    case UnauthorizedError(String? = nil)
    case BadRequestError(String? = nil)
    case NoInternetConnectionError
}
