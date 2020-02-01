//
//  User.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 31/01/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//

import Foundation

struct User {
    let id: Int?
    var name: String?
    var birthdate = Date()
    
    /*private let dateFormatter: DateFormatter = {
     let formatter = DateFormatter()
     formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
     
     return formatter
     }()*/
    
    init(id: Int, name: String, birthdate: Date) {
        self.id = id
        self.name = name
        self.birthdate = birthdate
    }
}
