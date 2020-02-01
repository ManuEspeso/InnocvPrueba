//
//  ViewController.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 31/01/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//


import UIKit

class UsersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mTableView: UITableView!
    
    //var presenter: UsersListPresenter!
    var users: [User] = []
    let dataMapper = DataMapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mTableView.delegate = self
        mTableView.dataSource = self
        
        navigationItem.title = "Users"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewUser))
    }
    override func viewWillAppear(_ animated: Bool) {
        getUsersFromApiRequest()
    }
    
    func getUsersFromApiRequest() {
        dataMapper.getAllUsers(){
            result, error in
            if error != nil {
                //enseñar alerta aqui
            }
            if let result = result as? [User] {
                self.users = result
                self.mTableView.reloadData()
            }
        }
    }
    
    @objc func addNewUser() {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersViewCell", for: indexPath)
        
        (cell as? UsersViewCell)?.update(data: users[indexPath.row])
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        /*let formatter = DateFormatter()
         formatter.locale = Locale.current
         formatter.dateStyle = .medium*/
        //cell.detailTextLabel?.text = formatter.string(from: user.birthdate)
        return cell
    }
}

