//
//  UsersListPresenter.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 01/02/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//

import Foundation
import UIKit

protocol UsersListPresenter {
    var numberOfUsers: Int { get }
    func viewWillAppear()
    func addUserButtonTap()
    func user(at index: Int) -> User
    func selectUser(at index: Int)
}

class UsersListPresenterDefault: UIViewController, UsersListPresenter {
    
    var users: [User] = []
    var userDetail: [User] = []
    let dataMapper = DataMapper()
    private weak var usersView: UsersListView!
    
    func onViewdidLoad(view: UsersListView) {
        self.usersView = view
    }
    
    var numberOfUsers: Int {
        return users.count
    }
    
    func viewWillAppear() {
        if dataMapper.checkInternet() {
            dataMapper.getAllUsers(){
                result, error in
                if error != nil {
                    self.showAlert(alertText: "Something Wrong", alertMessage: error as! String)
                }
                if let result = result as? [User] {
                    self.users = result
                    self.usersView.loadData()
                }
            }
        } else {
            self.showAlert(alertText: "Connection Lost", alertMessage: "Check your wifi connection")
        }
    }
    
    func addUserButtonTap() {
        print("boton mas pulsado")
    }
    
    func user(at index: Int) -> User {
        return users[index]
    }
    
    func selectUser(at index: Int) {
        let user = users[index]
        self.usersView.goToUsersDetailPage(userSelected: user)
        /*dataMapper.getUser(userId: user.id!) {result, error in
            print("entro")
            if error != nil {
                self.showAlert(alertText: "Something Wrong", alertMessage: error as! String)
            }
            if let result = result as? [User] {
                print("va bien")
                self.userDetail = result
                print(self.userDetail)
                //self.usersView.loadData()
            }
        }*/
    }
}
