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
    
    private var collectionView: UICollectionView!
    
    private let refreshControl = UIRefreshControl()
    
    private let bottomView: ButtomView = ButtomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupNavigationItem()
        self.setupRefreshControl()
        self.setupCollectionView()
        self.setupBottomView()
        self.setupViewModel()
        self.layout()
        self.update()
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
            self?.collectionView.reloadData()
            
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
        
        self.update()
        
    }
    
    private func update() {
        
        self.viewModel.update()
        
    }
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.backgroundColor = .systemGroupedBackground
        
        self.collectionView.refreshControl = refreshControl
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(UINib(nibName: "HotelHeaderCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HotelHeaderCollectionCell")
        
    }
    
    private func setupBottomView() {
        
        self.bottomView.primaryButton.setTitle("К выбору номера", for: .normal)
        
    }
    
    private func layout() {
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(collectionView)
        self.view.addSubview(bottomView)
        
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.bottomView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.bottomView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        self.bottomView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }


}

extension HotelViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewModel.hotel == nil { return 0 }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelHeaderCollectionCell", for: indexPath) as? HotelHeaderCollectionCell else {
            return UICollectionViewCell()
        }
        
        if let hotel = self.viewModel.hotel {
            cell.setup(hotel: hotel)
        }
        
        return cell
        
    }
    
    
    
}

extension HotelViewController: UICollectionViewDelegateFlowLayout {
    
}

