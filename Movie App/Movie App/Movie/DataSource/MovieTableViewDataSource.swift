//
//  MovieTableViewDataSource.swift
//  Movie App
//
//  Created by Phincon on 28/10/23.
//

import Foundation
import UIKit

class MovieTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : T!
    var configureCell : (CELL, Int) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, configureCell : @escaping (CELL, Int) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CELL else { return UITableViewCell() }

        self.configureCell(cell, indexPath.item)
        return cell
    }
    
}
