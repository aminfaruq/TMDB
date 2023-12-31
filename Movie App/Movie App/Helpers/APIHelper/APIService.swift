//
//  API+Extension.swift
//  Movie App
//
//  Created by Phincon on 28/10/23.
//

import Foundation
import Combine

class APIService<T> {
    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "5ba01fa664bad862f5c8f6cbbec5f291"
    private let headers: [String: String] = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YmEwMWZhNjY4YmFkODY2YjVjOGY2Y2JiZWM1ZjI5MSIsInN1YiI6IjVjMzA1Y2QxOTI1MTQxNmQ5NDZmMzcyNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JE_61sIEpt4O2VzmJ1rG8ER5SqU4QjdUExTi-1mj2Nw"
    ]

    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    private var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        config.waitsForConnectivity = true
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }()
    
    private func fetchDataPublisher(from endpoint: String) -> AnyPublisher<Data, URLError> {
        let urlString = baseURL + endpoint + "&api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        return session.dataTaskPublisher(for: request)
            .map(\.data) // Extract only the data from the response
            .eraseToAnyPublisher()
    }
    
    func fetchData<T: Decodable>(from endpoint: String) -> AnyPublisher<T, Error> {
        return fetchDataPublisher(from: endpoint)
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
