//
//  PersonViewModel.swift
//  Movie App
//
//  Created by Phincon on 29/10/23.
//

import Foundation
import Combine

class PersonViewModel: NSObject {
    private let apiService: APIService<ActorResponse>
    private var cancellables = Set<AnyCancellable>()
    
    
    @Published var actorResponse: ActorResponse?
    
    init(apiService: APIService<ActorResponse>) {
        self.apiService = apiService
    }
    
    func fetchPersons(page: Int, completion: @escaping (ActorResponse?) -> Void) {
        apiService.fetchPersons(page: page)
            .sink(receiveCompletion: { _ in }) { actorData in
                completion(actorData)
            }
            .store(in: &cancellables)
    }

}
