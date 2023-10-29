//
//  PersonTableViewDataSource.swift
//  Movie App
//
//  Created by Phincon on 29/10/23.
//

import Foundation
import UIKit

class PersonTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CELL else { return UITableViewCell() }

        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        return cell
    }
    
}
    
class PersonTableViewDelegate : NSObject , UITableViewDelegate {
    private var height : CGFloat!
    var configureWillDisplayCell : () -> () = { }
    
    init(height: CGFloat, configureWillDisplayCell : @escaping () -> ()) {
        self.height = height
        self.configureWillDisplayCell = configureWillDisplayCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        configureWillDisplayCell()
    }
}

