//
//  ViewController.swift
//  ceiba-test
//
//  Created by Jc on 21/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var searchContent: UIView!
    
    private typealias homeCell = HomeItemTableViewCell
    private var viewModel: UserViewModel!
    private var emptyView = EmptyResponse()
    
    struct Constants {
        static let cellName = "HomeItemTableViewCell"
        static let cellHeight: CGFloat = 330
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserViewModel(appDelegate: (UIApplication.shared.delegate as? AppDelegate)!)
        setupView()
        setupTableView()
        setupViewModel()
    }
    
    @IBAction func change(_ sender: Any) {
        viewModel.searchUser(from: search.text ?? "")
    }
    
    func setupViewModel() {
        viewModel.handleDataLoadComplete = { [unowned self] in
            self.tableView.reloadData()
        }
        
        viewModel.handleSearchComplete = { [unowned self] in
            if self.viewModel.users.count == 0 {
                if !self.emptyView.isDescendant(of: self.view) {
                    self.setupAnimation()
                }
            } else {
                self.emptyView.removeFromSuperview()
            }
            self.tableView.reloadData()
        }
        
        viewModel.loadUsers()
    }
    
    func goToPost(of userId: Int) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserPostVC") as! UserPostVC
        guard let user = viewModel.getUser(from: userId) else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.viewModel.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC {
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: Constants.cellName, bundle: Bundle.main), forCellReuseIdentifier: Constants.cellName)
    }
    
    func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        search.borderStyle = .none
        search.setLeftPaddingPoints(32)
        searchContent.addShadow()
        tableView.keyboardDismissMode = .onDrag
    }
    
    func setupAnimation() {
        emptyView = EmptyResponse()
        emptyView.setupView()
        emptyView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 7, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 3))
        self.view.addSubview(self.emptyView)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath) as! homeCell
        let user = viewModel.users[indexPath.row]
        cell.selectionStyle = .none
        cell.userId = user.id
        cell.name = user.name
        cell.phone = user.phone
        cell.email = user.email
        cell.setMapView(geo: Geo(lat: "21.282778", lng: "-157.829444"))
        
        cell.handleShowMore = { [unowned self] userId in
            self.goToPost(of: userId)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}

