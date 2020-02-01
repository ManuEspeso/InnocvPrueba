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

extension UIViewController {
    //Show a basic alert
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: got_it.toLocalized(), style: UIAlertAction.Style.default, handler: nil))
        //Add more actions as you see fit
        self.present(alert, animated: true, completion: nil)
    }
}

extension Mapping {
    
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

extension String {
    
    func toLocalized() -> String {
        return NSLocalizedString(self,
                                 comment:"")
    }
}

let something_wrong = "message_principal_error"
let unknoun = "unknoun"

let users_title = "users"
let got_it = "got_it"

let connection_lost = "connection_lost"
let check_wifi = "check_wifi"

let unauthorized = "unauthorized"
let not_found_error = "not_found_error"
let network_down = "network_down"
