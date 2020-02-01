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
    func goToUsersDetailPage(userSelected: User)
}

class UsersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UsersListView {
    
    @IBOutlet weak var mTableView: UITableView!
    
    var presenter = UsersListPresenterDefault()
    
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
        let user = presenter.user(at: indexPath.row)
        
        (cell as? UsersViewCell)?.update(data: user)
        let view = UIView()
        view.frame = cell.contentView.bounds.insetBy(dx: 4 , dy: 4)
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.5
        view.layer.borderColor = UIColor(red: 0, green: 0.3, blue: 0.4, alpha: 1).cgColor
        cell.contentView.addSubview(view)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectUser(at: indexPath.row)
    }
    
    func goToUsersDetailPage(userSelected: User) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "UsersListDetailViewController") as? UsersListDetailViewController {
            
            controller.modalTransitionStyle = .flipHorizontal
            controller.modalPresentationStyle = .popover
            
            controller.set(data: userSelected)
            
            present(controller, animated: true, completion: nil)
        }
    }
}
