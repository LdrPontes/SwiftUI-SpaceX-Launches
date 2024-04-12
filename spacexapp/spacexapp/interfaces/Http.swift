//
//  Http.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 08/04/24.
//

import Foundation

class Http {
    private let baseUrl: URL
    
    init(baseUrl: String) {
        self.baseUrl = URL(string: baseUrl)!
    }
    
    func get(_ url: String, queryParams: [String: String]? = nil, header: [String: String]? = nil) async throws -> (Data, HTTPURLResponse?) {
        var urlString: String = baseUrl.appendingPathComponent(url).absoluteString
        
        if let queryParams = queryParams {
            let queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
            if var urlComponents = URLComponents(string: urlString) {
                urlComponents.queryItems = queryItems
                urlString = urlComponents.url!.absoluteString
            }
        }
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
    
        request.httpMethod = "GET"
        
        return try await handler(request)
    }
    
    private func handler(_ urlRequest: URLRequest) async throws -> (Data, HTTPURLResponse?) {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                let message = getMessageFromData(data)
                
                try handleErrorStatusCode(statusCode, message: message)
                
                return (data, httpResponse)
            } else {
                throw NetworkError.UnknownError()
            }
        } catch let networkError as NetworkError {
            throw networkError
        } catch let urlError as URLError{
            if urlError.code == .notConnectedToInternet {
                throw NetworkError.NoInternetConnectionError
            }
            
            throw NetworkError.UnknownError()
        }
    }
    
    private func getMessageFromData(_ data: Data) -> String? {
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return jsonObject["message"] as? String
        } else {
            return nil
        }
    }
    
    private func handleErrorStatusCode(_ statusCode: Int, message: String?) throws {
        switch statusCode {
        case 200...299:
            return
        case 400:
            throw NetworkError.BadRequestError(message)
        case 401:
            throw NetworkError.UnauthorizedError(message)
        case 404:
            throw NetworkError.NotFoundError(message)
        case 500:
            throw NetworkError.ServerError(message)
        default:
            throw NetworkError.UnknownError(message)
        }
    }
}
