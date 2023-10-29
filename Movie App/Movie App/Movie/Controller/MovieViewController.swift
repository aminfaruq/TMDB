//
//  MovieViewController.swift
//  Movie App
//
//  Created by Phincon on 28/10/23.
//

import UIKit
import Combine

class MovieViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: MovieViewModel!
    private var dataSource: MovieTableViewDataSource<MovieViewCell, MovieResponse>!
    private var delegate: MovieTableViewDelegate!

    private var cancellables: Set<AnyCancellable> = []
    public var isTvSeries = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        bindViewModel()
    }
    
    private func setupTableView() {
        tableView.register(MovieViewCell.nib(), forCellReuseIdentifier: MovieViewCell.identifier())
    }
    
    private func setupViewModel() {
        viewModel = MovieViewModel(apiService: APIService<MovieResponse>(), contentType: isTvSeries ? .tvSeries : .movie)
        viewModel.fetchData()
    }
    
    private func bindViewModel() {
        if isTvSeries {
            viewModel.$airingTodayResponse
                .sink { [weak self] _ in
                    self?.updateDataSource()
                }
                .store(in: &cancellables)
            
            viewModel.$onTheAirResponse
                .sink { [weak self] _ in
                    self?.updateDataSource()
                }
                .store(in: &cancellables)
            
            viewModel.$popularResponse
                .sink { [weak self] _ in
                    self?.updateDataSource()
                }
                .store(in: &cancellables)
            
            viewModel.$topRatedResponse
                .sink { [weak self] _ in
                    self?.updateDataSource()
                }
                .store(in: &cancellables)
        } else {
            viewModel.$nowPlayingResponse
                .sink { [weak self] _ in
                    self?.updateDataSource()
                }
                .store(in: &cancellables)
            
            viewModel.$popularResponse
                .sink { [weak self] _ in
                    self?.updateDataSource()
                }
                .store(in: &cancellables)
            
            viewModel.$topRatedResponse
                .sink { [weak self] _ in
                    self?.updateDataSource()
                }
                .store(in: &cancellables)
            
            viewModel.$upcomingResponse
                .sink { [weak self] _ in
                    self?.updateDataSource()
                }
                .store(in: &cancellables)
        }
    }
    
    private func updateDataSource() {
        delegate = MovieTableViewDelegate(height: 250)
        dataSource = MovieTableViewDataSource(cellIdentifier: MovieViewCell.identifier()) { [weak self] (cell, indexPath) in
            guard let self = self else { return }
            
            switch indexPath {
            case 0:
                self.configureCell(cell, with: self.isTvSeries ? self.viewModel.airingTodayResponse?.results : self.viewModel.nowPlayingResponse?.results)
            case 1:
                self.configureCell(cell, with: self.isTvSeries ? self.viewModel.onTheAirResponse?.results : self.viewModel.popularResponse?.results)
            case 2:
                self.configureCell(cell, with: self.isTvSeries ? self.viewModel.popularResponse?.results : self.viewModel.topRatedResponse?.results)
            default:
                self.configureCell(cell, with:  self.isTvSeries ? self.viewModel.topRatedResponse?.results : self.viewModel.upcomingResponse?.results)
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.delegate = self.delegate
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
    
    private func configureCell(_ cell: MovieViewCell, with results: [Movie]?) {
        cell.titleLabel.text = cellReuseIdentifierForIndex(tableView.indexPath(for: cell)?.row)
        cell.stackView.removeSubViews()
        cell.stackView.addArrangedSubview(spacingView())
        
        results?.forEach { data in
            let view = MovieView()
            view.setupView()
            view.setupData(data: data, isTvSeries: isTvSeries)
            ImageHelper.getImagePublisher(url: data.posterPath ?? "")
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }, receiveValue: { image in
                    view.moviePosterImg.image = image
                })
                .store(in: &cancellables)
            
            cell.stackView.addArrangedSubview(view)
        }
        
        cell.stackView.addArrangedSubview(spacingView())
    }
    
    private func cellReuseIdentifierForIndex(_ index: Int?) -> String {
        switch index {
        case 0:
            return isTvSeries ? "Airing Today" :  "Now Playing"
        case 1:
            return isTvSeries ? "On The Air" : "Popular"
        case 2:
            return isTvSeries ? "Popular" : "Top Rated"
        default:
            return isTvSeries ? "Top Rated" : "Upcoming"
        }
    }
    
}
