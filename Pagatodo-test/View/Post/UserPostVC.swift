//
//  UserPostVC.swift
//  ceiba-test
//
//  Created by Jc on 22/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import UIKit

class UserPostVC: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private typealias postCell = PostItemTableViewCell
    private var headerView = HeaderProfile()
    private var spinner = UIActivityIndicatorView(style: .medium)
    var viewModel: UserPostViewModel = UserPostViewModel()
    
    struct Constants {
        static let cellName = "PostItemTableViewCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        initViewModel()
        setupProfileHeader()
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initViewModel() {
        setupAnimation()
        viewModel.handleDataLoadComplete = { [unowned self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.spinner.removeFromSuperview()
                self.tableView.reloadData()
            }
        }
        
        viewModel.loadUserPost()
        
    }
}

extension UserPostVC {
    
    func setupView() {
        userName.text = viewModel.user?.name
        userName.alpha = 0
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: Constants.cellName, bundle: Bundle.main), forCellReuseIdentifier: Constants.cellName)
    }
    
    func setupProfileHeader() {
        if let user = viewModel.user {
            headerView.setUserInfo(of: user)
        }
        
        tableView.contentInset = UIEdgeInsets(top: 260, left: 0, bottom: 0, right: 0)
        view.addSubview(headerView)
        headerView.frame = CGRect(x: 0, y: 80, width: view.bounds.width, height: 250)
        headerView.setupAnimationView(animationName: "user-\(Int.random(in: 1 ... 10))")
    }
}

extension UserPostVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath) as! postCell
        let post = viewModel.posts[indexPath.row]
        cell.title = post.title
        cell.itemDescription = post.body
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 260 - (scrollView.contentOffset.y + 260)
        let h = max(0, y)
        headerView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: h)
        
        UIView.animate(withDuration: 0.3) {
            self.headerView.alpha = y < 227.0 ? 0 : 1
            self.userName.alpha = y < 227.0 ? 1 : 0
        }
    }
    
    func setupAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.spinner.translatesAutoresizingMaskIntoConstraints = false
            self.spinner.startAnimating()
            self.spinner.frame = self.view.bounds
            self.spinner.color = #colorLiteral(red: 0.03921568627, green: 0.1098039216, blue: 0.1882352941, alpha: 1)
            self.view.addSubview(self.spinner)
            self.spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
    }
}
