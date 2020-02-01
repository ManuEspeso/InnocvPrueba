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
    
    private func update(id: Int?) {
        guard let safeID = id else { return }
        userID.text = "\(safeID)"
    }
    
    private func update(name: String?) {
        userName.text = name
    }
    
    private func update(birthdate: String?) {
        userBirthdate.text = birthdate
    }
    
    func update(data user: User?) {
                
        update(id: user?.id )
        update(name: user?.name)
        update(birthdate: user?.birthdateFormatted)
    }
}
