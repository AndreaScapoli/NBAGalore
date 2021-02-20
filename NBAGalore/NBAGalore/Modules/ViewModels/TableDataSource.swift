//
//  TableDataSource.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 20/02/21.
//

import UIKit

class TableDataSource<Cell: PlayerTableViewCell,T>: NSObject, UITableViewDataSource {

    //MARK: Properties
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (Cell, T) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (Cell, T) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
        
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        
        return cell
    }
    
}
