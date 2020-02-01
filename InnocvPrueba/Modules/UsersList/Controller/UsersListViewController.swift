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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mTableView.delegate = self
        mTableView.dataSource = self
        
        navigationItem.title = "Users"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewUser))
    }
    
    @objc func addNewUser() {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersViewCell", for: indexPath)
        
        //let user = presenter.user(for: indexPath.section, at: indexPath.row)
        //cell.textLabel?.text = user.name
        
        (cell as? UsersViewCell)?.update(data: "hola")
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

