//
//  ModifiedInterceptor.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 01.06.23.
//

import Foundation
import RxNetworkApiClient
import RxSwift

/// Позволяет логировать в консоль совершаемые http запросы.
open class ModifiedInterceptor: Interceptor {

    public init() {
    }

    public func prepare<T: Codable>(request: ApiRequest<T>) {
        let urlRequest = request.request
        var parameters = ""
        if let params = urlRequest.httpBody {
            let body = String(data: params, encoding: .utf8)
                    ?? String(data: params, encoding: .ascii)
                    ?? "\(params)"
            parameters = "Parameters: \(body)"
        }

        urlRequest.allHTTPHeaderFields?.forEach { key, value in
            print(">>> Header: '\(key)' - '\(value)'")
        }
        print(">>> \(urlRequest.url!.absoluteString) [\(urlRequest.httpMethod ?? "NULL")] \(parameters)\n")
    }


    public func handle<T: Codable>(request: ApiRequest<T>, response: NetworkResponse) {
        if let urlResponse = response.urlResponse {
            var responseBody = ""
            if let _ = response.data {
                responseBody = "Body: \(response)"

            }
            guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
                print("<<< \(urlResponse.url!.absoluteString) \(responseBody)")
                return
            }
            let statusEmoji = getStatusEmoji(httpUrlResponse.statusCode)

            print("<<< \(urlResponse.url!.relativeString)")
            print("<<< Status code: (\(httpUrlResponse.statusCode)) \(statusEmoji)")
            print("<<< Body: \(responseBody)\n")
        } else {
            print("<<< nil response")
        }
    }

    private func getStatusEmoji(_ code: Int) -> String {
        if (200...300).contains(code) {
            return "👌"
        } else if (400...500).contains(code) {
            return "🤔"
        } else if (500...600).contains(code) {
            return "💥"
        }
        return ""
    }
}
extension ApiClientImp {
    
    public static func modifiedInstance(host: String) -> ApiClientImp {
        ApiEndpoint.baseEndpoint = ApiEndpoint(host)
        let apiClient = ApiClientImp(urlSession: URLSession.shared)
        apiClient.responseHandlersQueue.append(JsonResponseHandler())
        return apiClient
    }
}
