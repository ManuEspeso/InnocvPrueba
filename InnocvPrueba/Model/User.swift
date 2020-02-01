//
//  User.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 31/01/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//

import Foundation

struct User: Mappable {
    var id: Int? = 0
    var name: String? = ""
    var birthdate: String? = ""
   
    
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
