//
//  API+Person.swift
//  Movie App
//
//  Created by Phincon on 29/10/23.
//

import Foundation
import Combine 

extension APIService {
    func fetchPersons(page: Int) -> AnyPublisher<ActorResponse, Error> {
        return fetchData(from: "person/popular?language=en-US&page=\(page)")
    }
}
