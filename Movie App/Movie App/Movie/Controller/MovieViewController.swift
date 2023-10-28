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
    private var viewModel: MovieVM!
    private var dataSource: MovieTableViewDataSource<MovieViewCell, MovieResponse>!
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        bindViewModel()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.register(MovieViewCell.nib(), forCellReuseIdentifier: MovieViewCell.identifier())
    }
    
    func setupViewModel() {
        viewModel = MovieVM(apiService: APIService())
        viewModel.callFuncToGetMovieData()
    }
    
    func bindViewModel() {
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
    
    func updateDataSource() {
        dataSource = MovieTableViewDataSource(cellIdentifier: MovieViewCell.identifier()) { [weak self] (cell, indexPath) in
            guard let self = self else { return }
            
            switch indexPath {
            case 0:
                self.configureCell(cell, with: self.viewModel.nowPlayingResponse?.results)
            case 1:
                self.configureCell(cell, with: self.viewModel.popularResponse?.results)
            case 2:
                self.configureCell(cell, with: self.viewModel.topRatedResponse?.results)
            default:
                self.configureCell(cell, with: self.viewModel.upcomingResponse?.results)
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
    
    func configureCell(_ cell: MovieViewCell, with results: [Movie]?) {
        cell.titleLabel.text = cellReuseIdentifierForIndex(tableView.indexPath(for: cell)?.row)
        cell.stackView.removeSubViews()
        cell.stackView.addArrangedSubview(spacingView())
        
        results?.forEach { data in
            let view = MovieView()
            view.setupView()
            view.movieTitleLbl.text = data.originalTitle
            view.movieRatingLbl.text = "\(data.voteAverage ?? 0.0)"
            view.movieReleaseLbl.text = data.releaseDate
            
            ImageHelper.getImage(url: data.posterPath ?? "") { image, error in
                if let image = image {
                    DispatchQueue.main.async {
                        view.moviePosterImg.image = image
                    }
                } else if let error = error {
                    print("Error getting image: \(error)")
                }
            }
            
            cell.stackView.addArrangedSubview(view)
        }
        
        cell.stackView.addArrangedSubview(spacingView())
    }
    
    func spacingView() -> UIView {
        let spacingView = UIView()
        spacingView.backgroundColor = .clear
        spacingView.translatesAutoresizingMaskIntoConstraints = false
        spacingView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return spacingView
    }
    
    func cellReuseIdentifierForIndex(_ index: Int?) -> String {
        switch index {
        case 0:
            return "Now Playing"
        case 1:
            return "Popular"
        case 2:
            return "Top Rated"
        default:
            return "Upcoming"
        }
    }
    
}

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}

