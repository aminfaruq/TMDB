//
//  PersonListViewController.swift
//  Movie App
//
//  Created by Phincon on 29/10/23.
//

import UIKit
import Combine

class PersonListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: PersonViewModel!
    private var dataSource: PersonTableViewDataSource<PersonViewCell, Actor>!
    private var delegate: PersonTableViewDelegate!
    private var cancellables: Set<AnyCancellable> = []

    var currentPage = 1
    var totalPages = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        bindViewModel()
    }
    
    private func setupTableView() {
        tableView.register(PersonViewCell.nib(), forCellReuseIdentifier: PersonViewCell.identifier())
    }
    
    @objc private func loadMoreData() {
        currentPage += 1
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.fetchPersons(page: currentPage, completion: {[weak self] (actorResponse) in
            self?.viewModel.actorResponse = actorResponse
            self?.updateDataSource()
            self?.totalPages = actorResponse?.totalPages ?? 1
        })
    }
    
    private func setupViewModel() {
        viewModel = PersonViewModel(apiService: APIService<ActorResponse>())
    }
    
    private func updateDataSource() {
        delegate = PersonTableViewDelegate(height: 120, configureWillDisplayCell: {
            if ((self.tableView.contentOffset.y + self.tableView.frame.size.height) >= self.tableView.contentSize.height) {
                if self.currentPage < self.totalPages {
                    self.loadMoreData()
                }
            }
           
        })
        dataSource = PersonTableViewDataSource(cellIdentifier: PersonViewCell.identifier(), items: self.viewModel.actorResponse?.results ?? [], configureCell: { (cell, data) in
            cell.setupView(data: data)
        })
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate = self.delegate
            self.tableView.reloadData()
        }
    }
}
