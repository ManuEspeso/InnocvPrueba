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
    func createUser(name: String, birthdate: String)
    func user(at index: Int) -> User
    func selectUser(at index: Int)
    func dropUser(at index: Int)
    func searchUser(userID: String)
}

class UsersListPresenterDefault: UIViewController, UsersListPresenter {
    
    var users: [User] = []
    var user: User? = nil
    var userDetail: [User] = []
    let dataMapper = DataMapper()
    private weak var usersView: UsersListView!
    
    func onViewdidLoad(view: UsersListView) {
        self.usersView = view
    }
    
    var numberOfUsers: Int {
        return users.count
    }
    //Get all the users from the innocv api and if the results is not null set it the array and callback to the ViewController, in case if something`s wrong a alert will display for give some information to the user
    func viewWillAppear() {
        if dataMapper.checkInternet() {
            dataMapper.getAllUsers(){
                result, error in
                if error != nil {
                    self.showAlert(alertText: something_wrong.toLocalized(), alertMessage: something_wrong.toLocalized())
                }
                if let result = result as? [User] {
                    self.users = result
                    self.usersView.loadData()
                }
            }
        } else {
            self.showAlert(alertText: connection_lost.toLocalized(), alertMessage: check_wifi.toLocalized())
        }
    }
    //Get the name and birthdate from the pupUp view, added in to modal User and create this user, in case if something`s wrong a alert will display for give some information to the user
    func createUser(name: String, birthdate: String) {
        let user = User(name: name, birthdate: birthdate)
        print(user)
        dataMapper.createUser(user: user){
            result, error in
            if error == nil {
                self.showAlert(alertText: something_wrong.toLocalized(), alertMessage: something_wrong.toLocalized())
            }
        }
    }
    //Give specific user index
    func user(at index: Int) -> User {
        return users[index]
    }
    //Get specific user selected and send it in to the UsersDetailView
    func selectUser(at index: Int) {
        let user = users[index]
        self.usersView.goToUsersDetailPage(userSelected: user)
    }
    //Get specific user selected, remove it from the array and later remove it calling api with his id
    func dropUser(at index: Int) {
        let user = users[index]
        users.remove(at: index)
        
        if dataMapper.checkInternet() {
            dataMapper.deleteUser(userId: user.id){
                result, error in
            }
        } else {
            self.showAlert(alertText: connection_lost.toLocalized(), alertMessage: check_wifi.toLocalized())
        }
    }
    //Call innocv api with userId and the api callback the specific user who is send it to the tableview for visualize in the cell
    func searchUser(userID: String) {
        if dataMapper.checkInternet() {
            dataMapper.getUser(userId: userID){
                result, error in
                if error != nil {
                    self.showAlert(alertText: something_wrong.toLocalized(), alertMessage: error as! String)
                }
                if let result = result as? User {
                    self.user = result
                    self.users.removeAll()
                    self.users.append(self.user!)
                    self.usersView.loadData()
                }
            }
        } else {
            self.showAlert(alertText: connection_lost.toLocalized(), alertMessage: check_wifi.toLocalized())
        }
    }
}
