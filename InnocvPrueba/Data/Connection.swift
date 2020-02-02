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
import SystemConfiguration

typealias ConnectionCompletion = (_ httpStatus: Int, _ response: JSON?, _ responseHeaders: [AnyHashable: Any], _ error: Error?) -> Void

protocol RestManager {
    var httpHeaders: HTTPHeaders? { get set }
    func connect(to url: String, method: HTTPMethod, params: [String: Any]?, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    func delete(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding, completion: @escaping ConnectionCompletion)
    func post(params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion)
    func get(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion)
    func isInternetAvailable() -> Bool
}

class Connection: RestManager {
    
    let baseUrlString = "https://hello-world.innocv.com/api"
    let sessionManager: SessionManager
    var httpHeaders: HTTPHeaders?
    //Some defaults configurations for inizialize Alamofire propertly
    init() {
        let headers = Alamofire.SessionManager.defaultHTTPHeaders
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.httpAdditionalHeaders = headers
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    //Important func who realise the api call with the params who recieved by the constructor depending on with case is call it. if the api call its ok the completion return some values like the json who callback the api, the error if something`s wrong, header...
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
    //Configure the complete url for the api request call depends who call it
    func completeUrlString(forEndpoint endpoint: String) -> String {
        if endpoint.contains("http") { return endpoint }
        return baseUrlString + endpoint
    }
    
    func delete(_ endpoint: String, params: [String: Any]?, encode :ParameterEncoding = URLEncoding.default, completion: @escaping ConnectionCompletion) {
        connect(to: completeUrlString(forEndpoint: endpoint), method: .delete, params: params, encode: encode, completion: completion)
    }
    
    func post(params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion) {
        connect(to: completeUrlString(forEndpoint: "/User/"), method: .post, params: params, encode: encode,  completion: completion)
    }
    
    func get(_ endpoint: String, params: [String: Any]?, encode: ParameterEncoding,  completion: @escaping ConnectionCompletion) {
        connect(to: completeUrlString(forEndpoint: endpoint), method: .get, params: params, encode: encode,  completion: completion)
    }
    //Check the internet from the user movile. It serves to do or not to do an internet request call and prevent possible many internet errors
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}


