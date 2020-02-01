//
//  Extensions.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 31/01/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//

import UIKit

extension Date {
     
    func toFormattedString(with format: String = "eeee dd 'de' MMMM 'de' yyyy", locale: String = "es_ES") -> String {
        let mDateFormatted = DateFormatter()
        
        mDateFormatted.locale = Locale(identifier: locale)
        mDateFormatted.dateFormat = format
        
        return mDateFormatted.string(from: self)
    }
}
