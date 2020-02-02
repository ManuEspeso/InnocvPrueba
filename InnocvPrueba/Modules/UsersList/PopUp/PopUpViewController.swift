//
//  PopUpViewController.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 02/02/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var createUserLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    
    @IBOutlet weak var nameUser: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func createUser(_ sender: Any) {
        createUser()
    }
    @IBAction func cancelNewUser(_ sender: Any) {
        dismiss(animated: true)
    }
    
    var presenter = UsersListPresenterDefault()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUserLabel.text = create_user.toLocalized()
        nameLabel.text = name.toLocalized()
        birthdateLabel.text = birthdate.toLocalized()
    }
    //Get select date from DatePicker
    func handler(sender: UIDatePicker) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = DateFormatter.Style.long
        let strDate = timeFormatter.string(from: datePicker.date)
        
        return strDate
    }
    //Get user name and his birthdate date and if isn`t empty call to presenter for add this user in to innocv database. in case some datas are empty an alert throws for give some informtion to the user
    func createUser() {
        guard let name = nameUser.text else { return }
        let birthdate = handler(sender: datePicker)
        
        if name.isEmpty {
            self.showAlert(alertText: empty_file.toLocalized(), alertMessage: empty_file_message.toLocalized())
        } else {
            presenter.createUser(name: name, birthdate: birthdate)
            dismiss(animated: true)
        }
    }
}
