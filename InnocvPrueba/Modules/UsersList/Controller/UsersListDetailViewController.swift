//
//  UsersListDetailViewController.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 01/02/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//

import UIKit

class UsersListDetailViewController: UIViewController {
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBirthdate: UILabel!
    
    private var userDetail: User? = nil
    var users: [User] = []
    
    func set(data user: User) {
        userDetail = user
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update(id: userDetail?.id)
        update(name: userDetail?.name)
        update(birthdate: userDetail?.birthdateFormatted)
    }
}
