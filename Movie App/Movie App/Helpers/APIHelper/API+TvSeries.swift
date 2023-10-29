//
//  API+TvSeries.swift
//  Movie App
//
//  Created by Phincon on 29/10/23.
//

import Foundation
import Combine

extension APIService {
    func fetchAiringTodaySeries() -> AnyPublisher<MovieResponse, Error> {
        return fetchData(from: "tv/airing_today?language=en-US&page=1")
    }
    
    func fetchOnTheAirSeries() -> AnyPublisher<MovieResponse, Error> {
        return fetchData(from: "tv/on_the_air?language=en-US&page=1")
    }
    
    func fetchPopularSeries() -> AnyPublisher<MovieResponse, Error> {
        return fetchData(from: "tv/popular?language=en-US&page=1")
    }
    
    func fetchTopRatedSeries() -> AnyPublisher<MovieResponse, Error> {
        return fetchData(from: "tv/top_rated?language=en-US&page=1")
    }
}
