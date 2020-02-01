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

class DataMapper: UIViewController {
    
    typealias DataMapperCompletion = (_ result: Any?, _ error: Error?) -> Void
    
    var connection: RestManager = Connection()
    
    func checkHttpStatus(httpCode: Int) -> Bool{
        switch httpCode {
        case 200..<299:
            return true
        case 401:
            self.showAlert(alertText: "Something Wrong", alertMessage: "unauthorized")
            return false
        case 403:
            self.showAlert(alertText: "Something Wrong", alertMessage: "forbidden")
            return false
        case 404:
            self.showAlert(alertText: "Something Wrong", alertMessage: "not_found_error")
            return false
        case 500...503:
            self.showAlert(alertText: "Something Wrong", alertMessage: "network_down")
            return false
        default:
            return false
        }
    }
    
    func checkInternet() -> Bool {
        let conexion = connection.isInternetAvailable()
        return conexion
    }
    
    func getUser(userId: Int, completion: @escaping DataMapperCompletion) {
        connection.get("/User/\(userId)", params: ["id": userId], encode: URLEncoding.default) {
            httpStatus, json, _, error in
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
        connection.get("/User/", params:nil, encode: URLEncoding.default) {
            httpStatus, json, _, error in
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
        connection.post(params:user.params, encode: JSONEncoding.default) {
            httpStatus, json, _, error in
            if self.checkHttpStatus(httpCode: httpStatus) {
                completion(nil, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func updateUser(user: User,completion: @escaping DataMapperCompletion) {
        connection.put(params: user.params, encode: JSONEncoding.default) {
            httpStatus, json, _, error in
            if self.checkHttpStatus(httpCode: httpStatus) {
                completion(nil, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func deleteUser(userId: Int, completion: @escaping DataMapperCompletion) {
        connection.delete("/User/\(userId)", params: nil, encode: URLEncoding.default) {
            httpStatus, json, _, error in
            if self.checkHttpStatus(httpCode: httpStatus) {
                completion(nil, nil)
            }else {
                completion(nil, error)
            }
        }
    }
}
