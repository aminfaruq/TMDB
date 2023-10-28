//
//  API+Movie.swift
//  Movie App
//
//  Created by Phincon on 29/10/23.
//

import Foundation
import Combine

extension APIService {
    func fetchNowPlayingMovies() -> AnyPublisher<MovieResponse, Error> {
        return fetchData(from: "movie/now_playing?language=en-US&page=1")
    }
    
    func fetchPopularMovies() -> AnyPublisher<MovieResponse, Error> {
        return fetchData(from: "movie/popular?language=en-US&page=1")
    }

    func fetchTopRatedMovies() -> AnyPublisher<MovieResponse, Error> {
        return fetchData(from: "movie/top_rated?language=en-US&page=1")
    }

    func fetchUpcomingMovies() -> AnyPublisher<MovieResponse, Error> {
        return fetchData(from: "movie/upcoming?language=en-US&page=1")
    }
}
