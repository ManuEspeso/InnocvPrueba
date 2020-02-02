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

class UsersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UsersListView {
    
    @IBOutlet weak var mTableView: UITableView!
    
    var presenter = UsersListPresenterDefault()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mTableView.delegate = self
        mTableView.dataSource = self
        
        presenter.onViewdidLoad(view: self)
        
        navigationItem.title = users_title.toLocalized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewUser))
        
        setupSearchBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    func setupSearchBar() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            
            mTableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
    }
    
    func loadData() {
        self.mTableView.reloadData()
    }
    
    @objc func addNewUser() {
        presenter.addUserButtonTap()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersViewCell", for: indexPath)
        let user = presenter.user(at: indexPath.row)
        
        (cell as? UsersViewCell)?.update(data: user)
        var view = UIView()
        view = view.setUpTableViewCell()
        view.frame = cell.contentView.bounds.insetBy(dx: 4 , dy: 4)
        cell.contentView.addSubview(view)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectUser(at: indexPath.row)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchUserText = searchController.searchBar.text!
        if searchUserText.count == 0 {
            presenter.viewWillAppear()
        } else {
            presenter.searchUser(userID: searchUserText)
        }
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
