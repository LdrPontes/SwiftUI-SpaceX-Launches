//
//  ResultStatus.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 01/04/24.
//

import Foundation

enum ResultStatus<T> {
    case Idle
    case Success(data: T)
    case Failure(code: Int, message: String, exception: Error)
    case Loading
}
