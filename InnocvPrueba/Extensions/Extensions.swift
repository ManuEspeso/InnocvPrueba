//
//  Extensions.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 31/01/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//

import UIKit

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

extension UIView {
    func setUpTableViewCell() -> UIView {
        let view = UIView()
        
        view.layer.borderWidth = 2.5
        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.9
        view.layer.borderColor = UIColor(red: 0.7, green: 0.2, blue: 0.4, alpha: 1).cgColor
        
        return view
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

let date_format = "date_format"

let cancel = "cancel"
let delete_user = "delete_user"
let drop_user = "drop_user"

let create_user = "create_user"
let name = "name"
let birthdate = "birthdate"

let empty_file = "empty_file"
let empty_file_message = "empty_file_message"

let pull_refresh = "pull_refresh"
