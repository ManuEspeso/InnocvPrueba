//
//  DataMappet.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 31/01/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class DataMapper {
    
    typealias DataMapperCompletion = (_ result: Any?, _ error: Error?) -> Void
    
    let locale = "es"
    let timestamp = NSDate().timeIntervalSince1970
    var connection: RestManager = Connection()
    
    func checkHttpStatus(httpCode: Int) -> Bool{
        
        switch httpCode {
            
        case 200..<299:
            return true
        case 401:
            print("unauthorized")
            return false
        case 403:
            print("forbidden")
            return false
        case 404:
            print("not_found_error")
            return false
        case 500...503:
            print("not_found_error")
            return false
        case 0:
            print("ERROR")
            return false
        default:
            print("*** ERROR POR DEFECTO")
            return false
        }
        
    }
    
    func getUser(userId: Int, completion: @escaping DataMapperCompletion) {
        
        let url = "/User/\(userId)"
        
        connection.get(url, params: ["id":userId], encode: URLEncoding.default) {
            httpStatus, json, responseHeaders, error in
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                if let item = User(jsonData: try? json.rawData()) {
                    completion(item, nil)
                } else {
                    completion(nil, nil)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    func getAllUsers(completion: @escaping DataMapperCompletion) {
        let url = "/User/"
        
        connection.get(url, params:nil, encode: URLEncoding.default) {
            httpStatus, json, responseHeaders, error in
            if self.checkHttpStatus(httpCode: httpStatus), let json = json {
                let items = json.arrayValue.compactMap {
                    return User(jsonData: try? $0.rawData())
                }
                completion(items, nil)
            } else {
                
                completion(nil, error)
            }
        }
    }
    
    func createUser(user: User, completion: @escaping DataMapperCompletion) {
        let url = "/User/"
        
        connection.post(url, params:user.params, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            if self.checkHttpStatus(httpCode: httpStatus) {
                
                completion(nil, nil)
            } else {
                
                completion(nil, error)
            }
        }
    }
    
    func updateUser(user: User,completion: @escaping DataMapperCompletion) {
        let url = "/User/"
        
        connection.put(url, params: user.params, encode: JSONEncoding.default) {
            httpStatus, json, responseHeaders, error in
            if self.checkHttpStatus(httpCode: httpStatus) {
                
                completion(nil, nil)
            } else {
                
                completion(nil, error)
            }
        }
    }
    
    func deleteUser(userId: Int, completion: @escaping DataMapperCompletion) {
        let url = "/User/\(userId)"
        
        connection.delete(url, params: nil, encode: URLEncoding.default) {
            httpStatus, json, responseHeaders, error in
            if self.checkHttpStatus(httpCode: httpStatus) {
                
                completion(nil, nil)
            }else {
                
                completion(nil, error)
            }
        }
    }
}
