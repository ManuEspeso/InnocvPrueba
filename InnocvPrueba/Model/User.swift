//
//  User.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 31/01/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//

import Foundation

protocol Mapping: Codable {
    init?(jsonData: Data?)
}

struct User: Mapping {
    var id: Int? = 0
    var name: String? = ""
    var birthdate: String? = ""
    var birthdateFormatted: String {
        if let dateString = self.birthdate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-ddEhh:mm:ss"
            let dateObj = dateFormatter.date(from: dateString)
            if dateObj == nil { return "unknoun"}
            return dateFormatter.string(from: dateObj!)
        }
        return "unknow"
    }
    
    init(id: Int?, name: String?, birthdate: String?) {
        self.id = id
        self.name = name
        self.birthdate = birthdate
    }
    
    var params: [String: Any] {
        return ["name":name ?? "nil",
                "birthdate": birthdate ?? "nil",
                "id":id ?? 0
        ]
    }
}
