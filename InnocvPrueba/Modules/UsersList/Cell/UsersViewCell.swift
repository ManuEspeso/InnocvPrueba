//
//  UsersViewCell.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 31/01/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//

import UIKit

class UsersViewCell: UITableViewCell {
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBirthdate: UILabel!
    
    
    override func prepareForReuse() {
        userID.text = nil
        userName.text = nil
        userBirthdate.text = nil
    }
    
    private func update(id: String?) {
        
        userID.text = id
    }
    
    private func update(name: String?) {
        
        userName.text = name
    }
    
    private func update(birthdate: Date?) {
        guard let birthdate = birthdate?.toFormattedString(with: "YYYY") else {
            return
        }
        userBirthdate.text = birthdate
    }
    
    func update(data user: String) {
                
        update(id: user)
        update(name: user)
        update(birthdate: Calendar.current.date(from: DateComponents(year: 2020)))
    }
}
