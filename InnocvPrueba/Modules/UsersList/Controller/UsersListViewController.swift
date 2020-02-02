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
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mTableView.delegate = self
        mTableView.dataSource = self
        
        presenter.onViewdidLoad(view: self)
        
        navigationItem.title = users_title.toLocalized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewUser))
        
        septUpRefreshControl()
        setupSearchBar()
    }
    @objc func addNewUser() {
        goToNewUserPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    //Create refreshControl in view for reload the table view
    func septUpRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: pull_refresh.toLocalized())
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        mTableView.addSubview(refreshControl)
    }
    @objc func refresh() {
        presenter.viewWillAppear()
    }
    //Create the searchBar element in view
    func setupSearchBar() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            mTableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
    }
    //funcio colled normaly in the presenter for reload the table view in case the table view modificated or stop refreshing if refreshControl element call it
    func loadData() {
        self.mTableView.reloadData()
        refreshControl.endRefreshing()
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
        //set to UsersViewCell the specific user in specific cell for set his datas in to the correct cell
        (cell as? UsersViewCell)?.update(data: user)
        var view = UIView()
        //view extension for make the cell prettiest
        view = view.setUpTableViewCell()
        view.frame = cell.contentView.bounds.insetBy(dx: 4 , dy: 4)
        cell.contentView.addSubview(view)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectUser(at: indexPath.row)
    }
    //Function for make cell editable because I wont to get the funcionality for drag horizontal for delete it
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //this funcion will get the cell drag who the user wants delete and first of all set a alert if his sure for later delete the user dragged
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: delete_user.toLocalized()) {
            (contextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            
            let alert = UIAlertController(title: delete_user.toLocalized(), message: drop_user.toLocalized(), preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: cancel.toLocalized(), style: .cancel, handler: { (alertAction) in actionPerformed(false)
            }))
            alert.addAction(UIAlertAction(title: delete_user.toLocalized(), style: .destructive, handler: { (alertAction) in
                self.presenter.dropUser(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            }))
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    //this funcion will listening all the time in the searchBar and get all the time each letter who the user write it, if the user hasn`t write anything the tableview are going to refresh and in the other case is going to search the user who is write
    func updateSearchResults(for searchController: UISearchController) {
        let searchUserText = searchController.searchBar.text!
        if searchUserText.count == 0 {
            presenter.viewWillAppear()
        } else {
            presenter.searchUser(userID: searchUserText)
        }
    }
    //Navigation for UsersListDetailViewController
    func goToUsersDetailPage(userSelected: User) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "UsersListDetailViewController") as? UsersListDetailViewController {
            
            controller.modalTransitionStyle = .flipHorizontal
            controller.modalPresentationStyle = .popover
            controller.set(data: userSelected)
            
            present(controller, animated: true, completion: nil)
        }
    }
    //Navigation for PopUpViewController
    func goToNewUserPage() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "PopUpView") as? PopUpViewController {
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        }
    }
}
