//
//  Connection.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 31/01/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

typealias ConnectionCompletion = (_ httpStatus: Int, _ response: JSON?, _ responseHeaders: [AnyHashable: Any], _ error: Error?) -> Void
typealias ConnectionPdf = (_ httpStatus: Int, _ response: Data?, _ responseHeaders: [AnyHashable: Any], _ error: Error?) -> Void

protocol RestManager {
    var httpHeaders: HTTPHeaders? { get set }
    func connect(to url: String, method: HTTPMethod, params: [String: Any]?, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    func put(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    func delete(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    func post(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion)
    func get(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion)
}

class Connection: RestManager {
    
    let baseUrlString = "https://hello-world.innocv.com/api"
    let sessionManager: SessionManager
    var httpHeaders: HTTPHeaders?
    
    init() {
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["API-Version"] = "1.0"
        headers["Authorization"] = ""
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.httpAdditionalHeaders = headers
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func connect(to url: String, method: HTTPMethod, params: [String: Any]?, encode: ParameterEncoding, completion: @escaping ConnectionCompletion) -> Void {
        sessionManager.request(url, method: method, parameters: params,encoding: encode, headers: httpHeaders).responseData {
            response in
            
            let httpCode = response.response?.statusCode ?? 0
            let responseHeaders = response.response?.allHeaderFields ?? [AnyHashable: Any]()
            
            var json: JSON? = nil
            
            if let data = response.result.value {
                json = try? JSON(data: data)
            }
            completion(httpCode, json, responseHeaders, response.error)
        }
    }
    
    func completeUrlString(forEndpoint endpoint: String) -> String {
        if endpoint.contains("http") { return endpoint }
        return baseUrlString + endpoint
    }
    
    
    func delete(_ endpoint: String, params: [String: Any]?, encode :ParameterEncoding = URLEncoding.default, completion: @escaping ConnectionCompletion) {
        connect(to: completeUrlString(forEndpoint: endpoint), method: .delete, params: params, encode: encode, completion: completion)
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func post(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion) {
        connect(to: completeUrlString(forEndpoint: endpoint), method: .post, params: params, encode: encode,  completion: completion)
    }
    
    func get(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion) {
        connect(to: completeUrlString(forEndpoint: endpoint), method: .get, params: params, encode: encode,  completion: completion)
    }
    
    func put(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion) {
        connect(to: completeUrlString(forEndpoint: endpoint), method: .put, params: params, encode: encode,  completion: completion)
    }
    
    
}
