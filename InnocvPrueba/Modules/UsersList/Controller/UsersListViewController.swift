//
//  ViewController.swift
//  InnocvPrueba
//
//  Created by Manu Espeso on 31/01/2020.
//  Copyright © 2020 Manu Espeso. All rights reserved.
//


import UIKit

protocol UsersListView: class {
    func loadData()
}

class UsersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UsersListView {
    
    @IBOutlet weak var mTableView: UITableView!
    
    var presenter = UsersListPresenterDefault()
    var users: [User] = []
    let dataMapper = DataMapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mTableView.delegate = self
        mTableView.dataSource = self
        
        presenter.onViewdidLoad(view: self)
        
        navigationItem.title = "Users"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewUser))
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    func loadData() {
        self.mTableView.reloadData()
    }
    
    @objc func addNewUser() {
        presenter.addUserButtonTap()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersViewCell", for: indexPath)
        let user = presenter.user(for: indexPath.section, at: indexPath.row)
        
        (cell as? UsersViewCell)?.update(data: user)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectUser(for: indexPath.section, at: indexPath.row)
    }
}

