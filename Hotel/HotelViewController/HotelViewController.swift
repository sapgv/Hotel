//
//  HotelViewController.swift
//  Hotel
//
//  Created by Grigory Sapogov on 25.12.2023.
//

import UIKit

class HotelViewController: UIViewController {

    var viewModel: HotelViewModel!
    
    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupNavigationItem()
        self.setupRefreshControl()
        self.setupTableView()
        self.setupViewModel()
        self.layout()
    }
    
    private func setupViewModel() {
        
        self.viewModel.updateCompletion = { [weak self] error in

            defer {
                self?.refreshControl.endRefreshing()
            }
            
            if let error = error {
                print(error)
                return
            }
            
            self?.tableView.reloadData()
            
        }
        
        
    }
    
    private func setupNavigationItem() {
    
        let navigationItemView = NavigationItemView()
        navigationItemView.titleLabel.text = "Отель"
        
        self.navigationItem.titleView = navigationItemView
        
    }
    
    private func setupRefreshControl() {
        
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }
    
    @objc
    private func refresh() {
        
        self.viewModel.update()
        
    }
    
    private func setupTableView() {
        
        self.tableView.refreshControl = refreshControl
        
        
    }
    
    private func layout() {
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableView)
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }


}

