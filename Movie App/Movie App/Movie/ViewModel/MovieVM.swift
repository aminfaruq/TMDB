//
//  MovieVM.swift
//  Movie App
//
//  Created by Phincon on 28/10/23.
//

import Foundation
import Combine

enum ContentType {
    case movie
    case tvSeries
}

class MovieViewModel: NSObject {
    private let apiService: APIService<MovieResponse>
    private var cancellables = Set<AnyCancellable>()
    var contentType: ContentType
    
    @Published var nowPlayingResponse: MovieResponse?
    @Published var popularResponse: MovieResponse?
    @Published var topRatedResponse: MovieResponse?
    @Published var upcomingResponse: MovieResponse?
    @Published var airingTodayResponse: MovieResponse?
    @Published var onTheAirResponse: MovieResponse?
    
    init(apiService: APIService<MovieResponse>, contentType: ContentType) {
        self.apiService = apiService
        self.contentType = contentType
    }
    
    func fetchData() {
        switch contentType {
        case .movie:
            fetchMovies()
        case .tvSeries:
            fetchTVSeries()
        }
    }
    
    private func fetchMovies() {
        apiService.fetchNowPlayingMovies()
            .sink(receiveCompletion: { _ in }) { [weak self] empData in
                self?.nowPlayingResponse = empData
            }
            .store(in: &cancellables)
        
        apiService.fetchPopularMovies()
            .sink(receiveCompletion: { _ in }) { [weak self] empData in
                self?.popularResponse = empData
            }
            .store(in: &cancellables)
        
        apiService.fetchTopRatedMovies()
            .sink(receiveCompletion: { _ in }) { [weak self] empData in
                self?.topRatedResponse = empData
            }
            .store(in: &cancellables)
        
        apiService.fetchUpcomingMovies()
            .sink(receiveCompletion: { _ in }) { [weak self] empData in
                self?.upcomingResponse = empData
            }
            .store(in: &cancellables)
    }
    
    private func fetchTVSeries() {
        apiService.fetchAiringTodaySeries()
            .sink(receiveCompletion: { _ in }) { [weak self] empData in
                self?.airingTodayResponse = empData
            }
            .store(in: &cancellables)
        
        apiService.fetchOnTheAirSeries()
            .sink(receiveCompletion: { _ in }) { [weak self] empData in
                self?.onTheAirResponse = empData
            }
            .store(in: &cancellables)
        
        apiService.fetchPopularSeries()
            .sink(receiveCompletion: { _ in }) { [weak self] empData in
                self?.popularResponse = empData
            }
            .store(in: &cancellables)
        
        apiService.fetchTopRatedSeries()
            .sink(receiveCompletion: { _ in }) { [weak self] empData in
                self?.topRatedResponse = empData
            }
            .store(in: &cancellables)
    }
    
}
