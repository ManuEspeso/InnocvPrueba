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
    //Before anything check the status api call and in casi if something is worng set an alert to the user for give it some information
    func checkHttpStatus(httpCode: Int) -> Bool{
        switch httpCode {
        case 200..<299:
            return true
        case 401:
            self.showAlert(alertText: something_wrong.toLocalized(), alertMessage: unauthorized.toLocalized())
            return false
        case 404:
            self.showAlert(alertText: something_wrong.toLocalized(), alertMessage: not_found_error.toLocalized())
            return false
        case 500:
            self.showAlert(alertText: something_wrong.toLocalized(), alertMessage: network_down.toLocalized())
            return false
        default:
            return false
        }
    }
    //Call method who return true if the connection is avaliable or not if is not
    func checkInternet() -> Bool {
        let conexion = connection.isInternetAvailable()
        return conexion
    }
    //Call a get method who connect into innocv api and callback an specific user with his id is the same that the id who is added into url api call through params.Thanks to SwiftJSON pod when recive the json with the user this json is iterate and set into the model User for get his datas later. All this process only execute if the func for check the httpStatus callback a return a status code bettwen 200 to 299
    func getUser(userId: String, completion: @escaping DataMapperCompletion) {
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
    //Call a get method who connect into innocv api and callback a json with all the users with his datas.Thanks to SwiftJSON pod when recive the json with the users this json is mapped for iterate element by element and set into the model User for get his datas later. All this process only execute if the func for check the httpStatus callback a return a status code bettwen 200 to 299
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
    //Call a post method who connect into innocv api and add a user who contains the params added before. All this process only execute if the func for check the httpStatus callback a return a status code bettwen 200 to 299
    func createUser(user: User, completion: @escaping DataMapperCompletion) {
        connection.post(params:user.params, encode: JSONEncoding.default) {
            httpStatus, json, _, error in
            if self.checkHttpStatus(httpCode: httpStatus) {
                print(httpStatus)
                print(json as Any)
                completion(nil, error)
            } else {
                completion(nil, error)
            }
        }
    }
    //Call a delete method who connect into innocv api and with the userID who recieved by params delete this specific user from innocv database. All this process only execute if the func for check the httpStatus callback a return a status code bettwen 200 to 299
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
