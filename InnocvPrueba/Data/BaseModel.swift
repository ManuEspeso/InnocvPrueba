//
//  BaseModel.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 31/01/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//

import Foundation

protocol Mappable: Codable {
    init?(jsonData: Data?)
}

extension Mappable {
    
    init?(jsonData: Data?) {
        
        guard let data = jsonData else { return nil }
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        }
        catch {
            return nil
        }
    }
}
