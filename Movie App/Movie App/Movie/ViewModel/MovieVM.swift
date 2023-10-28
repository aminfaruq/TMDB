//
//  MovieVM.swift
//  Movie App
//
//  Created by Phincon on 28/10/23.
//

import Foundation
import UIKit
import Combine


class MovieVM : NSObject {
    private let apiService: APIService
    
    @Published var nowPlayingResponse: MovieResponse?
    @Published var popularResponse: MovieResponse?
    @Published var topRatedResponse: MovieResponse?
    @Published var upcomingResponse: MovieResponse?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func callFuncToGetMovieData() {
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
    
}
